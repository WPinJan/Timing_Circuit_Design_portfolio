`include "tdl.v"

module dcc (
    output  clk_dcc,
    output  locked,
    input   clk,
	input   rst_n
);

///////////////////////
//DECLARATION
///////////////////////
//TDL signals
wire clk_fp, clk_hp;
reg  [7:0] lambda;
reg  [7:0] lambda_bar;
reg  [7:0] lambda_next, lambda_prenext;
wire [7:0] lambda_bar_next, lambda_bar_prenext;
reg  [2:0]  x;

//PD signals
wire direction;
reg  clk_dff;
reg  clk_fp_dff;
wire rst_pd;
wire rst_pd_flag;
wire pd_en;
wire pd_dummy;
wire racing_s, racing_r;
wire locker_s, locker_r;

//one shot circuit
reg clk_in_os, clk_hp_os;
wire rst_os1, rst_os2;
wire clk_b1, clk_b2;

//output SR latch
wire q, q_bar;

//state
localparam ST_INIT    = 3'b000;
localparam ST_X_CODE  = 3'b001;
localparam ST_L_PRE   = 3'b010;
localparam ST_L_CODE  = 3'b011;
localparam ST_COMP    = 3'b100;

localparam ST_DONE    = 3'b110;

reg   [2:0] state;
reg   [2:0] state_nx;

///////////////////////
//FSM
///////////////////////
//setting next state
always@(posedge clk or negedge rst_n)begin
   if(~rst_n)  state <= ST_INIT;
   else        state <= state_nx;
end

//decision of next state
always@(*)begin
   state_nx = state;
   case(state)
   ST_INIT  : state_nx = ST_COMP;
   ST_X_CODE : 
   begin
	   if(direction) state_nx = ST_L_PRE;
	   else state_nx = ST_DONE;
   end
   ST_L_PRE : state_nx = ST_L_CODE;
   ST_L_CODE : state_nx = ST_COMP;
   ST_COMP  : state_nx = ST_X_CODE;

   ST_DONE  : state_nx = state;
   default  : state_nx = state;
   endcase
end

//output controlled by FSM
assign locked = (state == ST_DONE);
assign pd_en = (state==ST_COMP);   //for PD

///////////////////////
//Searching process
///////////////////////
//lambda code decision - x value
always@(posedge clk or negedge rst_n) begin
	if(~rst_n)    x <= 3'b000;
	else begin
		case(state)
			ST_INIT  : x <= 3'b000;
			ST_X_CODE  : 
				begin
					if(direction) x <= x + 1;
					else x <= x;    //or x-1
				end
			ST_L_PRE, ST_L_CODE, ST_COMP, ST_DONE  : x <= x;
			default  : x <= x;
		endcase
	end  
end


//lambda comb. logic
always@(*) begin
	case(x)
		3'b000: lambda_next = 8'b00000001;
		3'b001: lambda_next = 8'b00000010;
		3'b010: lambda_next = 8'b00000100;
		3'b011: lambda_next = 8'b00001000;
		3'b100: lambda_next = 8'b00010000;
		3'b101: lambda_next = 8'b00100000;
		3'b110: lambda_next = 8'b01000000;
		3'b111: lambda_next = 8'b10000000;
		default: lambda_next = 8'b00000010;
	endcase
end

assign lambda_bar_next = ~ lambda_next;

always@(*) begin
	case(x)
		3'b000: lambda_prenext = 8'b00000001;
		3'b001: lambda_prenext = 8'b00000011;
		3'b010: lambda_prenext = 8'b00000110;
		3'b011: lambda_prenext = 8'b00001100;
		3'b100: lambda_prenext = 8'b00011000;
		3'b101: lambda_prenext = 8'b00110000;
		3'b110: lambda_prenext = 8'b01100000;
		3'b111: lambda_prenext = 8'b11000000;
		default: lambda_prenext = 8'b00000011;
	endcase
end

assign lambda_bar_prenext = ~ lambda_prenext;


//lambda update
always@(posedge clk or negedge rst_n) begin
	if(~rst_n) begin 
		lambda <= 8'b00000001;
		lambda_bar <= 8'b11111110;
	end
	else begin
		case(state)
			ST_INIT          : begin 
			lambda <= 8'b00000001;
			lambda_bar <= 8'b11111110;
			end
			ST_X_CODE, ST_COMP, ST_DONE : begin 
			lambda <= lambda;
			lambda_bar <= lambda_bar;
			end
			ST_L_PRE  : begin 
			lambda <= lambda_prenext;
			lambda_bar <= lambda_bar_prenext;
			end
			ST_L_CODE  : begin 
			lambda <= lambda_next;
			lambda_bar <= lambda_bar_next;
			end
			default          : begin 
			lambda <= lambda;
			lambda_bar <= lambda_bar;
			end
		endcase
	end  
end


///////////////////////
//Phase Detector
///////////////////////
//PD
always @(posedge clk_fp or negedge rst_pd) begin
	if(~rst_pd) clk_fp_dff <= 0;
	else clk_fp_dff <= 1;
end

always @(posedge clk or negedge rst_pd) begin
	if(~rst_pd) clk_dff <= 0;
	else clk_dff <= 1;
end

assign rst_pd_flag = ~ (clk_fp_dff & clk_dff);
assign pd_dummy = ~(clk_dff & clk_fp_dff);
assign rst_pd = pd_en & rst_pd_flag;

//SR latch as racing circuit
assign racing_s = ~ (racing_r & clk_fp_dff);
assign racing_r = ~ (racing_s & clk_dff);

//SR latch as signal locker
assign locker_s = ~ (locker_r & racing_s);
assign locker_r = ~ (locker_s & racing_r);

//direction = 1 if clk_fp is faster, which means we need to tune a longer delay
assign direction = locker_s;

///////////////////////
//One Shot Circuit
///////////////////////
//one-shot-based osc. 1
always @(posedge clk or negedge rst_os1 or negedge rst_n) begin
	if(~rst_n) clk_in_os <= 0;
	else if(~rst_os1) clk_in_os <= 0;
	else clk_in_os <= 1;
end 

delay_buffer ub_1 (.out(clk_b1), .in (clk_in_os));
assign rst_os1 = ~clk_b1;

//one-shot-based osc. 2
always @(posedge clk_hp or negedge rst_os2 or negedge rst_n) begin
	if(~rst_n) clk_hp_os <= 0;
	else if(~rst_os2) clk_hp_os <= 0;
	else clk_hp_os <= 1;
end 

delay_buffer ub_2 (.out(clk_b2), .in (clk_hp_os));
assign rst_os2 = ~clk_b2;


///////////////////////
//Tunable Delay Line
///////////////////////
//instantiate
tdl tdl_1 (
    .clk_out (clk_hp),
	.clk_in  (clk),
    .lambda  (lambda),
    .lambda_bar (lambda_bar)
);

tdl tdl_2 (
    .clk_out (clk_fp),
	.clk_in  (clk_hp),
    .lambda  (lambda),
    .lambda_bar (lambda_bar)
);

///////////////////////
//Output Stage SR Latch
///////////////////////
assign q_bar = ~ (clk_in_os | q);
assign q = ~ (clk_hp_os | q_bar);

assign clk_dcc = q;


endmodule
