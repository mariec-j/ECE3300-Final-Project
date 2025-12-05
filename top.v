`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/30/2025 04:12:33 PM
// Design Name: 
// Module Name: top
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


module top(
                input clk,
                input rst,
                input alien_switch, // switch display to alien mode
                input up_switch,  // directions to move the snake
                input down_switch,
                input left_switch,
                input right_switch,
                output [6:0] disp_seg, // display score to 7 seg
                output disp_dp,
                output [7:0] disp_an,
                output led_r, // rgb for game status
                output led_g,
                output led_b, 
                output VGA_HS,
                output VGA_VS,
                output [3:0] VGA_R,
                output [3:0] VGA_G, 
                output [3:0] VGA_B
           );
           
// game variables
wire [7:0] score;    
wire game_status;  

// VGA variables
wire VGA_clk, update_clock, displayArea;
wire [9:0] xCount; 
wire [9:0] yCount; 

// snake variables
wire [3:0] direction;
wire [9:0] snakeX;
wire [9:0] snakeY;

// fruit variables
wire [8:0] randX; 
wire [8:0] randY; 

// color variables for VGA
wire color_Red;
wire color_Green;
wire color_Yellow;

clk_wiz_0 VGA_CLK // module using PLL for vga clock
 (
  // Clock out ports
  .clk_out1(VGA_clk),
  // Status and control signals
  .reset(rst),
  .locked(),
 // Clock in ports
  .clk_in1(clk)
 );
 
update_clk UPDATE_CLK // module updating clock tick of game??
(
    //both use the same 100MHZ input clk_VGA
    .clk_VGA(VGA_clk),
    .clk_up(update_clk)
   // input rst_D
);

VGA_sync VGA // vga module
(
                    .clk_VGA(VGA_clk), //comes from clk divider
                    .x_count(xCount), //tracks horzantial pixel (800) 640 pixels + 160(invisible pixels) = 800 total
                    .y_count(yCount), //tracks the vertical pixels
                    .displayArea(displayArea), //0-639(visible)(displayArea = 1), 640-799(not vible dont draw)(displayArea = 0), 
                    .VGA_hsync(VGA_HS),
                    .VGA_vsync(VGA_VS)
);  

rand_point RAND_POINT // module to generate random point
(
                    .VGA_clk(VGA_clk),
                    .randX(randX), 
                    .randY(randY)
);

direction_input DIRECTION_INPUT // module for button input
(
                    .clk(clk), 
                    .up_button(up_switch), 
                    .down_button(down_switch),
                    .left_button(left_switch),
                    .right_button(right_switch),
                    .direction(direction)
);

snake_game GAME_CORE // snake game core 
(
                        .clk(update_clk),
                        .rst(rst),
                        .snake_x(snakeX), //axis
                        .snake_y(snakeY), //axis
                        .fruit_x_in(randX),
                        .fruit_y_in(randY),
                        .direction(direction),
                        .color_Red(color_Red),
                        .color_Yellow(color_Yellow),
                        .color_Green(color_Green),
                        .game_status(game_status),
                        .score(score)
);

display_driver SCOREBOARD // seven seg display module for score
(
                        .disp_clk(clk), 
                        .disp_rst(rst), 
                        .disp_inp({24'b0, score}),
                        .switch(alien_switch),
                        .disp_seg(disp_seg),
                        .disp_dp(disp_dp),
                        .disp_an(disp_an)
);
                  
rgb_leds RBG // module to control rgb leds to show game status (playing vs not playing) (green vs red)
(
                    .game_status(game_status), 
                    .led_r(led_r),
                    .led_g(led_g),
                    .led_b(led_b)
);

// mapping snake colors to VGA
assign VGA_R = {4{color_Red | color_Yellow}}; // turn on if object is red or yellow (RED + GREEN = YELLOW??)
assign VGA_G = {4{color_Green | color_Yellow}}; // turn if object is green or yellow, replicate 4 times bc VGA_R, G and B are 4 bits not 1
assign VGA_B = 4'b0000;

endmodule
