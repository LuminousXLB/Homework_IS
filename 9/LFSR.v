`timescale 10 ns / 1 ns

module LFSR(
	output reg [1:26] q,	// 26 bit data output.
	input clk,				// Clock input.
	input rst_n,			// Synchronous reset input.
	input load,				// Synchronous load input.
	input [1:26] din		// 26 bit parallel data input.
);

always @(posedge clk) begin
	if (!rst_n) begin
		q <= 0;
	end else if (load) begin
		q <= din;
	end	else begin
		q <= {q[26] ^ q[8] ^ q[7] ^ q[1], q[1:25]};
	end
end

endmodule
