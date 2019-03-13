`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company:
// Engineer:
//
// Create Date:    23:36:56 03/03/2019
// Design Name:
// Module Name:    lab01
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
module lab01(
           output [7:0] LED,
           input CLK_50MHZ,
           input RST
       );

wire clk;
clock_divisor clock_divisor (
                  .out(clk),
                  .clk(CLK_50MHZ)
              );

reg [7:0] led_status;
always @(posedge clk or posedge RST) begin
    if (RST) begin
        led_status <= 8'b0000_0000;
    end
    else begin
        case(led_status)
            8'b0000_0000:
                led_status <= 8'b0000_0001;
            8'b1111_1111:
                led_status <= 8'b0000_0001;
            8'b0000_0001:
                led_status <= 8'b0000_0011;
            8'b0000_0011:
                led_status <= 8'b0000_0111;
            8'b0000_0111:
                led_status <= 8'b0000_1111;
            8'b0000_1111:
                led_status <= 8'b0001_1111;
            8'b0001_1111:
                led_status <= 8'b0011_1111;
            8'b0011_1111:
                led_status <= 8'b0111_1111;
            8'b0111_1111:
                led_status <= 8'b1111_1111;
            default:
                led_status <= 8'b0000_0000;
        endcase
    end
end

assign LED = led_status;

endmodule
