`timescale 10 ns / 1 ns
`include "sram.v"

module tb_sram();

wire [7:0] dout;
reg [7:0] din;
reg [7:0] addr;
reg wr;
reg rd;
reg cs;

initial begin
	addr = 8'b1100_1010;
end

initial begin
	cs = 1'b1;
	#3 din = 8'b1011_0101;
	#10 din = 8'bxxxx_xxxx;
end

initial begin
	wr = 1'b0;
	#5 wr = 1'b1;
	#5 wr = 1'b0;
end

initial begin
	rd = 1'b1;
	#15 rd = 1'b0;
	#5 rd = 1'b1;
end

sram sr(dout, din, addr, wr, rd, cs);

initial
	$monitor($time, "\taddr = %d, din = %8b, dout = %8b", addr, din, dout);

endmodule
