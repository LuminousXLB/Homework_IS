`timescale 10 ns / 1 ns

module mealy(
	output reg flag,
	input din, clk, rst
);

reg [2:0] state;

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
		flag <= 1'b0;
		state <= M;
	end	else begin
	  	case (state)
			A: begin
				flag <= 1'b0;
				state <= din ? A : B;
			end
			B: begin
				flag <= 1'b0;
				state <= din ? C : M;
			end
			C: begin
				flag <= 1'b0;
				state <= din ? A : D;
			end
			D: begin
				flag <= 1'b0;
				state <= din ? E : M;
			end
			E: begin
				flag <= 1'b0;
				state <= din ? A : F;
			end
			F: begin
				flag <= 1'b0;
				state <= din ? G : M;
			end
			G: begin
				flag <= din ? 1'b0 : 1'b1;
				state <= din ? A : H;
			end
			H: begin
				flag <= 1'b0;
				state <= din ? G : M;
			end
			default: begin
				flag <= 1'b0;
				state <= din ? A : M;
			end
		endcase
	end
end

endmodule
