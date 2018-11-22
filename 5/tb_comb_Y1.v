`timescale 10 ns / 1 ns
`include "comb_Y1.v"

module tb_comb_Y1();

reg A, B, C;
wire Y;

initial begin
	{A, B, C} = 3'b0;
	forever
		#5 {A, B, C} = {A, B, C} + 1;
end

comb_Y1 Y1(Y, A, B, C);

initial
	$monitor($time, "\tABCD = %3b\t%d\tY1 = %b", {A, B, C}, {A, B, C}, Y);

endmodule
