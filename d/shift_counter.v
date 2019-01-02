`timescale 10 ns / 1 ns

module shift_counter(
	output [7:0] count,
	input clk, reset
);

reg [4:0] state_cnter;

always @(posedge clk or posedge reset) begin
	if (reset)
		state_cnter = 5'b0;
	else if (state_cnter == 5'b10001)
		state_cnter <= 5'b00000;
	else
		state_cnter <= state_cnter + 1;
end

function [7:0] state_decoder(input [4:0] state);
  	case (state)
		5'b00000: state_decoder = 8'b00000001;
		5'b00001: state_decoder = 8'b00000001;
		5'b00010: state_decoder = 8'b00000001;
		5'b00011: state_decoder = 8'b00000001;
		5'b00100: state_decoder = 8'b00000010;
		5'b00101: state_decoder = 8'b00000100;
		5'b00110: state_decoder = 8'b00001000;
		5'b00111: state_decoder = 8'b00010000;
		5'b01000: state_decoder = 8'b00100000;
		5'b01001: state_decoder = 8'b01000000;
		5'b01010: state_decoder = 8'b10000000;
		5'b01011: state_decoder = 8'b01000000;
		5'b01100: state_decoder = 8'b00100000;
		5'b01101: state_decoder = 8'b00010000;
		5'b01110: state_decoder = 8'b00001000;
		5'b01111: state_decoder = 8'b00000100;
		5'b10000: state_decoder = 8'b00000010;
		5'b10001: state_decoder = 8'b00000001;
		default: state_decoder = 8'bxxxxxxxx;
	endcase
endfunction

assign count = state_decoder(state_cnter);

endmodule
