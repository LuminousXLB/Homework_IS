`timescale 10 ns / 1 ns

module sram(
	output [7:0] dout,
	input [7:0] din,
	input [7:0] addr,
	input wr,
	input rd,
	input cs
);

reg [7:0] mem[0:255];
reg [7:0] data;

assign dout = (cs && !rd) ? data : 8'bz;

always @(posedge wr) begin
    if (cs && wr && rd) begin
        mem[addr] <= din;
    end
end

always @(negedge rd) begin
    if (cs && !rd) begin
        data <= mem[addr];
    end
end

endmodule
