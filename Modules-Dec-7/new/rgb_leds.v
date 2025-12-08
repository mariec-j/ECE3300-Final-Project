`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/30/2025 03:31:44 PM
// Design Name: 
// Module Name: rgb_leds
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


module rgb_leds(
                    input game_status, // 1 = playing, 0 = game over
                    output reg led_r,
                    output reg led_g,
                    output reg led_b
               );
               
               always @(*) begin
                if(game_status == 1) begin
                    led_r = 1'b0;
                    led_g = 1'b1;
                    led_b = 1'b0;
                    end
                else begin
                    led_r = 1'b1;
                    led_g = 1'b0;
                    led_b = 1'b0;
                    end
                    end        
endmodule
