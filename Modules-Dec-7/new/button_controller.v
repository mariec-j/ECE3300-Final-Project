`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12/05/2025 12:49:34 PM
// Design Name: 
// Module Name: button_controller
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////
module button_controller(
    input clk,              // 100 MHz clock
    input reset,
    input btn_up,
    input btn_down,
    input btn_left,
    input btn_right,
    output reg up_pressed,
    output reg down_pressed,
    output reg left_pressed,
    output reg right_pressed
);

always @(posedge clk) begin
    if (up_button) begin
        up_pressed <= 1;
        down_pressed <= 0;
        left_pressed <= 0;
        right_pressed <= 0;
    end
    else if (down_button) begin
        up_pressed <= 0;
        down_pressed <= 1;
        left_pressed <= 0;
        right_pressed <= 0;
    end
    else if (btn_left) begin
        up_pressed <= 0;
        down_pressed <= 0;
        left_pressed <= 1;
        right_pressed <= 0;
    end
    else if (btn_right) begin
        up_pressed <= 0;
        down_pressed <= 0;
        left_pressed <= 0;
        right_pressed <= 1;
    end
end


endmodule
