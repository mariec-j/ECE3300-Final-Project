`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12/03/2025 04:39:19 PM
// Design Name: 
// Module Name: rand_point
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


module rand_point (
    input VGA_clk,
    output [9:0] randX, 
    output [8:0] randY
);

reg [9:0] i = 0;
reg [9:0] j = 450;

always @(posedge VGA_clk) begin
    if (i<610) i <= i+1'b1;
    else i <= 0;
end

always @(posedge VGA_clk) begin
    if (j>0) j <= j-1'b1;
    else j <= 10'b480;
end

assign randX = i;
assign randY = j[8:0];

endmodule
