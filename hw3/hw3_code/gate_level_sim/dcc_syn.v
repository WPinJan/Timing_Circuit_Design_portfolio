/////////////////////////////////////////////////////////////
// Created by: Synopsys DC Expert(TM) in wire load mode
// Version   : R-2020.09-SP5
// Date      : Mon Dec 22 05:07:58 2025
/////////////////////////////////////////////////////////////


module delay_buffer_1 ( out, in );
  input in;
  output out;


  BUFX2 U1 ( .A(in), .Y(out) );
endmodule


module delay_buffer_chain ( out, in );
  input in;
  output out;
  wire   n1, n2, n3;

  CLKBUFX1 U0 ( .A(in), .Y(n1) );
  CLKBUFX1 U1 ( .A(n1), .Y(n2) );
  CLKBUFX1 U2 ( .A(n2), .Y(n3) );
  CLKBUFX1 U4 ( .A(n3), .Y(out) );
endmodule


module delay_buffer ( out, in );
  input in;
  output out;
  wire   n1;

  CLKBUFX1 U0 ( .A(in), .Y(n1) );
  CLKBUFX1 U4 ( .A(n1), .Y(out) );
endmodule


module tdl ( clk_in, lambda, lambda_bar, clk_out );
  input [7:0] lambda;
  input [7:0] lambda_bar;
  input clk_in;
  output clk_out;
  wire   clk_1, clk_2, clk_3, clk_4, clk_5, clk_6, clk_7, clk_8, clk_2_2,
         clk_3_2, clk_4_2, clk_5_2, clk_6_2, clk_7_2, clk_8_2;

  delay_buffer_chain bc1 ( .out(clk_1), .in(clk_in) );
  delay_buffer bc2 ( .out(clk_2), .in(clk_1) );
  delay_buffer bc3 ( .out(clk_3), .in(clk_2) );
  delay_buffer bc4 ( .out(clk_4), .in(clk_3) );
  delay_buffer bc5 ( .out(clk_5), .in(clk_4) );
  delay_buffer bc6 ( .out(clk_6), .in(clk_5) );
  delay_buffer bc7 ( .out(clk_7), .in(clk_6) );
  delay_buffer bc8 ( .out(clk_8), .in(clk_7) );
  TBUFX4 buf_1 ( .A(clk_1), .OE(lambda[0]), .Y(clk_out) );
  TBUFX4 buf_2 ( .A(clk_2), .OE(lambda[1]), .Y(clk_2_2) );
  TBUFX4 buf_2_2 ( .A(clk_2_2), .OE(lambda_bar[0]), .Y(clk_out) );
  TBUFX4 buf_3 ( .A(clk_3), .OE(lambda[2]), .Y(clk_3_2) );
  TBUFX4 buf_3_2 ( .A(clk_3_2), .OE(lambda_bar[1]), .Y(clk_2_2) );
  TBUFX4 buf_4 ( .A(clk_4), .OE(lambda[3]), .Y(clk_4_2) );
  TBUFX4 buf_4_2 ( .A(clk_4_2), .OE(lambda_bar[2]), .Y(clk_3_2) );
  TBUFX4 buf_5 ( .A(clk_5), .OE(lambda[4]), .Y(clk_5_2) );
  TBUFX4 buf_5_2 ( .A(clk_5_2), .OE(lambda_bar[3]), .Y(clk_4_2) );
  TBUFX4 buf_6 ( .A(clk_6), .OE(lambda[5]), .Y(clk_6_2) );
  TBUFX4 buf_6_2 ( .A(clk_6_2), .OE(lambda_bar[4]), .Y(clk_5_2) );
  TBUFX4 buf_7 ( .A(clk_7), .OE(lambda[6]), .Y(clk_7_2) );
  TBUFX4 buf_7_2 ( .A(clk_7_2), .OE(lambda_bar[5]), .Y(clk_6_2) );
  TBUFX4 buf_8 ( .A(clk_8), .OE(lambda[7]), .Y(clk_8_2) );
  TBUFX4 buf_8_2 ( .A(clk_8_2), .OE(lambda_bar[6]), .Y(clk_7_2) );
endmodule


module delay_buffer_0 ( out, in );
  input in;
  output out;


  BUFX2 U1 ( .A(in), .Y(out) );
endmodule


module dcc ( clk_dcc, locked, clk, rst_n );
  input clk, rst_n;
  output clk_dcc, locked;
  wire   clk_fp, clk_dff, clk_in_os, clk_b1, clk_hp_os, clk_hp, clk_b2, N158,
         racing_r, locker_s, n3, n4, n5, n6, n7, n8, n9, n10, n11, n12, n13,
         n14, n15, n16, n17, n18, n20, n21, n22, n23, n24, n25, n26, n27, n28,
         n29, n30, n31, n32, n33, n34, n35, n36, n37, n38, n39, n40, n41, n42,
         n43, n44, n45, n46, n47, n48, n49, n50, n51, n52, n53, n54, n55, n56,
         n57, n58, n59, n60, n61, n62, n63, n64, n65, n66, n67, n68, n69, n70,
         n71, n72, n73, n74, n75, n76, n77, n78, n79, n80, n81, n82, n83, n84,
         n85, n86, n87, n88, n89, n90, n91, n92, n93, n94, n95, n96;
  wire   [2:0] state;
  wire   [2:0] x;
  wire   [7:0] lambda;
  wire   [7:0] lambda_bar;
  assign locked = N158;

  delay_buffer_1 ub_1 ( .out(clk_b1), .in(clk_in_os) );
  delay_buffer_0 ub_2 ( .out(clk_b2), .in(clk_hp_os) );
  tdl tdl_1 ( .clk_in(clk), .lambda(lambda), .lambda_bar(lambda_bar), 
        .clk_out(clk_hp) );
  tdl tdl_2 ( .clk_in(clk_hp), .lambda(lambda), .lambda_bar(lambda_bar), 
        .clk_out(clk_fp) );
  DFFRHQX4 \state_reg[1]  ( .D(n88), .CK(clk), .RN(n92), .Q(state[1]) );
  INVX2 U5 ( .A(n90), .Y(n3) );
  OAI21X8 U6 ( .A0(n18), .A1(n20), .B0(clk_dff), .Y(racing_r) );
  AOI21X8 U7 ( .A0(n21), .A1(n18), .B0(n20), .Y(locker_s) );
  CLKINVX20 U8 ( .A(racing_r), .Y(n20) );
  AOI2BB1X4 U9 ( .A0N(clk_in_os), .A1N(clk_dcc), .B0(clk_hp_os), .Y(clk_dcc)
         );
  NAND2X8 U65 ( .A(locker_s), .B(n55), .Y(n59) );
  AOI21X8 U66 ( .A0(n21), .A1(n55), .B0(n61), .Y(n60) );
  OAI21X8 U74 ( .A0(state[1]), .A1(n21), .B0(state[0]), .Y(n66) );
  CLKINVX20 U75 ( .A(locker_s), .Y(n21) );
  DFFRQX2 clk_in_os_reg ( .D(1'b1), .CK(clk), .RN(n96), .Q(clk_in_os) );
  DFFRQX2 clk_hp_os_reg ( .D(1'b1), .CK(clk_hp), .RN(n95), .Q(clk_hp_os) );
  DFFRQX2 \lambda_reg[6]  ( .D(n77), .CK(clk), .RN(n92), .Q(lambda[6]) );
  DFFRQX2 \lambda_reg[5]  ( .D(n78), .CK(clk), .RN(rst_n), .Q(lambda[5]) );
  DFFRQX2 \lambda_reg[3]  ( .D(n80), .CK(clk), .RN(n92), .Q(lambda[3]) );
  DFFRQX2 \lambda_reg[1]  ( .D(n82), .CK(clk), .RN(rst_n), .Q(lambda[1]) );
  DFFRQX2 \lambda_reg[4]  ( .D(n79), .CK(clk), .RN(n92), .Q(lambda[4]) );
  DFFRQX2 \lambda_reg[2]  ( .D(n81), .CK(clk), .RN(n92), .Q(lambda[2]) );
  DFFRQX2 \lambda_reg[7]  ( .D(n76), .CK(clk), .RN(rst_n), .Q(lambda[7]) );
  DFFRQX2 \lambda_bar_reg[0]  ( .D(n75), .CK(clk), .RN(n92), .Q(lambda_bar[0])
         );
  DFFSQXL \lambda_bar_reg[7]  ( .D(n68), .CK(clk), .SN(rst_n), .Q(
        lambda_bar[7]) );
  DFFSQXL \lambda_reg[0]  ( .D(n83), .CK(clk), .SN(rst_n), .Q(lambda[0]) );
  DFFSQXL \lambda_bar_reg[4]  ( .D(n71), .CK(clk), .SN(rst_n), .Q(
        lambda_bar[4]) );
  DFFSQXL \lambda_bar_reg[2]  ( .D(n73), .CK(clk), .SN(rst_n), .Q(
        lambda_bar[2]) );
  DFFSQXL \lambda_bar_reg[5]  ( .D(n70), .CK(clk), .SN(rst_n), .Q(
        lambda_bar[5]) );
  DFFSQXL \lambda_bar_reg[1]  ( .D(n74), .CK(clk), .SN(rst_n), .Q(
        lambda_bar[1]) );
  DFFSQXL \lambda_bar_reg[6]  ( .D(n69), .CK(clk), .SN(rst_n), .Q(
        lambda_bar[6]) );
  DFFRQX2 clk_dff_reg ( .D(1'b1), .CK(clk), .RN(n3), .Q(clk_dff) );
  DFFRQX2 \x_reg[2]  ( .D(n84), .CK(clk), .RN(n92), .Q(x[2]) );
  DFFRQX2 \x_reg[1]  ( .D(n85), .CK(clk), .RN(n92), .Q(x[1]) );
  DFFRX1 clk_fp_dff_reg ( .D(1'b1), .CK(clk_fp), .RN(n3), .Q(), .QN(n18) );
  DFFSQXL \lambda_bar_reg[3]  ( .D(n72), .CK(clk), .SN(rst_n), .Q(
        lambda_bar[3]) );
  DFFRHQX2 \state_reg[0]  ( .D(n87), .CK(clk), .RN(rst_n), .Q(state[0]) );
  DFFRX1 \x_reg[0]  ( .D(n86), .CK(clk), .RN(n92), .Q(x[0]), .QN(n17) );
  DFFRHQX2 \state_reg[2]  ( .D(n89), .CK(clk), .RN(n92), .Q(state[2]) );
  INVX2 U98 ( .A(rst_n), .Y(n91) );
  INVX2 U99 ( .A(n91), .Y(n92) );
  INVX2 U100 ( .A(n43), .Y(n5) );
  NAND2BX2 U101 ( .AN(n42), .B(n23), .Y(n32) );
  AOI21X1 U102 ( .A0(n10), .A1(n12), .B0(n7), .Y(n34) );
  INVX2 U103 ( .A(state[2]), .Y(n9) );
  NAND3XL U104 ( .A(n93), .B(n94), .C(n37), .Y(n72) );
  INVXL U105 ( .A(n28), .Y(n4) );
  CLKINVX2 U106 ( .A(n45), .Y(n8) );
  CLKINVX2 U107 ( .A(n34), .Y(n6) );
  NAND2XL U108 ( .A(n52), .B(n11), .Y(n23) );
  NOR2X2 U109 ( .A(n55), .B(state[2]), .Y(n52) );
  OAI2BB1XL U110 ( .A0N(lambda[6]), .A1N(n7), .B0(n46), .Y(n77) );
  NAND2XL U111 ( .A(lambda_bar[0]), .B(n7), .Y(n44) );
  AO22X1 U112 ( .A0(lambda[7]), .A1(n7), .B0(n22), .B1(n34), .Y(n76) );
  OAI2BB1XL U113 ( .A0N(lambda[3]), .A1N(n7), .B0(n50), .Y(n80) );
  OAI2BB1XL U114 ( .A0N(lambda[5]), .A1N(n7), .B0(n47), .Y(n78) );
  OAI2BB1XL U115 ( .A0N(lambda[1]), .A1N(n7), .B0(n51), .Y(n82) );
  OAI2BB2X1 U116 ( .B0(n49), .B1(n13), .A0N(lambda[2]), .A1N(n7), .Y(n81) );
  OAI2BB2X1 U117 ( .B0(n49), .B1(n14), .A0N(lambda[4]), .A1N(n7), .Y(n79) );
  NAND2XL U118 ( .A(lambda[0]), .B(n7), .Y(n53) );
  NAND2XL U119 ( .A(n52), .B(n54), .Y(n49) );
  AOI21XL U120 ( .A0(state[0]), .A1(state[2]), .B0(N158), .Y(n62) );
  NOR2XL U121 ( .A(n64), .B(state[2]), .Y(n63) );
  NOR2XL U122 ( .A(n11), .B(state[0]), .Y(n64) );
  OAI21XL U123 ( .A0(n62), .A1(n11), .B0(n65), .Y(n88) );
  AOI31XL U124 ( .A0(state[0]), .A1(n11), .A2(n62), .B0(n64), .Y(n65) );
  NOR2XL U125 ( .A(state[1]), .B(state[0]), .Y(n67) );
  OAI2B11XL U126 ( .A1N(clk_dff), .A0(n18), .B0(state[2]), .C0(n67), .Y(n90)
         );
  OR2X2 U127 ( .A(n5), .B(n35), .Y(n93) );
  OR2XL U128 ( .A(n36), .B(n26), .Y(n94) );
  OAI22XL U129 ( .A0(x[0]), .A1(n14), .B0(n17), .B1(n13), .Y(n35) );
  CLKNAND2X2 U130 ( .A(n52), .B(state[0]), .Y(n26) );
  NOR2X4 U131 ( .A(n12), .B(n61), .Y(n55) );
  NAND2X2 U132 ( .A(n23), .B(n8), .Y(n28) );
  NOR2X2 U133 ( .A(n10), .B(n7), .Y(n43) );
  NOR2X2 U134 ( .A(n26), .B(n17), .Y(n45) );
  NAND2X2 U135 ( .A(n11), .B(n9), .Y(n61) );
  INVX2 U136 ( .A(n52), .Y(n7) );
  NOR2X2 U137 ( .A(n9), .B(n10), .Y(N158) );
  INVX2 U138 ( .A(n64), .Y(n10) );
  INVX2 U139 ( .A(n36), .Y(n13) );
  INVX2 U140 ( .A(n30), .Y(n14) );
  AND2X2 U141 ( .A(n48), .B(n15), .Y(n39) );
  NOR2X2 U142 ( .A(n15), .B(n16), .Y(n25) );
  OAI221X2 U143 ( .A0(n25), .A1(n26), .B0(n25), .B1(n5), .C0(n27), .Y(n69) );
  AOI21X1 U144 ( .A0(lambda_bar[6]), .A1(n7), .B0(n28), .Y(n27) );
  INVX2 U145 ( .A(state[1]), .Y(n11) );
  NAND2X2 U146 ( .A(n38), .B(n4), .Y(n73) );
  AOI22XL U147 ( .A0(n34), .A1(n13), .B0(lambda_bar[2]), .B1(n7), .Y(n38) );
  NAND2X2 U148 ( .A(n33), .B(n4), .Y(n71) );
  AOI22XL U149 ( .A0(n34), .A1(n14), .B0(lambda_bar[4]), .B1(n7), .Y(n33) );
  AOI21X1 U150 ( .A0(lambda_bar[3]), .A1(n7), .B0(n32), .Y(n37) );
  INVX2 U151 ( .A(state[0]), .Y(n12) );
  NOR2X2 U152 ( .A(n26), .B(x[0]), .Y(n42) );
  OAI221X2 U153 ( .A0(n39), .A1(n5), .B0(n40), .B1(n26), .C0(n41), .Y(n74) );
  AOI21X1 U154 ( .A0(lambda_bar[1]), .A1(n7), .B0(n32), .Y(n41) );
  OAI221X2 U155 ( .A0(n29), .A1(n5), .B0(n30), .B1(n26), .C0(n31), .Y(n70) );
  AOI21X1 U156 ( .A0(lambda_bar[5]), .A1(n7), .B0(n32), .Y(n31) );
  AOI22XL U157 ( .A0(n43), .A1(n35), .B0(n45), .B1(n36), .Y(n50) );
  AOI22XL U158 ( .A0(n29), .A1(n43), .B0(n45), .B1(n30), .Y(n47) );
  OAI211XL U159 ( .A0(n40), .A1(n6), .B0(n8), .C0(n44), .Y(n75) );
  AOI22XL U160 ( .A0(n39), .A1(n43), .B0(n40), .B1(n45), .Y(n51) );
  AOI22XL U161 ( .A0(n42), .A1(n25), .B0(n43), .B1(n25), .Y(n46) );
  OAI211XL U162 ( .A0(n22), .A1(n6), .B0(n23), .C0(n24), .Y(n68) );
  NAND2X2 U163 ( .A(lambda_bar[7]), .B(n7), .Y(n24) );
  OAI32XL U164 ( .A0(n59), .A1(x[1]), .A2(n17), .B0(n56), .B1(n16), .Y(n85) );
  AOI21BX2 U165 ( .A0(n17), .A1(n55), .B0N(n60), .Y(n56) );
  OAI21X1 U166 ( .A0(n56), .A1(n15), .B0(n57), .Y(n84) );
  AOI32XL U167 ( .A0(n36), .A1(x[0]), .A2(n58), .B0(n55), .B1(n30), .Y(n57) );
  INVX2 U168 ( .A(n59), .Y(n58) );
  OAI2B11X2 U169 ( .A1N(n40), .A0(n49), .B0(n23), .C0(n53), .Y(n83) );
  OAI21X1 U170 ( .A0(x[0]), .A1(n12), .B0(n10), .Y(n54) );
  OAI2B2X1 U171 ( .A1N(n62), .A0(n63), .B0(n62), .B1(n12), .Y(n87) );
  OAI211XL U172 ( .A0(state[0]), .A1(n61), .B0(n66), .C0(n62), .Y(n89) );
  OAI22X1 U173 ( .A0(n60), .A1(n17), .B0(x[0]), .B1(n59), .Y(n86) );
  NOR2X2 U174 ( .A(n16), .B(x[2]), .Y(n36) );
  INVX2 U175 ( .A(x[1]), .Y(n16) );
  NOR2X2 U176 ( .A(n15), .B(x[1]), .Y(n30) );
  INVX2 U177 ( .A(x[2]), .Y(n15) );
  XNOR2X1 U178 ( .A(n16), .B(x[0]), .Y(n48) );
  AND2X2 U179 ( .A(n48), .B(x[2]), .Y(n29) );
  AND2X2 U180 ( .A(n25), .B(x[0]), .Y(n22) );
  NOR2X2 U181 ( .A(x[2]), .B(x[1]), .Y(n40) );
  NOR2X2 U182 ( .A(clk_b2), .B(n91), .Y(n95) );
  NOR2X2 U183 ( .A(clk_b1), .B(n91), .Y(n96) );
endmodule

