`timescale 10 ns / 1 ns
`include "counter8b_updown.v"

module tb_counter8b_updown();

reg clk;
reg rst;
reg dir;
wire [7:0] count;

initial begin
	clk = 1'b0;
	forever
		#2 clk = ~clk;
end

initial begin
	dir = 1'b1;
	rst = 1'b0;
	#1 rst = 1'b1;
	#4 rst = 1'b0;
	#1030 rst = 1'b1;
	dir = 1'b0;
	#4 rst = 1'b0;
end

counter8b_updown counter(count, clk, rst, dir);

initial
	$monitor($time, "\tcount = %8b\t%d", count, count);

endmodule
