`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company:
// Engineer:
//
// Create Date:    11:16:09 03/14/2019
// Design Name:
// Module Name:    clock_div7
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
module clock_div7(
           output clk_div7,
           input clock,
           input rst_n
       );

reg [6:0] state;

always @(posedge clock or negedge rst_n) begin
    if(!rst_n)
        state <= 7'b0000001;
    else
        state <= {state[0], state[6:1]};
end

BUFG bufg(.O(clk_div7), .I(state[0]));

endmodule
