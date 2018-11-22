`timescale 10 ns / 1 ns
`include "mux2x1.v"

module tb_mux2x1();

reg sel;
reg [1:0] din;
wire dout;

initial begin
	{sel, din} = 3'b0;
	forever
		#5 {sel, din} = {sel, din} + 1;
end

mux2x1 mux(dout, sel, din);

initial
	$monitor($time, "\tsel = %b\tdin = %2b\tdout = %b", sel, din, dout);

endmodule
