`timescale 1ns / 10ps
module testbench;

    localparam period = 10;
    localparam delay = 10;

    reg       clk;
    wire      clk_out;
    reg       rst_n;
	wire      locked;

    pll u_pll (
        .clk_out(clk_out),
        .locked(locked),
        .clk(clk),
		.rst_n(rst_n)
    );

    initial begin
		$sdf_annotate("./pll_syn.sdf", u_pll);
        $fsdbDumpfile("../4.Simulation_Result/pll_syn.fsdb");
        $fsdbDumpvars;
    end

    always #(period / 2) clk = ~clk;

    initial begin
		clk = 1;
        rst_n = 1;
        #(period) rst_n = 0;
        #(period) rst_n = 1;
		wait(locked);

        #(period * 5) $finish;
    end

    // Automatically finish
    initial begin
        #30000;
        $finish;
    end

endmodule
