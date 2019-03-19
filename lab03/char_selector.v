`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company:
// Engineer:
//
// Create Date:    00:23:27 03/14/2019
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
module char_selector(
           output reg [7:0] char,
           input [6:0] address
       );

wire [0:127] memory;
assign memory = (!address[6]) ? "Spartan-3E FPGA ": "FPGA Starter    ";

always @(*) begin
    case(address[5:0])
        0:
            char = memory[0:7];
        1:
            char = memory[8:15];
        2:
            char = memory[16:23];
        3:
            char = memory[24:31];
        4:
            char = memory[32:39];
        5:
            char = memory[40:47];
        6:
            char = memory[48:55];
        7:
            char = memory[56:63];
        8:
            char = memory[64:71];
        9:
            char = memory[72:79];
        10:
            char = memory[80:87];
        11:
            char = memory[88:95];
        12:
            char = memory[96:103];
        13:
            char = memory[104:111];
        14:
            char = memory[112:119];
        15:
            char = memory[120:127];
        default:
            char = " ";
    endcase
end

endmodule
