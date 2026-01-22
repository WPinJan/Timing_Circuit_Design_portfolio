`timescale 1ns / 100ps
module testbench;

    localparam period = 20;
    localparam delay = 10;

    reg [9:0] lambda;
    wire      clk_out;
    reg       e;

    dco dco (
        .clk_out(clk_out),
        .lambda(lambda),
        .e(e)
    );

    initial begin
        $fsdbDumpfile("../4.Simulation_Result/dco_rtl.fsdb");
        $fsdbDumpvars;
    end

 
    initial begin
        e = 0;
        #(period) lambda = 10'b0000000001;
        #(period * 2) e = 1;
        #(period * 5) lambda = 10'b0000000010;
        #(period * 5) lambda = 10'b0000000100;
        #(period * 5) lambda = 10'b0000001000;
        #(period * 5) lambda = 10'b0000010000;
        #(period * 5) lambda = 10'b0000100000;
        #(period * 5) lambda = 10'b0001000000;
        #(period * 5) lambda = 10'b0010000000;
        #(period * 5) lambda = 10'b0100000000;
        #(period * 5) lambda = 10'b1000000000;

        #(period * 5) e = 0;
        #(period * 5) $finish;
    end

    // Automatically finish
    initial begin
        #3000;
        $finish;
    end

endmodule
