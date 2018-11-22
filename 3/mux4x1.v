`timescale 10 ns / 1 ns
`include "mux2x1.v"

module mux4x1(output dout, input [1:0] sel, [3:0] din);

wire doL, doH;
mux2x1 mux2x1_1(doL, sel[0], din[1:0]);
mux2x1 mux2x1_2(doH, sel[0], din[3:2]);
mux2x1 mux2x1_3(dout, sel[1], {doH, doL});

endmodule
