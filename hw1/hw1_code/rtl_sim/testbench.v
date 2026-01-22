`timescale 1ns / 100ps
module testbench;

    localparam period = 2;
    localparam delay = 1;

    wire [9:0] y;
    wire [3:0] x;
    wire        done;
    reg         clk;
    reg         rst_n;
    reg   [9:0] y_t;
    reg        start;

    sa sa (
        .y(y),
        .x(x),
        .done(done),
        .clk(clk),
        .rst_n(rst_n),
        .y_t(y_t),
        .start(start)
    );

    initial begin
        $fsdbDumpfile("../4.Simulation_Result/sa_rtl.fsdb");
        $fsdbDumpvars;
    end

    always #(period / 2) clk = ~clk;

    initial begin
        clk = 1;
        rst_n = 1;
        start = 0;
        y_t = 0;
        #(period + delay) rst_n = 0;
        #(period * 2) rst_n = 1;
        #(period) y_t = 630;
		#(period) start = 1;
        #(period) start = 0;
        @(negedge done);

        @(posedge clk);
		#(period) y_t = 780;
        #(period) start = 1;
        #(period) start = 0;
        @(negedge done);

        @(posedge clk);
        #(delay * 3) rst_n = 0;
        #(period * 8) $finish;
    end

    // Automatically finish
    initial begin
        #200;
        $finish;
    end

endmodule
