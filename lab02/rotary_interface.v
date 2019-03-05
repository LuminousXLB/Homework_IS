`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    23:34:11 03/05/2019 
// Design Name: 
// Module Name:    rotary 
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
module rotary_interface(
    output rotary_event,
    output rotary_left,
    input a,
    input b,
    input clk
    );

reg rot_q1;
reg rot_q2;

always @(posedge clk) begin
	case ({b, a})
		2'b00:
			{rot_q1, rot_q2} <= {1'b0, rot_q2};
		2'b01:
			{rot_q1, rot_q2} <= {rot_q1, 1'b0};
		2'b10:
			{rot_q1, rot_q2} <= {rot_q1, 1'b1};
		2'b11:
			{rot_q1, rot_q2} <= {1'b1, rot_q2};
		default:
			{rot_q1, rot_q2} <= 2'b00;
	endcase
end

reg delay_rot_q1;
reg rot_event;
reg rot_left;

always @(posedge clk) begin
	delay_rot_q1 <= rot_q1;
	if (rot_q1 && (!delay_rot_q1))
		{rot_event, rot_left} <= {1'b1, rot_q2};
	else
		{rot_event, rot_left} <= {1'b0, rot_left};
end

BUFG bufg_event(.O(rotary_event), .I(rot_event));
assign rotary_left = rot_left;

endmodule
