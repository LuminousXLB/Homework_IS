`timescale 10 ns / 1 ns

module SramBit(
	output reg dout,
	input din,
	input wr,
	input rd,
	input en
);

reg memory;

always @(posedge wr or negedge rd or posedge rd) begin
	if (en) begin
		if (wr) begin
			memory <= din;
			dout <= 1'bx;
		end else if (!rd) begin
			dout <= memory;
		end else begin
			dout <= 1'bx;
		end
	end else begin
		dout <= 1'bz;
	end
end

endmodule
