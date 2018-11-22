`timescale 10 ns / 1 ns
`include "ones_count.v"

module tb_ones_count();

reg [7:0] data;
wire [3:0] count;
reg [7:0] mask;

initial begin
	data = 8'b0;
	mask = 8'b1;
	forever begin
		#5 data = data | mask;
		mask = mask << 1;
	end
end

ones_count oc(count, data);

initial
	$monitor($time, "\tdata = %8b\tcount = %4b\t%d", data, count, count);

endmodule
