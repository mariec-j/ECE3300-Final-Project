`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12/03/2025 04:38:32 PM
// Design Name: 
// Module Name: direction_input
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


module direction_input (
    input clk, up_button, down_button, left_button, right_button,
    output reg [3:0] direction
);

always @(posedge clk) begin
    if (up_button) direction <= 4'b1000;
    else if (down_button) direction <= 4'b0100;
    else if (left_button) direction <= 4'b0010;
    else if (right_button) direction <= 4'b0001;
    else direction <= direction;
end


endmodule
