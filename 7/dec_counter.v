`timescale 10 ns / 1 ns

module dec_counter(output reg [4:0] count, input clk, reset);

always @(posedge clk) begin
	if (reset)
		count <= 4'b0;
	else begin
		if (count == 9)
			count <= 0;
		else
			count <= count + 1;
	end
end

endmodule
