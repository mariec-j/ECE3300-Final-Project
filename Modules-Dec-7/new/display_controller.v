`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12/05/2025 12:48:01 PM
// Design Name: 
// Module Name: display_controller
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
module display_controller_800x600(
    input clk,
    input video_on,
    input [10:0] pixel_x,
    input [9:0] pixel_y,
    input [1099:0] snake_x_flat,  // Flattened: 100 segments * 11 bits
    input [999:0] snake_y_flat,   // Flattened: 100 segments * 10 bits
    input [7:0] snake_length,
    input [10:0] food_x,
    input [9:0] food_y,
    input game_over,
    output reg [3:0] vga_r,
    output reg [3:0] vga_g,
    output reg [3:0] vga_b
);

    parameter GRID_SIZE = 20;
    parameter SNAKE_MAX_LENGTH = 100;
    
    // Unflatten arrays
    reg [10:0] snake_x [0:99];
    reg [9:0] snake_y [0:99];
    
    integer i;
    reg is_snake, is_head, is_food, is_border;
    
    // Unflatten the input arrays
    always @(*) begin
        for (i = 0; i < SNAKE_MAX_LENGTH; i = i + 1) begin
            snake_x[i] = snake_x_flat[i*11 +: 11];
            snake_y[i] = snake_y_flat[i*10 +: 10];
        end
    end
    
    always @(*) begin
        vga_r = 4'h0;
        vga_g = 4'h0;
        vga_b = 4'h0;
        
        is_snake = 0;
        is_head = 0;
        is_food = 0;
        is_border = 0;
        
        if (video_on) begin
            for (i = 0; i < snake_length; i = i + 1) begin
                if (pixel_x >= snake_x[i] && pixel_x < snake_x[i] + GRID_SIZE &&
                    pixel_y >= snake_y[i] && pixel_y < snake_y[i] + GRID_SIZE) begin
                    is_snake = 1;
                    if (i == 0)
                        is_head = 1;
                end
            end
            
            if (pixel_x >= food_x && pixel_x < food_x + GRID_SIZE &&
                pixel_y >= food_y && pixel_y < food_y + GRID_SIZE) begin
                is_food = 1;
            end
            
            if (pixel_x < GRID_SIZE || pixel_x >= 800-GRID_SIZE ||
                pixel_y < GRID_SIZE || pixel_y >= 600-GRID_SIZE) begin
                is_border = 1;
            end
            
            if (game_over) begin
                vga_r = 4'hF;
                vga_g = 4'h0;
                vga_b = 4'h0;
            end else if (is_snake) begin
                vga_r = 4'h0;
                vga_g = is_head ? 4'hF : 4'h8;
                vga_b = 4'h0;
            end else if (is_food) begin
                vga_r = 4'hF;
                vga_g = 4'h0;
                vga_b = 4'h0;
            end else if (is_border) begin
                vga_r = 4'h0;
                vga_g = 4'h0;
                vga_b = 4'h8;
            end
        end
    end

endmodule