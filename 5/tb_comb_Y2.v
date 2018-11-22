`timescale 10 ns / 1 ns
`include "comb_Y2.v"

module tb_comb_Y2();

reg A, B, C, D;
wire Y;

initial begin
	{A, B, C, D} = 4'b0;
	forever
		#5 {A, B, C, D} = {A, B, C, D} + 1;
end

comb_Y2 Y2(Y, A, B, C, D);

initial
	$monitor($time, "\tABCD = %4b\t%d\tY2 = %b", {A, B, C, D}, {A, B, C, D}, Y);

endmodule
