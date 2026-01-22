module sa (
    output [9:0] y,
    output reg [3:0] x,
    output       done,
    input        clk,
    input        rst_n,
    input  [9:0] y_t,
    input        start
);

///////////////////////
//DECLARATION
///////////////////////
//state
localparam ST_IDLE = 2'b00;
localparam ST_SA = 2'b01;
localparam ST_DONE = 2'b10;

reg   [1:0] state;
reg   [1:0] state_nx;

//control signals
wire        more_less;

//count index
reg   [1:0] cnt;        //發生三次SA運算
wire  [1:0] cnt_next;
wire        cnt_en;
wire        cnt_clear;
wire        cnt_next_full;

///////////////////////
//FSM
///////////////////////
//setting next state
always@(posedge clk or negedge rst_n)begin
   if(~rst_n)  state <= ST_IDLE;
   else        state <= state_nx;
end

//decision of next state
always@(*)begin
   state_nx = state;
   case(state)
   ST_IDLE   : if(start)       state_nx = ST_SA;
   ST_SA     : if(cnt == 2'b01)  state_nx = ST_DONE;
   ST_DONE   : state_nx = ST_IDLE;
   default: state_nx = state;
   endcase
end

//output controlled by FSM
assign done = (state == ST_DONE);

//counter
assign cnt_en        = (state == ST_SA);
assign cnt_clear     = (state == ST_DONE);
assign cnt_next      = cnt_en? cnt-2'b1: cnt;

always@(posedge clk or negedge rst_n)begin
   if(~rst_n)     cnt <= 2'b11;
   else if(cnt_clear) cnt <= 2'b11;
   else           cnt <= cnt_next;
end

///////////////////////
//Successive Approximation
///////////////////////
//x value decision
always@(posedge clk or negedge rst_n) begin
	if(~rst_n)    x <= 4'b1000;
	else begin
		case(state)
			ST_IDLE  : x <= 4'b1000;
			ST_SA    :
					begin
						x[cnt_next] <= 1;
						if (~more_less) x[cnt] <= 0;
						else x[cnt] <= x[cnt];
					end
			ST_DONE  : x <= x;
			default  : x <= x;
		endcase
	end
end

//more_less
assign more_less = (y > y_t)? 1 : 0;

//y assignment
assign y = 10'd1000 - (5'd30 * x);


endmodule
