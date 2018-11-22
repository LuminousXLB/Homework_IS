`timescale 10 ns / 1 ns

module ALU(
	output reg c_out, reg [7:0] sum,
	input [2:0] oper, [7:0] a, [7:0] b, c_in
);

reg [8:0] buf_a;
reg [8:0] buf_b;
reg [8:0] buf_cin;

always @(*) begin
	buf_a = a;
	buf_b = b;
	buf_cin = c_in;
	case (oper)
		3'b000: {c_out, sum} = buf_a + buf_b + buf_cin;
		3'b001: {c_out, sum} = buf_a + ~buf_b + buf_cin;
		3'b010: {c_out, sum} = buf_b + ~buf_a + ~buf_cin;
		3'b011: {c_out, sum} = {1'b0, a | b};
		3'b100: {c_out, sum} = {1'b0, a & b};
		3'b101: {c_out, sum} = {1'b0, (~a) | b};
		3'b110: {c_out, sum} = {1'b0, a ^ b};
		3'b111: {c_out, sum} = {1'b0, a ~^ b};
		default: {c_out, sum} = 9'bx;
	endcase
end

endmodule
