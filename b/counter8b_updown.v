`timescale 10 ns / 1 ns

module counter8b_updown(output reg [7:0] count, input clk, reset, dir);

always @(posedge clk or posedge reset) begin
	if (reset) begin
		count <= 8'b0;
	end else if (dir) begin
		count <= count + 1;
	end else begin
		count <= count - 1;
	end
end

endmodule
