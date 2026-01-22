`timescale 100ps / 10ps
module testbench;

    localparam period = 10;
    localparam delay = 4;

    reg       clk;
    wire      clk_dcc;
    reg       rst_n;
	wire      locked;

    dcc u_dcc (
        .clk_dcc(clk_dcc),
        .locked(locked),
        .clk(clk),
		.rst_n(rst_n)
    );

    initial begin
		$sdf_annotate("./dcc_syn.sdf", u_dcc);
        $fsdbDumpfile("../4.Simulation_Result/dcc_syn.fsdb");
        $fsdbDumpvars;
    end

 
  initial begin
    clk = 1;
    forever begin
      #(3)  clk = 0;
      #(7) clk = 1;
    end
  end

  initial begin
        rst_n = 1;
        #(delay) rst_n = 0;
        #(period) rst_n = 1;
		wait(locked);

        #(period * 6) $finish;
    end

    // Automatically finish
    initial begin
        #30000;
        $finish;
    end

endmodule
