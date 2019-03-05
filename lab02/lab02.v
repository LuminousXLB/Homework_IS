`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    23:29:50 03/05/2019 
// Design Name: 
// Module Name:    lab02 
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
module lab02(
    output [7:0] LED,
    input SW3,
    input ROT_A,
    input ROT_B,
    input RST,
    input CLK_50MHZ
    );
	 
wire rotary_event;
wire rotary_left;

rotary_interface rotary (
    .rotary_event(rotary_event), 
    .rotary_left(rotary_left), 
    .a(ROT_A), 
    .b(ROT_B), 
    .clk(CLK_50MHZ)
    );

reg [7:0] led_status;
always @(posedge rotary_event or posedge RST) begin
   if(RST) 
		led_status <= 8'b0000_0001;
	else 
		case (led_status)
        8'b0000_0001 :
            led_status <= rotary_left ? 8'b0000_0010 : 8'b1000_0000 ;
        8'b0000_0010 :
            led_status <= rotary_left ? 8'b0000_0100 : 8'b0000_0001 ;
        8'b0000_0100 :
            led_status <= rotary_left ? 8'b0000_1000 : 8'b0000_0010 ;
        8'b0000_1000 :
            led_status <= rotary_left ? 8'b0001_0000 : 8'b0000_0100 ;
        8'b0001_0000 :
            led_status <= rotary_left ? 8'b0010_0000 : 8'b0000_1000 ;
        8'b0010_0000 :
            led_status <= rotary_left ? 8'b0100_0000 : 8'b0001_0000 ;
        8'b0100_0000 :
            led_status <= rotary_left ? 8'b1000_0000 : 8'b0010_0000 ;
        8'b1000_0000 :
            led_status <= rotary_left ? 8'b0000_0001 : 8'b0100_0000 ;
        default:
            led_status <= 8'b0000_0001 ;
    endcase
end

assign LED = SW3 ? led_status : ~led_status;

endmodule
