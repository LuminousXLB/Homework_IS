`timescale 10 ns / 1 ns
`include "seq_detect.v"

module tb_seq_detect();

wire flag;
reg clk;
reg rst_n;

reg [3:0] buffer;

initial begin
	clk = 1'b0;
	forever
		#5 clk = ~clk;
end

initial begin
	rst_n = 1'b1;
	#2 rst_n = 1'b0;
	#10 rst_n = 1'b1;
end

initial begin
	buffer = 4'bxxx1;
	#12 buffer = 4'bxx10;
	#10 buffer = 4'bx101;
	#10 buffer = 4'b1011;
	#10 buffer = 4'b0110;
	#10 buffer = 4'b1101;
	#10 buffer = 4'b1011;
	#10 buffer = 4'b0111;
	#10 buffer = 4'b1110;
	#10 buffer = 4'b1101;
	#10 buffer = 4'b1010;
end

seq_detect dectect(flag, buffer[0], clk, rst_n);

always @(flag) begin
	$display($time, "\tbuffer = %4b, flag = %b", buffer, flag);
end

endmodule
