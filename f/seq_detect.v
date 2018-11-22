`timescale 10 ns / 1 ns

module seq_detect(
	output reg flag,
	input din,
	input clk,
	input rst_n
);

reg [2:0] state;

always @(posedge clk) begin
	if (!rst_n) begin
		state = 3'bxxx;
	end	else if (din) begin
		case (state)
			3'b000: state = 3'b001;
			3'b001: state = 3'b001;
			3'b010: state = 3'b011;
			3'b011: state = 3'b110;
			3'b100: state = 3'b101;
			3'b101: state = 3'b110;
			3'b110: state = 3'b001;
			3'b111: state = 3'b011;
			default: state = 3'b000;
		endcase
	end else begin
		case (state)
			3'b001: state = 3'b010;
			3'b110: state = 3'b111;
			default: state = 3'b100;
		endcase
	end
end

always @(*) begin
	case (state)
		3'b011: flag = 1'b1;
		3'b111: flag = 1'b1;
		default: flag = 1'b0;
	endcase
end

endmodule
