`timescale 10 ns / 1 ns
`include "Encoder8x3.v"

module tb_Encoder8x3();

reg [7:0] data;
wire [2:0] code;

initial begin
	data = 8'b0000_0001;
	forever
		#5 data = data << 1;
end

Encoder8x3 encoder8x3(code, data);

initial
	$monitor($time, "\tdata = %8b\tcode = %3b", data, code);

endmodule
