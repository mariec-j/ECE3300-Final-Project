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
    output reg [9:0] randX, 
    output reg [8:0] randY
);

// initialize counters
initial begin
    randX = 0;
    randY = 480;
    end

always @(posedge VGA_clk) begin
// X counter
    if (randX < 610)
        randX <= randX + 1;
    else 
        randX <= 0;
end
        
always @(posedge VGA_clk) begin
// Y counter
    if (randY > 0)
        randY <= randY - 1;
    else
        randY <= 480;
end

endmodule
