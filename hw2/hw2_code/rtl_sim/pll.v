`include "dco.v"

module pll (
    output  clk_out,
    output  locked,
    input   clk,
	input   rst_n
);

///////////////////////
//DECLARATION
///////////////////////
//output
wire clk_out_r;

//signals controlling DCO
wire osc_en;  //actually in PD
reg  start;
reg  [7:0] lambda;
reg  [7:0] lambda_bar;
reg  [7:0] lambda_next;
wire [7:0] lambda_bar_next;
reg  [2:0]  x;

//PD signals
wire direction;
reg  clk_ref;
wire clk_ref_b1;
reg  clk_ref_dff;
reg  clk_div_dff;
wire rst_ko;
wire rst_pd;
wire rst_pd_flag;
wire pd_en;
wire pd_dummy;
wire racing_s, racing_r;
wire locker_s, locker_r;

//freq. divider signals
wire clk_div;
reg  [5:0] clk_shift;
genvar i;

//state
localparam ST_INIT          = 3'b000;
localparam ST_ENABLE        = 3'b001;
localparam ST_FREQ_COMP     = 3'b010;
localparam ST_CODE_DECISION = 3'b011;
localparam ST_CODE_CONVERT  = 3'b100;
localparam ST_DONE          = 3'b101;

reg   [2:0] state;
reg   [2:0] state_nx;

//count index
reg   [1:0] cnt;        //發生兩次SA運算
wire  [1:0] cnt_next, cnt_new;
wire        cnt_en;

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
   ST_INIT          : state_nx = ST_ENABLE;
   ST_ENABLE        : state_nx = ST_FREQ_COMP;
   ST_FREQ_COMP     : state_nx = ST_CODE_DECISION;
   ST_CODE_DECISION : state_nx = ST_CODE_CONVERT;
   ST_CODE_CONVERT  : begin
	   if(cnt==0) state_nx = ST_DONE;
	   else state_nx = ST_ENABLE;
   end
   ST_DONE          : state_nx = state;
   default          : state_nx = state;
   endcase
end

//output controlled by FSM
assign locked = (state == ST_DONE);

//control signal
assign osc_en = (state == ST_ENABLE || state == ST_FREQ_COMP || state ==ST_DONE);

//counter
assign cnt_en   = (state == ST_CODE_DECISION);
assign cnt_next = cnt - 2'b1;
assign cnt_new  = cnt_en? cnt_next: cnt;

always@(posedge clk or negedge rst_n)begin
   if(~rst_n)     cnt <= 2'b10;
   else           cnt <= cnt_new;
end


///////////////////////
//Successive Approximation
///////////////////////
//lambda code decision - x value
always@(posedge clk or negedge rst_n) begin
	if(~rst_n)    x <= 3'b100;
	else begin
		case(state)
			ST_INIT          : x <= 3'b100;
			ST_ENABLE        : x <= x;
			ST_FREQ_COMP     : x <= x;
			ST_CODE_DECISION :
					begin
						x[cnt_next] <= 1;
						if (~direction) x[cnt] <= 0;
						else x[cnt] <= x[cnt];
					end
			ST_CODE_CONVERT: x <= x;
			ST_DONE  : x <= x;
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


//lambda update
always@(posedge clk or negedge rst_n) begin
	if(~rst_n) begin 
		lambda <= 8'b00010000;
		lambda_bar <= 8'b11101111;
	end
	else begin
		case(state)
			ST_INIT          : begin 
			lambda <= 8'b00010000;
			lambda_bar <= 8'b11101111;
			end
			ST_ENABLE, ST_FREQ_COMP, ST_CODE_DECISION, ST_DONE : begin 
			lambda <= lambda;
			lambda_bar <= lambda_bar;
			end
			ST_CODE_CONVERT  : begin 
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
//Frequency Divider
///////////////////////
//shift register
generate
	for(i=1; i<6; i=i+1) begin: CLK_DIVIDER
		always @(posedge clk_out or negedge start) begin
			if (!start)     clk_shift[i] <= 1'b1;
			else            clk_shift[i] <= clk_shift[i-1];
		end
	end
endgenerate

always @(*) begin
   clk_shift[0] = ~clk_shift[5];
end

assign clk_div = clk_shift[5];



///////////////////////
//Phase Detector
///////////////////////
//kick-off circuit for "start" signal
always @(posedge clk or negedge rst_n) begin
	if(~rst_n) start <= 0;
	else if (state == ST_INIT) start <= 0;
	else if (osc_en) start <= 1;
	else start <= 0;
end

//one-shot-based osc. for dummy delay
always @(posedge clk or negedge rst_ko or negedge rst_n) begin
	if(~rst_n) clk_ref <= 0;
	else if(~rst_ko) clk_ref <= 0;
	else clk_ref <= 1;
end 

buffer_15 ub_1 (.out(clk_ref_b1), .in (clk_ref));
assign rst_ko = ~clk_ref_b1;

//PD
always @(posedge clk_div or negedge rst_pd) begin
	if(~rst_pd) clk_div_dff <= 0;
	else clk_div_dff <= 1;
end

always @(posedge clk_ref or negedge rst_pd) begin
	if(~rst_pd) clk_ref_dff <= 0;
	else clk_ref_dff <= 1;
end

assign rst_pd_flag = ~ (clk_div_dff & clk_ref_dff);
assign pd_dummy = ~(clk_ref_dff & clk_div_dff);
assign rst_pd = pd_en & rst_pd_flag;
assign pd_en = start;

//SR latch as racing circuit
assign racing_s = ~ (racing_r & clk_div_dff);
assign racing_r = ~ (racing_s & clk_ref_dff);

//SR latch as signal locker
assign locker_s = ~ (locker_r & racing_s);
assign locker_r = ~ (locker_s & racing_r);

//direction = 1 if clk_div is faster, which means we need to lower the freq. of dco.
assign direction = locker_s;

///////////////////////
//Digital Controlled Oscillator
///////////////////////
//instantiate
dco u_dco (
    .clk_out (clk_out_r),
    .lambda  (lambda),
    .lambda_bar (lambda_bar),
    .e  (start)
);

assign clk_out = clk_out_r;

endmodule
