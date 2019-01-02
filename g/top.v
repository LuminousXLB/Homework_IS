`timescale 10 ns / 1 ns
`include "mealy.v"
`include "moore.v"

module top();

wire flagme;
wire flagmo;
reg clk;
reg rst_n;

reg [6:0] buffer;
reg din;

initial begin
	clk = 1'b0;
	forever
		#5 clk = ~clk;
end

initial begin
	rst_n = 1'b0;
	#2 rst_n = 1'b1;
	#10 rst_n = 1'b0;
end

initial begin
	{buffer, din} = 8'bxxxxxxx1;
	#12 {buffer, din} = {buffer[5:0], din, 1'b1};
	#10 {buffer, din} = {buffer[5:0], din, 1'b0};
	#10 {buffer, din} = {buffer[5:0], din, 1'b1};
	#10 {buffer, din} = {buffer[5:0], din, 1'b0};
	#10 {buffer, din} = {buffer[5:0], din, 1'b1};
	#10 {buffer, din} = {buffer[5:0], din, 1'b0};
	#10 {buffer, din} = {buffer[5:0], din, 1'b1};
	#10 {buffer, din} = {buffer[5:0], din, 1'b0};
	#10 {buffer, din} = {buffer[5:0], din, 1'b1};
	#10 {buffer, din} = {buffer[5:0], din, 1'b0};
	#10 {buffer, din} = {buffer[5:0], din, 1'b1};
	#10 {buffer, din} = {buffer[5:0], din, 1'b0};
	#10 {buffer, din} = {buffer[5:0], din, 1'b1};
	#10 {buffer, din} = {buffer[5:0], din, 1'b0};
	#10 {buffer, din} = {buffer[5:0], din, 1'b1};
	#10 {buffer, din} = {buffer[5:0], din, 1'b0};
	#10 {buffer, din} = {buffer[5:0], din, 1'b1};
	#10 {buffer, din} = {buffer[5:0], din, 1'b1};
	#10 {buffer, din} = {buffer[5:0], din, 1'b0};
	#10 {buffer, din} = {buffer[5:0], din, 1'b0};
	#10 {buffer, din} = {buffer[5:0], din, 1'b0};
	#10 {buffer, din} = {buffer[5:0], din, 1'b1};
	#10 {buffer, din} = {buffer[5:0], din, 1'b1};
	#10 {buffer, din} = {buffer[5:0], din, 1'b0};
	#10 {buffer, din} = {buffer[5:0], din, 1'b0};
	#10 {buffer, din} = {buffer[5:0], din, 1'b1};
	#10 {buffer, din} = {buffer[5:0], din, 1'b1};
	#10 {buffer, din} = {buffer[5:0], din, 1'b0};
end

mealy me(flagme, din, clk, rst_n);
moore mo(flagmo, din, clk, rst_n);

initial
	$monitor(
		$time, "\tbuffer = %8b, mealy = %b, moore = %b",
		{buffer, din}, flagme, flagmo
	);

endmodule
