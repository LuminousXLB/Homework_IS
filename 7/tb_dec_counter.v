`timescale 10 ns / 1 ns
`include "dec_counter.v"

module tb_dec_counter();

reg clk;
reg rst;
wire [3:0] count;

initial begin
	clk = 1'b0;
	forever
		#3 clk = ~clk;
end

initial begin
	rst = 1'b1;
	#5 rst = 1'b0;
	forever
		begin
			#35 rst = 1'b1;
			#3 rst = 1'b0;
		end
end

dec_counter counter(count, clk, rst);

initial
	$monitor($time, "\tcount = %4b\t%d", count, count);

endmodule
