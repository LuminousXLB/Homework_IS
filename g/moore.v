`timescale 10 ns / 1 ns

module moore(
	output reg flag,
	input din, clk, rst
);

reg [2:0] current_state;
reg [2:0] next_state;

parameter A = 3'b000;
parameter B = 3'b001;
parameter C = 3'b010;
parameter D = 3'b011;
parameter E = 3'b100;
parameter F = 3'b101;
parameter G = 3'b110;
parameter H = 3'b111;
parameter M = 3'bXXX;

always @(posedge clk or posedge rst) begin
	if (rst) begin
		current_state <= M;
	end else begin
		current_state <= next_state;
	end
end

always @(*) begin
	case (current_state)
		A: next_state = din ? A : B;
		B: next_state = din ? C : M;
		C: next_state = din ? A : D;
		D: next_state = din ? E : M;
		E: next_state = din ? A : F;
		F: next_state = din ? G : M;
		G: next_state = din ? A : H;
		H: next_state = din ? G : M;
		default: next_state = din ? A : M;
	endcase
end

always @(posedge clk or posedge rst) begin
	if (rst) begin
		flag = 1'b0;
	end else if (current_state == H)  begin
		flag = 1'b1;
	end else begin
		flag = 1'b0;
	end
end

endmodule
