`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    09:40:54 03/14/2019 
// Design Name: 
// Module Name:    stop_watch 
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
`include "BCD_counter.v"
`include "time_counter.v"

module stop_watch (
           output [19:0] bcd_time,
           input CLK_50MHZ,
           input reset
       );

reg [23:0] clock_count;
assign enable =  (clock_count == 24'd4_999_999);
always @(posedge CLK_50MHZ) begin
    if(reset || clock_count == 24'd4_999_999)
        clock_count <= 0;
    else
        clock_count <= clock_count + 1;
end

wire hm_carry;
BCD_counter hm_counter (
                .count(bcd_time[3:0]),
                .max(hm_carry),
                .clock(CLK_50MHZ),
                .reset(reset),
                .enable(enable)
            );

wire ss_clock;
wire ss_carry;
BUFG ssclkbuf(.O(ss_clock), .I(bcd_time[0]));
time_counter ss_counter (
                 .count(bcd_time[11:4]),
                 .max(ss_carry),
                 .clock(ss_clock),
                 .reset(reset),
                 .enable(hm_carry)
             );

wire mm_clock;
BUFG mmclkbuf(.O(mm_clock), .I(bcd_time[4]));
time_counter mm_counter (
                 .count(bcd_time[19:12]),
                 .max(),
                 .clock(mm_clock),
                 .reset(reset),
                 .enable(ss_carry)
             );

endmodule
