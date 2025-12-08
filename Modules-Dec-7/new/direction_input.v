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
    output [3:0] direction
);

reg [3:0] temp_dir;
always @(posedge clk) begin
    if (up_button) temp_dir <= 4'b1000;
    else if (down_button) temp_dir <= 4'b0100;
    else if (left_button) temp_dir <= 4'b0010;
    else if (right_button) temp_dir <= 4'b0001;
    else temp_dir <= temp_dir;
end

assign direction = temp_dir;

endmodule
