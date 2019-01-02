`timescale 10 ns / 1 ns
`include "ALU.v"

module tb_ALU();

wire c_out;
wire [7:0] sum;
reg [2:0] oper;
reg [7:0] a;
reg [7:0] b;
reg c_in;

initial begin
	a = 8'b1101_0010;
	b = 8'b1011_0110;
	{c_in, oper} = 4'b0;
	forever
		#5 {c_in, oper} = {c_in, oper} + 1;
end

ALU alu(c_out, sum, oper, a, b, c_in);

initial
	$monitor(
		$time, "\t%b\t%8b(%d)\t%d\t%8b(%d)\t%b\t%8b(%d)",
		c_in, a, a, oper, b, b, c_out, sum, sum
	);

endmodule
