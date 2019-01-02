`timescale 10 ns / 1 ns
`include "Decoder4x16.v"
`include "SramBit.v"

module sram(
	output [7:0] dout,
	input [7:0] din,
	input [7:0] addr,
	input wr,
	input rd,
	input cs
);

wire [15:0] row;
wire [15:0] col;
Decoder4x16 rowSelector(row, addr[3:0]);
Decoder4x16 colSelector(col, addr[7:4]);

genvar r, c, b;

generate
for (r = 0; r < 16; r = r + 1) begin : row_loop
	for (c = 0; c < 16; c = c + 1) begin : col_loop
		wire en = row[r] & col[c] & cs;
		for (b = 0; b < 8; b = b + 1) begin : bit_loop
			SramBit sb(dout[b], din[b], wr, rd, en);
		end
	end
end
endgenerate

endmodule
