`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company:
// Engineer:
//
// Create Date:    11:22:54 03/14/2019
// Design Name:
// Module Name:    counter
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
module counter(
           output reg [5:0] count,
           input clock,
           input rst_n,
           input dir
       );

always @(posedge clock or negedge rst_n) begin
    if(!rst_n)
        count <= dir ? 6'h3f : 6'h00;
    else
        count <= dir ? count - 1 : count + 1;
end

endmodule
