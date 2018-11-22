`timescale 10 ns / 1 ns
`include "filter.v"

module tb_filter();

wire sig_out;
reg clock, reset, sig_in;

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
	sig_in = 1'b0;
	#2 sig_in = 1'b1;
	#10 sig_in = 1'b1;
	#10 sig_in = 1'b0;
	#10 sig_in = 1'b1;
	#10 sig_in = 1'b1;
	#10 sig_in = 1'b1;
	#10 sig_in = 1'b1;
	#10 sig_in = 1'b1;
	#10 sig_in = 1'b0;
	#10 sig_in = 1'b1;
	#10 sig_in = 1'b0;
	#10 sig_in = 1'b1;
	#10 sig_in = 1'b1;
	#10 sig_in = 1'b1;
	#10 sig_in = 1'b0;
	#10 sig_in = 1'b0;
	#10 sig_in = 1'b0;
end

filter ftr(sig_out, clock, reset, sig_in);

endmodule
