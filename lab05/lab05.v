`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company:
// Engineer:
//
// Create Date:    11:11:10 03/14/2019
// Design Name:
// Module Name:    lab05
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
module lab05(
           output [7:2] LED,
           input CLK_50MHZ,
           input [1:0] SW
       );

wire clock;
clock_div7 clock_div7 (
               .clk_div7(clock),
               .clock(CLK_50MHZ),
               .rst_n(SW[0])
           );

wire [5:0] count;
counter counter (
            .count(count),
            .clock(clock),
            .rst_n(SW[0]),
            .dir(SW[1])
        );
		  
assign LED = count;

wire [35:0] CONTROL0;
//----------- Begin Cut here for INSTANTIATION Template ---// INST_TAG
CNT_ICON YourInstanceName (
    .CONTROL0(CONTROL0) // INOUT BUS [35:0]
);

// INST_TAG_END ------ End INSTANTIATION Template ---------

//----------- Begin Cut here for INSTANTIATION Template ---// INST_TAG
CNT_ILA CNT_ILA_inst (
    .CONTROL(CONTROL0), // INOUT BUS [35:0]
    .CLK(CLK_50MHZ), // IN
    .DATA(count), // IN BUS [5:0]
    .TRIG0(count[5:4]) // IN BUS [1:0]
);

// INST_TAG_END ------ End INSTANTIATION Template ---------

endmodule
