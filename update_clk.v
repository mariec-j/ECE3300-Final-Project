`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12/04/2025 12:56:59 PM
// Design Name: 
// Module Name: update_clk
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


module update_clk(
    //both use the same 100MHZ input clk_VGA
    input clk_VGA,
    output reg clk_up
   // input rst_D
);
//counter: 100MHz/25Hz = 4,000,000 so we are checking for 4,000,000
//21^2 = 4,194,303 (so yes 21 bits is enough space)
//integer count = 0;
    reg [21:0] count;

    always @(posedge clk_VGA)begin// or posedge input rst_D;)begin
        if(count < 4000000)begin
            count <= count + 1;
            //clk should be low most of the time
            clk_up <= 0;
        end
        else begin
            //when counter reaches target clk goes high
            count <= 0;
            clk_up <= 1;
        end
    end

endmodule