`timescale 10 ns / 1 ns
`include "mux4x1.v"

module tb_mux4x1();

reg [1:0] sel;
reg [3:0] din;
wire dout;

initial begin
	{sel, din} = 6'b0;
	forever
		#5 {sel, din} = {sel, din} + 1;
end

mux4x1 mux(dout, sel, din);

initial
	$monitor($time, "\tsel = %2b\tdin = %4b\tdout = %b", sel, din, dout);

endmodule
