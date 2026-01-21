/////////////////////////////////////////////////////////////
// Created by: Synopsys DC Expert(TM) in wire load mode
// Version   : R-2020.09-SP5
// Date      : Sat Nov  1 17:36:49 2025
/////////////////////////////////////////////////////////////


module sa ( y, x, done, clk, rst_n, y_t, start );
  output [9:0] y;
  output [3:0] x;
  input [9:0] y_t;
  input clk, rst_n, start;
  output done;
  wire   N33, N34, n140, n141, N46, N47, n19, n30, n32, n330, n340, n35, n36,
         n37, n42, n43, n44, n45, n460, n470, n50, n51, n52, n53, n54, n55,
         n56, n57, n58, n59, n61, n62, n63, n64, n65, n66, n67, n68, n69, n70,
         n71, n74, n75, n76, n77, n78, n79, n80, n81, n82, n83, n84, n85, n86,
         n87, n88, n89, n90, n91, n92, n93, n94, n95, n96, n97, n98, n99, n100,
         n101, n102, n103, n104, n105, n106, n107, n108, n109, n110, n111,
         n112, n113, n114, n115, n116, n117, n118, n119, n120, n121, n122,
         n123, n124, n125, n126, n127, n128, n129, n130, n131, n132, n133,
         n134, n135, n136, n137;
  wire   [1:0] state;

  DFFSQXL cnt_reg_1_ ( .D(N47), .CK(clk), .SN(rst_n), .Q(N34) );
  DFFRHQX2 x_reg_0_ ( .D(n35), .CK(clk), .RN(rst_n), .Q(n141) );
  DFFSHQX2 x_reg_3_ ( .D(n32), .CK(clk), .SN(rst_n), .Q(x[3]) );
  DFFRHQX2 x_reg_2_ ( .D(n330), .CK(clk), .RN(rst_n), .Q(x[2]) );
  DFFRX1 state_reg_1_ ( .D(n37), .CK(clk), .RN(rst_n), .Q(state[1]), .QN(n133)
         );
  DFFRX1 state_reg_0_ ( .D(n36), .CK(clk), .RN(rst_n), .Q(state[0]), .QN(n129)
         );
  DFFSX2 cnt_reg_0_ ( .D(N46), .CK(clk), .SN(rst_n), .Q(N33), .QN(n131) );
  DFFRHQX8 x_reg_1_ ( .D(n340), .CK(clk), .RN(rst_n), .Q(x[1]) );
  INVX2 U38 ( .A(1'b1), .Y(y[0]) );
  INVX2 U40 ( .A(1'b0), .Y(y[9]) );
  OAI2BB1X4 U42 ( .A0N(n92), .A1N(n91), .B0(y_t[9]), .Y(n97) );
  XOR2X1 U43 ( .A(n82), .B(y[8]), .Y(n67) );
  XNOR2X1 U44 ( .A(n141), .B(x[1]), .Y(n83) );
  INVX2 U45 ( .A(x[1]), .Y(n125) );
  OR2X2 U46 ( .A(n61), .B(n62), .Y(y[5]) );
  AOI31X1 U47 ( .A0(n133), .A1(n132), .A2(n131), .B0(n130), .Y(n134) );
  INVX1 U48 ( .A(n135), .Y(n137) );
  AOI21BX2 U49 ( .A0(n106), .A1(n105), .B0N(x[2]), .Y(n42) );
  AND2X2 U50 ( .A(n51), .B(n50), .Y(n43) );
  NAND2BX2 U51 ( .AN(N33), .B(n58), .Y(n135) );
  INVX2 U52 ( .A(n94), .Y(n66) );
  OR3X2 U53 ( .A(n118), .B(n117), .C(n123), .Y(n44) );
  OR2X4 U54 ( .A(n44), .B(n119), .Y(n120) );
  AOI32X2 U55 ( .A0(y_t[4]), .A1(n116), .A2(n115), .B0(y_t[5]), .B1(n114), .Y(
        n118) );
  OAI2BB1XL U56 ( .A0N(y[6]), .A1N(n107), .B0(n108), .Y(n117) );
  NAND2X4 U57 ( .A(n103), .B(n104), .Y(n108) );
  NOR2X2 U58 ( .A(y[2]), .B(n88), .Y(n45) );
  NOR2X2 U59 ( .A(n140), .B(n87), .Y(n460) );
  NOR2X2 U60 ( .A(n45), .B(n460), .Y(n90) );
  OR2X2 U61 ( .A(n65), .B(n66), .Y(n140) );
  INVXL U62 ( .A(y_t[3]), .Y(n87) );
  OAI211X1 U63 ( .A0(n123), .A1(n122), .B0(n121), .C0(n120), .Y(n59) );
  INVX2 U64 ( .A(x[3]), .Y(y[8]) );
  INVXL U65 ( .A(n140), .Y(n470) );
  INVX2 U66 ( .A(n470), .Y(y[3]) );
  INVX1 U67 ( .A(n101), .Y(n62) );
  AO2B2X4 U68 ( .B0(x[2]), .B1(n69), .A0(n135), .A1N(n127), .Y(n330) );
  NOR2BX4 U69 ( .AN(n57), .B(y[1]), .Y(n65) );
  NOR2X2 U70 ( .A(n85), .B(n84), .Y(n57) );
  XOR2X3 U71 ( .A(x[2]), .B(n93), .Y(n84) );
  INVXL U72 ( .A(n42), .Y(y[7]) );
  NAND2BX2 U73 ( .AN(y_t[3]), .B(n140), .Y(n89) );
  NAND2BX4 U74 ( .AN(n90), .B(n89), .Y(n91) );
  NAND3X1 U75 ( .A(n63), .B(n64), .C(n89), .Y(n92) );
  CLKNAND2X2 U76 ( .A(n52), .B(n43), .Y(n340) );
  OR2X2 U77 ( .A(n59), .B(n124), .Y(n52) );
  OAI2BB1X1 U78 ( .A0N(n83), .A1N(n136), .B0(n84), .Y(n94) );
  OAI2BB1X2 U79 ( .A0N(n68), .A1N(n101), .B0(n106), .Y(y[6]) );
  OR2X4 U80 ( .A(n68), .B(n101), .Y(n106) );
  NAND3BX2 U81 ( .AN(n129), .B(N33), .C(n132), .Y(n124) );
  OR2X1 U82 ( .A(N33), .B(n127), .Y(n50) );
  OR2XL U83 ( .A(n126), .B(n125), .Y(n51) );
  OAI2B11X4 U84 ( .A1N(n80), .A0(n122), .B0(n121), .C0(n120), .Y(n58) );
  NAND2XL U85 ( .A(x[2]), .B(n54), .Y(n55) );
  NAND2XL U86 ( .A(n53), .B(n102), .Y(n56) );
  NAND2X2 U87 ( .A(n55), .B(n56), .Y(n105) );
  INVXL U88 ( .A(x[2]), .Y(n53) );
  INVXL U89 ( .A(n102), .Y(n54) );
  XNOR2X4 U90 ( .A(n106), .B(n105), .Y(n103) );
  INVXL U91 ( .A(n83), .Y(n85) );
  NAND2BX2 U92 ( .AN(x[2]), .B(n81), .Y(n82) );
  INVXL U93 ( .A(y[5]), .Y(n114) );
  NOR3X1 U94 ( .A(n66), .B(n99), .C(n95), .Y(n61) );
  INVXL U95 ( .A(n100), .Y(n99) );
  XNOR2XL U96 ( .A(n82), .B(y[8]), .Y(n95) );
  OAI2BB1X4 U97 ( .A0N(n67), .A1N(n94), .B0(n99), .Y(n101) );
  NAND2BX2 U98 ( .AN(y_t[5]), .B(y[5]), .Y(n115) );
  INVXL U99 ( .A(n93), .Y(n81) );
  OR2XL U100 ( .A(y_t[2]), .B(n86), .Y(n63) );
  OR2XL U101 ( .A(y_t[1]), .B(n136), .Y(n64) );
  XNOR2XL U102 ( .A(n141), .B(n85), .Y(n86) );
  INVXL U103 ( .A(n141), .Y(n136) );
  INVXL U104 ( .A(n136), .Y(y[1]) );
  INVXL U105 ( .A(n117), .Y(n111) );
  OAI21XL U106 ( .A0(n59), .A1(n128), .B0(n134), .Y(n32) );
  CLKINVX2 U107 ( .A(y[4]), .Y(n116) );
  AOI31X1 U108 ( .A0(y_t[7]), .A1(n42), .A2(y_t[9]), .B0(n109), .Y(n110) );
  XNOR2X1 U109 ( .A(n66), .B(n67), .Y(y[4]) );
  INVX2 U110 ( .A(n86), .Y(y[2]) );
  OR2X2 U111 ( .A(x[1]), .B(n100), .Y(n102) );
  AOI21BX2 U112 ( .A0(x[1]), .A1(n100), .B0N(n102), .Y(n68) );
  AO2B2X2 U113 ( .B0(n133), .B1(n129), .A0(n128), .A1N(y[8]), .Y(n130) );
  INVX2 U114 ( .A(n79), .Y(done) );
  INVX2 U115 ( .A(y_t[4]), .Y(n98) );
  OAI21X1 U116 ( .A0(N34), .A1(n129), .B0(n133), .Y(n69) );
  AOI31X1 U117 ( .A0(y_t[8]), .A1(x[3]), .A2(y_t[9]), .B0(n113), .Y(n121) );
  INVX2 U118 ( .A(y_t[2]), .Y(n88) );
  NAND2BX4 U119 ( .AN(n141), .B(n125), .Y(n93) );
  NOR4BX2 U120 ( .AN(n108), .B(y[6]), .C(n119), .D(n107), .Y(n109) );
  INVX2 U121 ( .A(y_t[7]), .Y(n104) );
  OA21X1 U122 ( .A0(N33), .A1(n129), .B0(n70), .Y(n126) );
  INVX2 U123 ( .A(n80), .Y(n123) );
  NAND2BX2 U124 ( .AN(y_t[8]), .B(y[8]), .Y(n80) );
  NAND2BX2 U125 ( .AN(state[1]), .B(state[0]), .Y(n19) );
  NAND2BX2 U126 ( .AN(n19), .B(N34), .Y(n127) );
  NAND3BX2 U127 ( .AN(n132), .B(N33), .C(n133), .Y(n128) );
  INVX2 U128 ( .A(N34), .Y(n132) );
  AOI21BX2 U129 ( .A0(N34), .A1(state[0]), .B0N(n133), .Y(n70) );
  INVX2 U130 ( .A(n76), .Y(n78) );
  OAI2B11X2 U131 ( .A1N(start), .A0(state[1]), .B0(n79), .C0(n19), .Y(n76) );
  MX2X1 U132 ( .A(n77), .B(state[0]), .S0(n78), .Y(n36) );
  NOR2X2 U133 ( .A(state[1]), .B(n75), .Y(n77) );
  INVX2 U134 ( .A(n124), .Y(n75) );
  NAND2BX2 U135 ( .AN(state[0]), .B(state[1]), .Y(n79) );
  NAND2BX2 U136 ( .AN(n74), .B(n79), .Y(N47) );
  XNOR2X1 U137 ( .A(n30), .B(n132), .Y(n74) );
  NOR2X2 U138 ( .A(N33), .B(n19), .Y(n30) );
  OAI2BB1X1 U139 ( .A0N(n78), .A1N(state[1]), .B0(n124), .Y(n37) );
  NAND2X2 U140 ( .A(n71), .B(n79), .Y(N46) );
  XOR2X1 U141 ( .A(N33), .B(n19), .Y(n71) );
  INVX2 U142 ( .A(y_t[9]), .Y(n119) );
  INVX2 U143 ( .A(y_t[6]), .Y(n107) );
  BUFX2 U144 ( .A(y[1]), .Y(x[0]) );
  MXI4XL U145 ( .A(y[1]), .B(x[2]), .C(x[1]), .D(x[3]), .S0(N34), .S1(N33), 
        .Y(n113) );
  AOI211X1 U146 ( .A0(y[4]), .A1(n98), .B0(n97), .C0(n96), .Y(n112) );
  INVXL U147 ( .A(n115), .Y(n96) );
  OAI32X1 U148 ( .A0(n137), .A1(N34), .A2(n19), .B0(n70), .B1(n136), .Y(n35)
         );
  OAI31X4 U149 ( .A0(n93), .A1(x[3]), .A2(x[2]), .B0(n136), .Y(n100) );
  AOI21BX4 U150 ( .A0(n112), .A1(n111), .B0N(n110), .Y(n122) );
endmodule
