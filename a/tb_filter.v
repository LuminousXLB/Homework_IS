`timescale 10 ns / 1 ns
`include "filter.v"

module tb_filter();

wire sig_out;
reg clock, reset, sig_in;
reg [15:0] data;

initial begin
	clock = 1'b0;
	forever
		#5 clock = ~clock;
end

initial begin
	reset = 1'b1;
	#1 reset = 1'b0;
	#5 reset = 1'b1;
end

initial begin
	data = 16'b0001_1101_0111_1101;
	sig_in = 1'b0;
	#2 sig_in = 1'b1;
	forever
		#10 {data, sig_in} = {sig_in, data};
end

filter ftr(sig_out, clock, reset, sig_in);

endmodule
