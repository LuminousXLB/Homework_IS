`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company:
// Engineer:
//
// Create Date:    00:22:21 03/14/2019
// Design Name:
// Module Name:    LCD_4bits_interface
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
module LCD_4bits_interface(
           output LCD_E,
           output LCD_RS, // 0 = Command, 1 = Data
           output LCD_RW,
           output [11:8]SF_D, // Valid Data
           input clock,
           input reset,
           input rs,
           input rw,
           input [7:0]data
       );

// clock counter
reg [7:0] clock_count;
always @(posedge clock) begin
    if (reset)
        clock_count <= 8'b0;
    else if(clock_count[7])
        clock_count <= clock_count;
    else
        clock_count <= clock_count + 1;
end

// internal state signal
reg active, setup, hold;
always @(*) begin
    if(clock_count[7] || reset)
        {active, hold, setup} = 3'b000;
    else if(clock_count[5:4])
        {active, hold, setup} = 3'b100;
    else if(clock_count[3:2])
        {active, hold, setup} = 3'b110;
    else
        {active, hold, setup} = 3'b101;
end

// data bus
assign LCD_RS = rs;
assign SF_D = clock_count[6] ? data[3:0] : data[7:4];

// control bus
assign LCD_RW = active && (setup || hold) ? rw :1'b1;
assign LCD_E = active && hold;

endmodule
