`timescale 10 ns / 1 ns

module comb_behavior(output Y, input A, B, C, D);

reg buffer;
always @(*)
	buffer = ~(A | D) & (B & C & (~D));

assign Y = buffer;

endmodule