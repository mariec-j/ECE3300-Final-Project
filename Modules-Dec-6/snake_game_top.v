`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12/05/2025 12:43:20 PM
// Design Name: 
// Module Name: snake_game_top
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
module snake_game_top(
    input clk,
    input reset,
    input btn_up,
    input btn_down,
    input btn_left,
    input btn_right,
    output [3:0] vga_r,
    output [3:0] vga_g,
    output [3:0] vga_b,
    output vga_hs,
    output vga_vs,
    output [6:0] seg,
    output [7:0] an,
    output led_r,
    output led_g
);

    wire clk_40mhz;
    wire clk_game;
    wire clk_locked;
    
    wire video_on;
    wire [10:0] pixel_x;
    wire [9:0] pixel_y;
    
    wire [1099:0] snake_x_flat;
    wire [999:0] snake_y_flat;
    wire [10:0] snake_head_x;
    wire [9:0] snake_head_y;
    wire [7:0] snake_length;
    wire [10:0] food_x;
    wire [9:0] food_y;
    wire game_over;
    wire [15:0] score;
    
    wire up_pressed, down_pressed, left_pressed, right_pressed;
    
    wire [10:0] rand_x;
    wire [9:0] rand_y;
    wire rand_enable;
    
    assign led_r = game_over;
    assign led_g = !game_over;
    
    clk_wiz_0 clock_generator(
        .clk_in1(clk),
        .clk_40mhz(clk_40mhz),
        .clk_game(clk_game),
        .reset(reset),
        .locked(clk_locked)
    );
    
    button_controller btn_ctrl(
        .clk(clk_game),          // ? CHANGED: Use derived clock
        .reset(reset),
        .btn_up(btn_up),
        .btn_down(btn_down),
        .btn_left(btn_left),
        .btn_right(btn_right),
        .up_pressed(up_pressed),
        .down_pressed(down_pressed),
        .left_pressed(left_pressed),
        .right_pressed(right_pressed)
    );
    
    random_generator rng(
        .clk(clk_game),          // ? CHANGED: Use derived clock
        .reset(reset),
        .enable(rand_enable),
        .rand_x(rand_x),
        .rand_y(rand_y)
    );
    
    vga_controller_800x600 vga_ctrl(
        .clk(clk_40mhz),
        .reset(reset),
        .hsync(vga_hs),
        .vsync(vga_vs),
        .video_on(video_on),
        .pixel_x(pixel_x),
        .pixel_y(pixel_y)
    );
    
    snake_game_logic_800x600 game_logic(
        .clk(clk_game),
        .reset(reset || !clk_locked),
        .up_pressed(up_pressed),
        .down_pressed(down_pressed),
        .left_pressed(left_pressed),
        .right_pressed(right_pressed),
        .rand_x(rand_x),
        .rand_y(rand_y),
        .rand_enable(rand_enable),
        .snake_head_x(snake_head_x),
        .snake_head_y(snake_head_y),
        .snake_length(snake_length),
        .food_x(food_x),
        .food_y(food_y),
        .game_over(game_over),
        .score(score),
        .snake_x_flat(snake_x_flat),
        .snake_y_flat(snake_y_flat)
    );
    
    display_controller_800x600 display(
        .clk(clk_40mhz),
        .video_on(video_on),
        .pixel_x(pixel_x),
        .pixel_y(pixel_y),
        .snake_x_flat(snake_x_flat),
        .snake_y_flat(snake_y_flat),
        .snake_length(snake_length),
        .food_x(food_x),
        .food_y(food_y),
        .game_over(game_over),
        .vga_r(vga_r),
        .vga_g(vga_g),
        .vga_b(vga_b)
    );
    
    seven_seg_controller seg_ctrl(
        .clk(clk_game),          // ? CHANGED: Use derived clock
        .reset(reset),
        .score(score),
        .seg(seg),
        .an(an)
    );

endmodule
