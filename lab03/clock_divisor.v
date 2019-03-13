`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company:
// Engineer:
//
// Create Date:    00:22:42 03/14/2019
// Design Name:
// Module Name:    clock_divisor
// Project Name:
// Target Devices:
// Tool versions:
// Description:
//
// Dependencies:
//
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
//
//////////////////////////////////////////////////////////////////////////////////
module clock_divisor(
           output clkout,
           input clock
       );

reg [10:0] count = 11'b0;
always @(posedge clock) begin
    if (count == 11'd1039)
        count <= 11'b0;
    else
        count <= count + 1;
end

assign count_enable = count == 11'b0;

reg clkout_buf = 1'b0;
always @(posedge clock) begin
    if(count_enable)
        clkout_buf <= ~clkout_buf;
end

BUFG bufg(.O(clkout), .I(clkout_buf));

endmodule
