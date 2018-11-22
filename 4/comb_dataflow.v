`timescale 10 ns / 1 ns

module comb_dataflow(output Y, input A, B, C, D);

assign Y = (~(A | D)) & (B & C & (~D));

endmodule