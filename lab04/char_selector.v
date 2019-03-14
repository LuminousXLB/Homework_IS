`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company:
// Engineer:
//
// Create Date:    09:36:35 03/14/2019
// Design Name:
// Module Name:    char_selector
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
`include "stop_watch.v"

module char_selector(
           output reg [7:0] char,
           input [6:0] address,
           input CLK_50MHZ,
           input SW3
       );

wire [19:0] bcd_time;
stop_watch stop_watch (
               .bcd_time(bcd_time),
               .CLK_50MHZ(CLK_50MHZ),
               .reset(SW3)
           );

parameter [0:127] line0 = "  Stopwatch     ";
parameter [0:127] line1 = "Time:mm:ss:u    ";

always @(*) begin
    if(!address[6])
        char = line0[{address[3:0], 3'b000}+:8];
    else
    case(address[5:0])
        5:
            char = {4'h3, bcd_time[19:16]};
        6:
            char = {4'h3, bcd_time[15:12]};
        8:
            char = {4'h3, bcd_time[11:8]};
        9:
            char = {4'h3, bcd_time[7:4]};
        11:
            char = {4'h3, bcd_time[3:0]};
        default:
            char = line1[{address[3:0], 3'b000}+:8];
    endcase
end

endmodule
