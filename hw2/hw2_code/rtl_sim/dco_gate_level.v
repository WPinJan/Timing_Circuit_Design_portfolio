module buffer_15 ( out, in );
  input in;
  output out;
  wire n1;
  CLKBUFX3 U0 ( .A(in), .Y(n1)  );
  CLKBUFX3 U1 ( .A(n1), .Y(out)  );

endmodule


module dco ( clk_out, lambda, lambda_bar, e );
  input [7:0] lambda;
  input e;
  input [7:0] lambda_bar;
  output clk_out;
  wire   clk_1, clk_2, clk_3, clk_4, clk_5, clk_6, clk_7, clk_8, en_clk,
         clk_2_2, clk_3_2, clk_4_2, clk_5_2,clk_6_2, clk_7_2, clk_8_2, clk_preout;

  CLKNAND2X2 U1 ( .A(e), .B(clk_preout), .Y(en_clk) );
  buffer_15 bc1 ( .out(clk_1), .in(en_clk) );
  buffer_15 bc2 ( .out(clk_2), .in(clk_1) );
  buffer_15 bc3 ( .out(clk_3), .in(clk_2) );
  buffer_15 bc4 ( .out(clk_4), .in(clk_3) );
  buffer_15 bc5 ( .out(clk_5), .in(clk_4) );
  buffer_15 bc6 ( .out(clk_6), .in(clk_5) );
  buffer_15 bc7 ( .out(clk_7), .in(clk_6) );
  buffer_15 bc8 ( .out(clk_8), .in(clk_7) );

  TBUFX4 buf_1 (.A(clk_1), .Y(clk_preout), .OE(lambda[0]));
  TBUFX4 buf_2 (.A(clk_2), .Y(clk_2_2), .OE(lambda[1]));
  TBUFX4 buf_2_2 (.A(clk_2_2), .Y(clk_preout), .OE(lambda_bar[0]));
  TBUFX4 buf_3 (.A(clk_3), .Y(clk_3_2), .OE(lambda[2]));
  TBUFX4 buf_3_2 (.A(clk_3_2), .Y(clk_2_2), .OE(lambda_bar[1]));
  TBUFX4 buf_4 (.A(clk_4), .Y(clk_4_2), .OE(lambda[3]));
  TBUFX4 buf_4_2 (.A(clk_4_2), .Y(clk_3_2), .OE(lambda_bar[2]));
  TBUFX4 buf_5 (.A(clk_5), .Y(clk_5_2), .OE(lambda[4]));
  TBUFX4 buf_5_2 (.A(clk_5_2), .Y(clk_4_2), .OE(lambda_bar[3]));
  TBUFX4 buf_6 (.A(clk_6), .Y(clk_6_2), .OE(lambda[5]));
  TBUFX4 buf_6_2 (.A(clk_6_2), .Y(clk_5_2), .OE(lambda_bar[4]));
  TBUFX4 buf_7 (.A(clk_7), .Y(clk_7_2), .OE(lambda[6]));
  TBUFX4 buf_7_2 (.A(clk_7_2), .Y(clk_6_2), .OE(lambda_bar[5]));
  TBUFX4 buf_8 (.A(clk_8), .Y(clk_8_2), .OE(lambda[7]));
  TBUFX4 buf_8_2 (.A(clk_8_2), .Y(clk_7_2), .OE(lambda_bar[6]));

  CLKBUFX6 buf_out (.A(clk_preout), .Y(clk_out));


endmodule
