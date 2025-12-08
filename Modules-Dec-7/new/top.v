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
                input alien_switch,
                output disp_seg,
                output disp_dp,
                output disp_an,
                output led_r, // rgb for game status
                output led_g,
                output led_b
           );
           
reg [7:0] score;    
reg game_status;     
snake_game GAME_CORE(
                        .clk(),
                        .rst(rst),
                        .snake_x(), //axis
                        .snake_y(), //axis
                        .fruit_x(),
                        .fruit_y(),
                        .direction(),
                        .color_Red(),
                        .color_Yellow(),
                        .color_Green(),
                        .game_status(game_status),
                        .score(score)
                    );

display_driver SCOREBOARD(
                        .disp_clk(), 
                        .disp_rst(rst), 
                        .disp_inp({24'b0, score}),
                        .switch(alien_switch),
                        .disp_seg(disp_seg),
                        .disp_dp(disp_dp),
                        .disp_an(disp_an)
                  );
                  
rgb_leds RBG(
                    .game_status(game_status), 
                    .led_r(led_r),
                    .led_g(led_g),
                    .led_b(led_b)
               );
direction_input DIRECTION_INPUT(
                    .clk(), 
                    .up_button(), 
                    .down_button(),
                    .left_button(),
                    .right_button(),
                    .direction()
);

rand_point RAND_POINT(
                    .VGA_clk(),
                    .randX(), 
                    .randY()
);

update_clk UPDATE_CLK(
                    //both use the same 100MHZ input clk_VGA
                    .clk_VGA(),
                    .clk_up()
                   // input rst_D
);

snake_clk_divider CLK_DIVIDER(
                    .clk_VGA(),
                    //input rst_D,
                    .clk_D_out()
);

VGA_sync VGA(
                    .clk_VGA(), //comes from clk divider
                    .x_count(), //tracks horzantial pixel (800) 640 pixels + 160(invisible pixels) = 800 total
                    .y_count(), //tracks the vertical pixels
                    .displayArea(), //0-639(visible)(displayArea = 1), 640-799(not vible dont draw)(displayArea = 0), 
                    .VGA_hsync(),
                    .VGA_vsync()
);  
endmodule
