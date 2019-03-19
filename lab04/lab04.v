`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company:
// Engineer:
//
// Create Date:    09:40:11 03/14/2019
// Design Name:
// Module Name:    lab04
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
// `include "LCD_4bits_interface.v"
// `include "clock_divisor.v"
// `include "char_selector.v"

module lab04 (
           output LCD_E,
           output LCD_RS,
           output LCD_RW,
           output [11:8] SF_D,
           output LED,
           input CLK_50MHZ,
           input BTN_WEST,
           input SW2
       );

assign LED = SW2;

wire clock;
clock_divisor clock_divisor (
                  .clkout(clock),
                  .clock(CLK_50MHZ)
              );

parameter NULL         = 11'b0_00_0000_0000;
parameter FUNCTIONSET  = 11'b1_00_0010_1000;
parameter ENTRYMODESET = 11'b1_00_0000_0110;
parameter DISPLAYON    = 11'b1_00_0000_1100;
parameter CLEARDISPLAY = 11'b1_00_0000_0001;
parameter PAUSE        = 11'b0_11_1111_1111;
reg [10:0] en_rs_rw_data;
reg init;

wire [7:0] char;
reg  [6:0] address;
char_selector char_selector (
                  .char(char),
                  .address(address),
                  .CLK_50MHZ(CLK_50MHZ),
                  .SW2(SW2)
              );

reg [4:0] count;
always @(posedge clock) begin
    if (BTN_WEST) begin
        init <= 1'b1;
        en_rs_rw_data <= NULL;
    end
    else if(init) begin
        case(en_rs_rw_data)
            NULL:
                en_rs_rw_data <= FUNCTIONSET;
            FUNCTIONSET:
                en_rs_rw_data <= ENTRYMODESET;
            ENTRYMODESET:
                en_rs_rw_data <= DISPLAYON;
            DISPLAYON:
                en_rs_rw_data <= CLEARDISPLAY;
            CLEARDISPLAY: begin
                en_rs_rw_data <= PAUSE;
                count <= 5'd0;
            end
            PAUSE: begin
                en_rs_rw_data <= PAUSE;
                if (count == 5'd20) begin
                    init <= 1'b0;
                    count <= 5'b0_0000;
                end
                else begin
                    count <= count + 1;
                end
            end
            default:
                en_rs_rw_data <= NULL;
        endcase
    end
    else begin
        case (count)
            6'b0_0000: begin
                en_rs_rw_data <= {3'b100, 1'b1, 7'h00};
                address <= {count[4], 2'b00, count[3:0]};
                count <= count + 1;
            end
            6'b1_0000: begin
                en_rs_rw_data <= {3'b100, 1'b1, 7'h40};
                address <= {count[4], 2'b00, count[3:0]};
                count <= count + 1;
            end
            default: begin
                address <= {count[4], 2'b00, count[3:0]};
                en_rs_rw_data <= {3'b110, char};
                count <= count + 1;
            end
        endcase

    end
end

wire o_enable;
wire o_rs;
wire o_rw;
wire [7:0] o_data;

assign {o_enable, o_rs, o_rw, o_data} = en_rs_rw_data;
assign o_reset = ~(o_enable & clock);

LCD_4bits_interface LCD_4bits_interface (
                        .LCD_E(LCD_E),
                        .LCD_RS(LCD_RS),
                        .LCD_RW(LCD_RW),
                        .SF_D(SF_D),
                        .clock(CLK_50MHZ),
                        .reset(o_reset),
                        .rs(o_rs),
                        .rw(o_rw),
                        .data(o_data)
                    );


endmodule
