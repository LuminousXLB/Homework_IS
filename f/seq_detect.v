`timescale 10 ns / 1 ns

module seq_detect(
	output reg flag,
	input din,
	input clk,
	input rst_n
);

reg [2:0] current_state;
reg [2:0] next_state;

parameter X = 3'bxxx;
parameter A = 3'b000;
parameter B = 3'b001;
parameter C = 3'b010;
parameter D = 3'b011;
parameter E = 3'b100;
parameter F = 3'b101;
parameter G = 3'b110;
parameter H = 3'b111;

always@(posedge clk)
begin
	if(!rst_n)
		current_state <= X;
	else
		current_state <= next_state;
end

always @(*) begin
	case (current_state)
		A: next_state = din ? B : E;
		B: next_state = din ? B : C;
		C: next_state = din ? D : E;
		D: next_state = din ? G : E;
		E: next_state = din ? F : E;
		F: next_state = din ? G : E;
		G: next_state = din ? B : H;
		H: next_state = din ? D : E;
		default: next_state =  din ? A : E;
	endcase
end

always @(posedge clk) begin
	if(!rst_n)
		flag = 1'b0;
	else begin
		case (current_state)
			D: flag = 1'b1;
			H: flag = 1'b1;
			default: flag = 1'b0;
		endcase
	end
end

endmodule
