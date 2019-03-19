`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company:
// Engineer:
//
// Create Date:    09:41:19 03/14/2019
// Design Name:
// Module Name:    time_counter
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
//`include "BCD_counter.v"

module time_counter(
           output [7:0] count,
           output max,
           input clock,
           input reset,
           input enable
       );

wire [3:0] low_count;
wire low_max;
BCD_counter low_bcd (
                .count(low_count),
                .max(low_max),
                .clock(clock),
                .reset(reset),
                .enable(enable)
            );

reg [3:0] high_count;
always @(posedge clock) begin
    if (reset)
        high_count <= 0;
    else if(low_max && enable)
        if (high_count == 5)
            high_count <= 0;
        else
            high_count <= high_count + 1;
end

assign count = {high_count, low_count};
assign max = (high_count == 5);

endmodule
