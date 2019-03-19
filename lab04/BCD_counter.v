`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company:
// Engineer:
//
// Create Date:    09:36:14 03/14/2019
// Design Name:
// Module Name:    BCD_counter
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
module BCD_counter (
           output reg [3:0] count,
           output max,
           input clock,
           input reset,
           input enable
       );

always @ (posedge clock) begin
    if (reset)
        count <= 0;
    else if(enable)
        if(count == 4'd9)
            count <= 0;
        else
            count <= count + 1;
end

assign max = (count == 4'd9);

endmodule

