`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company:
// Engineer:
//
// Create Date:    23:38:03 03/03/2019
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
           output out,
           input clk
       );

reg [24:0]counter = 25'b0;
always @(posedge clk) begin
    if (counter == 25'd24_999_999) begin
        counter <= 25'b0;
    end
    else
        counter <= counter + 1;
end

assign count_enable = (counter == 25'b0);

reg out_buf = 1'b0;
always @(posedge clk) begin
    if(count_enable)
        out_buf <= ~out_buf;
end

BUFG bufg(.O(out), .I(out_buf));

endmodule
