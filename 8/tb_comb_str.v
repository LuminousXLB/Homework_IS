`timescale 10 ns / 1 ns
`include "comb_str.v"

module tb_comb_str();

reg sel, A, B, C, D;
wire Y;

initial begin
	{sel, A, B, C, D} = 5'b0;
	forever
		#10 {sel, A, B, C, D} = {sel, A, B, C, D} + 1;
end

comb_str comb(Y, sel, A, B, C, D);

initial
	$monitor(
		$time, "\tsel = %b\tAB = %2b\tCD = %2b\tY = %b",
		sel, {A, B}, {C, D}, Y
	);

endmodule
