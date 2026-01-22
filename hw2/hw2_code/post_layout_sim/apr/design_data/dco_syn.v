/////////////////////////////////////////////////////////////
// Created by: Synopsys DC Expert(TM) in wire load mode
// Version   : R-2020.09-SP5
// Date      : Fri Nov 14 12:41:02 2025
/////////////////////////////////////////////////////////////


module buffer_15_9 ( out, in );
  input in;
  output out;


  CLKBUFX2 U1 ( .A(in), .Y(out) );
endmodule


module buffer_15_0 ( out, in );
  input in;
  output out;


  CLKBUFX2 U1 ( .A(in), .Y(out) );
endmodule


module buffer_15_1 ( out, in );
  input in;
  output out;


  CLKBUFX2 U1 ( .A(in), .Y(out) );
endmodule


module buffer_15_2 ( out, in );
  input in;
  output out;


  CLKBUFX2 U1 ( .A(in), .Y(out) );
endmodule


module buffer_15_3 ( out, in );
  input in;
  output out;


  CLKBUFX2 U1 ( .A(in), .Y(out) );
endmodule


module buffer_15_4 ( out, in );
  input in;
  output out;


  CLKBUFX2 U1 ( .A(in), .Y(out) );
endmodule


module buffer_15_5 ( out, in );
  input in;
  output out;


  CLKBUFX2 U1 ( .A(in), .Y(out) );
endmodule


module buffer_15_6 ( out, in );
  input in;
  output out;


  CLKBUFX2 U1 ( .A(in), .Y(out) );
endmodule


module buffer_15_7 ( out, in );
  input in;
  output out;


  CLKBUFX2 U1 ( .A(in), .Y(out) );
endmodule


module buffer_15_8 ( out, in );
  input in;
  output out;


  CLKBUFX2 U1 ( .A(in), .Y(out) );
endmodule


module dco ( clk_out, lambda, e );
  input [9:0] lambda;
  input e;
  output clk_out;
  wire   clk_1, clk_2, clk_3, clk_4, clk_5, clk_6, clk_7, clk_8, clk_9, clk_10,
         n31, n32, n33, n34, n35, n36, n37, n38, n39, n40, n41, n42, n43, n44,
         n45, n46, n47, n48, n49, n50, n51, n52, n53, n54, n55, n56, n57, n58,
         n59, n60, n61;

  buffer_15_9 bc1 ( .out(clk_1), .in(n31) );
  buffer_15_8 bc2 ( .out(clk_2), .in(clk_1) );
  buffer_15_7 bc3 ( .out(clk_3), .in(clk_2) );
  buffer_15_6 bc4 ( .out(clk_4), .in(clk_3) );
  buffer_15_5 bc5 ( .out(clk_5), .in(clk_4) );
  buffer_15_4 bc6 ( .out(clk_6), .in(clk_5) );
  buffer_15_3 bc7 ( .out(clk_7), .in(clk_6) );
  buffer_15_2 bc8 ( .out(clk_8), .in(clk_7) );
  buffer_15_1 bc9 ( .out(clk_9), .in(clk_8) );
  buffer_15_0 bc10 ( .out(clk_10), .in(clk_9) );
  NAND2X8 U1 ( .A(e), .B(clk_out), .Y(n31) );
  NAND4X1 U33 ( .A(n32), .B(n33), .C(n34), .D(n35), .Y(clk_out) );
  AOI222XL U34 ( .A0(clk_4), .A1(n36), .B0(clk_5), .B1(n37), .C0(clk_6), .C1(
        n38), .Y(n35) );
  AOI22XL U35 ( .A0(clk_2), .A1(n39), .B0(clk_3), .B1(n40), .Y(n34) );
  AOI22XL U36 ( .A0(clk_10), .A1(n41), .B0(clk_9), .B1(n42), .Y(n33) );
  CLKINVX1 U37 ( .A(n43), .Y(n42) );
  CLKINVX1 U38 ( .A(n44), .Y(n41) );
  AOI2B1X1 U39 ( .A1N(n45), .A0(clk_7), .B0(n46), .Y(n32) );
  MX2X1 U40 ( .A(n47), .B(clk_8), .S0(n48), .Y(n46) );
  NOR3BX1 U41 ( .AN(n49), .B(n50), .C(lambda[8]), .Y(n48) );
  NOR4X1 U42 ( .A(n51), .B(n52), .C(n38), .D(n37), .Y(n47) );
  AND4X1 U43 ( .A(lambda[4]), .B(n53), .C(n54), .D(n55), .Y(n37) );
  NOR4BBX1 U44 ( .AN(n56), .BN(n57), .C(n58), .D(lambda[6]), .Y(n38) );
  OR3X1 U45 ( .A(n39), .B(n40), .C(n36), .Y(n52) );
  NOR4BX1 U46 ( .AN(n53), .B(n55), .C(lambda[2]), .D(lambda[4]), .Y(n36) );
  CLKINVX1 U47 ( .A(lambda[3]), .Y(n55) );
  AND3X1 U48 ( .A(n53), .B(n59), .C(lambda[2]), .Y(n40) );
  NOR2BX1 U49 ( .AN(n60), .B(lambda[1]), .Y(n53) );
  AND4X1 U50 ( .A(lambda[1]), .B(n60), .C(n59), .D(n54), .Y(n39) );
  CLKINVX1 U51 ( .A(lambda[2]), .Y(n54) );
  NOR4BX1 U52 ( .AN(n57), .B(lambda[0]), .C(lambda[5]), .D(lambda[6]), .Y(n60)
         );
  NAND4X1 U53 ( .A(clk_1), .B(n44), .C(n43), .D(n45), .Y(n51) );
  NAND3XL U54 ( .A(n49), .B(n50), .C(lambda[8]), .Y(n43) );
  CLKINVX1 U55 ( .A(lambda[7]), .Y(n50) );
  NOR4BX1 U56 ( .AN(n56), .B(lambda[5]), .C(lambda[6]), .D(lambda[9]), .Y(n49)
         );
  NAND4X1 U57 ( .A(n56), .B(n58), .C(lambda[9]), .D(n61), .Y(n44) );
  NOR3X1 U58 ( .A(lambda[6]), .B(lambda[8]), .C(lambda[7]), .Y(n61) );
  NAND4X1 U59 ( .A(lambda[6]), .B(n57), .C(n56), .D(n58), .Y(n45) );
  CLKINVX1 U60 ( .A(lambda[5]), .Y(n58) );
  NOR4BX1 U61 ( .AN(n59), .B(lambda[0]), .C(lambda[1]), .D(lambda[2]), .Y(n56)
         );
  NOR2X1 U62 ( .A(lambda[3]), .B(lambda[4]), .Y(n59) );
  NOR3X1 U63 ( .A(lambda[8]), .B(lambda[9]), .C(lambda[7]), .Y(n57) );
endmodule

