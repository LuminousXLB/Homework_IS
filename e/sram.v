`timescale 10 ns / 1 ns

module sram(
	output reg [7:0] dout,
	input [7:0] din,
	input [7:0] addr,
	input wr,
	input rd,
	input cs
);

reg [7:0] memory [255:0];

always @(posedge wr or rd) begin
	if (cs) begin
		if (wr) begin
			memory[addr] <= din;
			dout <= 8'bx;
		end else if (!rd) begin
			dout <= memory[addr];
		end else begin
			dout <= 8'bx;
		end
	end else begin
		dout <= 8'bx;
	end
end

endmodule
