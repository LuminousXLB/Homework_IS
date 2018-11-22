`timescale 10 ns / 1 ns
`include "shift_counter.v"

module tb_shift_counter();

reg clk;
reg rst;
wire [7:0] count;

initial begin
	clk = 1'b0;
	forever
		#3 clk = ~clk;
end

initial begin
	rst = 1'b1;
	#5 rst = 1'b0;
	#35 rst = 1'b1;
	#6 rst = 1'b0;
end

shift_counter counter(count, clk, rst);

initial
	$monitor($time, "\tcount = %8b", count);

endmodule
