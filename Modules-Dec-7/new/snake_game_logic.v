`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12/05/2025 12:47:05 PM
// Design Name: 
// Module Name: snake_game_logic
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
//module snake_game_logic_800x600(
//    input clk,              // 10 MHz base clock
//    input reset,
//    input up_pressed,
//    input down_pressed,
//    input left_pressed,
//    input right_pressed,
//    input [10:0] rand_x,
//    input [9:0] rand_y,
//    output reg rand_enable,
//    output reg [10:0] snake_head_x,
//    output reg [9:0] snake_head_y,
//    output reg [7:0] snake_length,
//    output reg [10:0] food_x,
//    output reg [9:0] food_y,
//    output reg game_over,
//    output reg [15:0] score,
//    output reg [1099:0] snake_x_flat,  // Flattened array: 100 segments * 11 bits
//    output reg [999:0] snake_y_flat    // Flattened array: 100 segments * 10 bits
//);

//    parameter GRID_SIZE = 20;
//    parameter SNAKE_MAX_LENGTH = 100;
    
//    // Internal arrays for snake positions
//    reg [10:0] snake_x [0:99];
//    reg [9:0] snake_y [0:99];
    
//    reg [1:0] direction;  // 0=right, 1=down, 2=left, 3=up
//    integer i;
    
//    // Clock divider for game speed
//    reg [19:0] game_speed_counter;
//    reg game_tick;
    
//    // Flatten arrays for output
//    always @(*) begin
//        for (i = 0; i < SNAKE_MAX_LENGTH; i = i + 1) begin
//            snake_x_flat[i*11 +: 11] = snake_x[i];
//            snake_y_flat[i*10 +: 10] = snake_y[i];
//        end
//    end
    
//    // Output head position separately for easy access
//    always @(*) begin
//        snake_head_x = snake_x[0];
//        snake_head_y = snake_y[0];
//    end
    
//    always @(posedge clk or posedge reset) begin
//        if (reset) begin
//            game_speed_counter <= 0;
//            game_tick <= 0;
//        end else begin
//            if (game_speed_counter == 20'd1000000 - 1) begin
//                game_speed_counter <= 0;
//                game_tick <= 1;
//            end else begin
//                game_speed_counter <= game_speed_counter + 1;
//                game_tick <= 0;
//            end
//        end
//    end
    
//    always @(posedge clk or posedge reset) begin
//        if (reset) begin
//            snake_x[0] <= 400;
//            snake_y[0] <= 300;
//            for (i = 1; i < SNAKE_MAX_LENGTH; i = i + 1) begin
//                snake_x[i] <= 0;
//                snake_y[i] <= 0;
//            end
//            snake_length <= 3;
//            direction <= 0;
//            food_x <= 500;
//            food_y <= 400;
//            game_over <= 0;
//            score <= 0;
//            rand_enable <= 0;
//        end else if (!game_over && game_tick) begin
//            rand_enable <= 0;
            
//            if (right_pressed && direction != 2) direction <= 0;
//            if (left_pressed && direction != 0) direction <= 2;
//            if (down_pressed && direction != 3) direction <= 1;
//            if (up_pressed && direction != 1) direction <= 3;
            
//            for (i = SNAKE_MAX_LENGTH-1; i > 0; i = i - 1) begin
//                snake_x[i] <= snake_x[i-1];
//                snake_y[i] <= snake_y[i-1];
//            end
            
//            case (direction)
//                0: snake_x[0] <= snake_x[0] + GRID_SIZE;
//                1: snake_y[0] <= snake_y[0] + GRID_SIZE;
//                2: snake_x[0] <= snake_x[0] - GRID_SIZE;
//                3: snake_y[0] <= snake_y[0] - GRID_SIZE;
//            endcase
            
//            if (snake_x[0] < GRID_SIZE || snake_x[0] >= 800-GRID_SIZE ||
//                snake_y[0] < GRID_SIZE || snake_y[0] >= 600-GRID_SIZE) begin
//                game_over <= 1;
//            end
            
//            for (i = 1; i < snake_length; i = i + 1) begin
//                if (snake_x[0] == snake_x[i] && snake_y[0] == snake_y[i]) begin
//                    game_over <= 1;
//                end
//            end
            
//            if (snake_x[0] >= food_x && snake_x[0] < food_x + GRID_SIZE &&
//                snake_y[0] >= food_y && snake_y[0] < food_y + GRID_SIZE) begin
//                if (snake_length < SNAKE_MAX_LENGTH)
//                    snake_length <= snake_length + 1;
//                score <= score + 10;
//                rand_enable <= 1;
//                food_x <= rand_x;
//                food_y <= rand_y;
//            end
//        end
//    end

//endmodule
//////////////////////////////////////////////////////////////
//module snake_game_logic_800x600(
//    input clk,
//    input reset,
//    input up_pressed,
//    input down_pressed,
//    input left_pressed,
//    input right_pressed,
//    input [10:0] rand_x,
//    input [9:0] rand_y,
//    output reg rand_enable,
//    output reg [10:0] snake_head_x,
//    output reg [9:0] snake_head_y,
//    output reg [7:0] snake_length,
//    output reg [10:0] food_x,
//    output reg [9:0] food_y,
//    output reg game_over,
//    output reg [15:0] score,
//    output reg [1099:0] snake_x_flat,
//    output reg [999:0] snake_y_flat
//);

//    parameter GRID_SIZE = 20;
//    parameter SNAKE_MAX_LENGTH = 100;
    
//    reg [10:0] snake_x [0:99];
//    reg [9:0] snake_y [0:99];
    
//    reg [1:0] direction;
//    integer i;
    
//    reg [19:0] game_speed_counter;
//    reg game_tick;
    
//    always @(*) begin
//        for (i = 0; i < SNAKE_MAX_LENGTH; i = i + 1) begin
//            snake_x_flat[i*11 +: 11] = snake_x[i];
//            snake_y_flat[i*10 +: 10] = snake_y[i];
//        end
//    end
    
//    always @(*) begin
//        snake_head_x = snake_x[0];
//        snake_head_y = snake_y[0];
//    end
    
//    always @(posedge clk or posedge reset) begin
//        if (reset) begin
//            game_speed_counter <= 0;
//            game_tick <= 0;
//        end else begin
//            if (game_speed_counter == 20'd1000000 - 1) begin
//                game_speed_counter <= 0;
//                game_tick <= 1;
//            end else begin
//                game_speed_counter <= game_speed_counter + 1;
//                game_tick <= 0;
//            end
//        end
//    end
    
//    always @(posedge clk or posedge reset) begin
//        if (reset) begin
//            // ? FIXED: Properly initialize snake body
//            snake_x[0] <= 400;
//            snake_y[0] <= 300;
//            snake_x[1] <= 380;
//            snake_y[1] <= 300;
//            snake_x[2] <= 360;
//            snake_y[2] <= 300;
            
//            for (i = 3; i < SNAKE_MAX_LENGTH; i = i + 1) begin
//                snake_x[i] <= 0;
//                snake_y[i] <= 0;
//            end
            
//            snake_length <= 3;
//            direction <= 0;
//            food_x <= 500;
//            food_y <= 400;
//            game_over <= 0;
//            score <= 0;
//            rand_enable <= 0;
//        end else if (!game_over && game_tick) begin
//            rand_enable <= 0;
            
//            if (right_pressed && direction != 2) direction <= 0;
//            if (left_pressed && direction != 0) direction <= 2;
//            if (down_pressed && direction != 3) direction <= 1;
//            if (up_pressed && direction != 1) direction <= 3;
            
//            for (i = SNAKE_MAX_LENGTH-1; i > 0; i = i - 1) begin
//                snake_x[i] <= snake_x[i-1];
//                snake_y[i] <= snake_y[i-1];
//            end
            
//            case (direction)
//                0: snake_x[0] <= snake_x[0] + GRID_SIZE;
//                1: snake_y[0] <= snake_y[0] + GRID_SIZE;
//                2: snake_x[0] <= snake_x[0] - GRID_SIZE;
//                3: snake_y[0] <= snake_y[0] - GRID_SIZE;
//            endcase
            
//            if (snake_x[0] < GRID_SIZE || snake_x[0] >= 800-GRID_SIZE ||
//                snake_y[0] < GRID_SIZE || snake_y[0] >= 600-GRID_SIZE) begin
//                game_over <= 1;
//            end
            
//            // ? FIXED: Only check valid body segments
//            for (i = 1; i < snake_length; i = i + 1) begin
//                if (snake_x[i] >= GRID_SIZE && snake_y[i] >= GRID_SIZE &&
//                    snake_x[0] == snake_x[i] && snake_y[0] == snake_y[i]) begin
//                    game_over <= 1;
//                end
//            end
            
//            if (snake_x[0] >= food_x && snake_x[0] < food_x + GRID_SIZE &&
//                snake_y[0] >= food_y && snake_y[0] < food_y + GRID_SIZE) begin
//                if (snake_length < SNAKE_MAX_LENGTH)
//                    snake_length <= snake_length + 1;
//                score <= score + 10;
//                rand_enable <= 1;
//                food_x <= rand_x;
//                food_y <= rand_y;
//            end
//        end
//    end

//endmodule
////////////////////////////////////////////////////
//module snake_game_logic_800x600(
//    input clk,
//    input reset,
//    input up_pressed,
//    input down_pressed,
//    input left_pressed,
//    input right_pressed,
//    input [10:0] rand_x,
//    input [9:0] rand_y,
//    output reg rand_enable,
//    output reg [10:0] snake_head_x,
//    output reg [9:0] snake_head_y,
//    output reg [7:0] snake_length,
//    output reg [10:0] food_x,
//    output reg [9:0] food_y,
//    output reg game_over,
//    output reg [15:0] score,
//    output reg [1099:0] snake_x_flat,
//    output reg [999:0] snake_y_flat
//);

//    parameter GRID_SIZE = 20;
//    parameter SNAKE_MAX_LENGTH = 100;
    
//    reg [10:0] snake_x [0:99];
//    reg [9:0] snake_y [0:99];
    
//    reg [1:0] direction;
//    integer i;
    
//    reg [19:0] game_speed_counter;
//    reg game_tick;
//    reg [7:0] startup_delay;  // ? NEW: Prevent immediate collision
    
//    always @(*) begin
//        for (i = 0; i < SNAKE_MAX_LENGTH; i = i + 1) begin
//            snake_x_flat[i*11 +: 11] = snake_x[i];
//            snake_y_flat[i*10 +: 10] = snake_y[i];
//        end
//    end
    
//    always @(*) begin
//        snake_head_x = snake_x[0];
//        snake_head_y = snake_y[0];
//    end
    
//    always @(posedge clk or posedge reset) begin
//        if (reset) begin
//            game_speed_counter <= 0;
//            game_tick <= 0;
//        end else begin
//            if (game_speed_counter == 20'd1000000 - 1) begin
//                game_speed_counter <= 0;
//                game_tick <= 1;
//            end else begin
//                game_speed_counter <= game_speed_counter + 1;
//                game_tick <= 0;
//            end
//        end
//    end
    
//    always @(posedge clk or posedge reset) begin
//        if (reset) begin
//            snake_x[0] <= 11'd400;
//            snake_y[0] <= 10'd300;
//            snake_x[1] <= 11'd380;
//            snake_y[1] <= 10'd300;
//            snake_x[2] <= 11'd360;
//            snake_y[2] <= 10'd300;
            
//            for (i = 3; i < SNAKE_MAX_LENGTH; i = i + 1) begin
//                snake_x[i] <= 11'd100;  // ? CHANGED: Put off-screen but not at 0
//                snake_y[i] <= 10'd100;
//            end
            
//            snake_length <= 8'd3;
//            direction <= 2'd0;
//            food_x <= 11'd500;
//            food_y <= 10'd400;
//            game_over <= 1'b0;
//            score <= 16'd0;
//            rand_enable <= 1'b0;
//            startup_delay <= 8'd10;  // ? NEW: 10 tick grace period
            
//        end else if (!game_over && game_tick) begin
//            rand_enable <= 1'b0;
            
//            // ? Decrement startup delay
//            if (startup_delay > 0) begin
//                startup_delay <= startup_delay - 1;
//            end
            
//            // Button handling
//            if (right_pressed && direction != 2'd2) direction <= 2'd0;
//            if (left_pressed && direction != 2'd0) direction <= 2'd2;
//            if (down_pressed && direction != 2'd3) direction <= 2'd1;
//            if (up_pressed && direction != 2'd1) direction <= 2'd3;
            
//            // Move snake body
//            for (i = SNAKE_MAX_LENGTH-1; i > 0; i = i - 1) begin
//                snake_x[i] <= snake_x[i-1];
//                snake_y[i] <= snake_y[i-1];
//            end
            
//            // Move snake head
//            case (direction)
//                2'd0: snake_x[0] <= snake_x[0] + GRID_SIZE;
//                2'd1: snake_y[0] <= snake_y[0] + GRID_SIZE;
//                2'd2: snake_x[0] <= snake_x[0] - GRID_SIZE;
//                2'd3: snake_y[0] <= snake_y[0] - GRID_SIZE;
//            endcase
            
//            // ? Only check collisions after startup delay
//            if (startup_delay == 0) begin
//                // Wall collision
//                if (snake_x[0] <= GRID_SIZE || snake_x[0] >= (11'd800 - GRID_SIZE) ||
//                    snake_y[0] <= GRID_SIZE || snake_y[0] >= (10'd600 - GRID_SIZE)) begin
//                    game_over <= 1'b1;
//                end
                
//                // Self collision - only check actual body segments
//                for (i = 4; i < snake_length; i = i + 1) begin  // ? Start at 4, not 1
//                    if (snake_x[0] == snake_x[i] && snake_y[0] == snake_y[i]) begin
//                        game_over <= 1'b1;
//                    end
//                end
//            end
            
//            // Food collision
//            if (snake_x[0] >= food_x && snake_x[0] < (food_x + GRID_SIZE) &&
//                snake_y[0] >= food_y && snake_y[0] < (food_y + GRID_SIZE)) begin
//                if (snake_length < SNAKE_MAX_LENGTH)
//                    snake_length <= snake_length + 1;
//                score <= score + 16'd10;
//                rand_enable <= 1'b1;
//                food_x <= rand_x;
//                food_y <= rand_y;
//            end
//        end
//    end

//endmodule
///////////////////////////////////////////////
//module snake_game_logic_800x600(
//    input clk,
//    input reset,
//    input up_pressed,
//    input down_pressed,
//    input left_pressed,
//    input right_pressed,
//    input [10:0] rand_x,
//    input [9:0] rand_y,
//    output reg rand_enable,
//    output reg [10:0] snake_head_x,
//    output reg [9:0] snake_head_y,
//    output reg [7:0] snake_length,
//    output reg [10:0] food_x,
//    output reg [9:0] food_y,
//    output reg game_over,
//    output reg [15:0] score,
//    output reg [1099:0] snake_x_flat,
//    output reg [999:0] snake_y_flat
//);

//    parameter GRID_SIZE = 20;
//    parameter SNAKE_MAX_LENGTH = 100;
    
//    reg [10:0] snake_x [0:99];
//    reg [9:0] snake_y [0:99];
    
//    reg [1:0] direction;
//    integer i;
    
//    reg [19:0] game_speed_counter;
//    reg game_tick;
//    reg [7:0] move_count;  // Count moves instead of startup delay
    
//    always @(*) begin
//        for (i = 0; i < SNAKE_MAX_LENGTH; i = i + 1) begin
//            snake_x_flat[i*11 +: 11] = snake_x[i];
//            snake_y_flat[i*10 +: 10] = snake_y[i];
//        end
//    end
    
//    always @(*) begin
//        snake_head_x = snake_x[0];
//        snake_head_y = snake_y[0];
//    end
    
//    always @(posedge clk or posedge reset) begin
//        if (reset) begin
//            game_speed_counter <= 0;
//            game_tick <= 0;
//        end else begin
//            if (game_speed_counter == 20'd1000000 - 1) begin
//                game_speed_counter <= 0;
//                game_tick <= 1;
//            end else begin
//                game_speed_counter <= game_speed_counter + 1;
//                game_tick <= 0;
//            end
//        end
//    end
    
//    always @(posedge clk or posedge reset) begin
//        if (reset) begin
//            // Initialize snake in safe center position
//            snake_x[0] <= 11'd400;
//            snake_y[0] <= 10'd300;
//            snake_x[1] <= 11'd380;
//            snake_y[1] <= 10'd300;
//            snake_x[2] <= 11'd360;
//            snake_y[2] <= 10'd300;
            
//            // Rest off-screen
//            for (i = 3; i < SNAKE_MAX_LENGTH; i = i + 1) begin
//                snake_x[i] <= 11'd1000;  // Far off screen
//                snake_y[i] <= 10'd1000;
//            end
            
//            snake_length <= 8'd3;
//            direction <= 2'd0;  // Start moving right
//            food_x <= 11'd500;
//            food_y <= 10'd400;
//            game_over <= 1'b0;
//            score <= 16'd0;
//            rand_enable <= 1'b0;
//            move_count <= 8'd0;
            
//        end else if (!game_over && game_tick) begin
//            rand_enable <= 1'b0;
            
//            // Increment move counter
//            if (move_count < 255)
//                move_count <= move_count + 1;
            
//            // Button handling - BEFORE movement
//            if (right_pressed && direction != 2'd2) direction <= 2'd0;
//            if (left_pressed && direction != 2'd0) direction <= 2'd2;
//            if (down_pressed && direction != 2'd3) direction <= 2'd1;
//            if (up_pressed && direction != 2'd1) direction <= 2'd3;
            
//            // Move snake body
//            for (i = SNAKE_MAX_LENGTH-1; i > 0; i = i - 1) begin
//                snake_x[i] <= snake_x[i-1];
//                snake_y[i] <= snake_y[i-1];
//            end
            
//            // Move snake head
//            case (direction)
//                2'd0: snake_x[0] <= snake_x[0] + GRID_SIZE;  // Right
//                2'd1: snake_y[0] <= snake_y[0] + GRID_SIZE;  // Down
//                2'd2: snake_x[0] <= snake_x[0] - GRID_SIZE;  // Left
//                2'd3: snake_y[0] <= snake_y[0] - GRID_SIZE;  // Up
//            endcase
            
//            // Food collision (check first, before wall collision)
//            if (snake_x[0] >= food_x && snake_x[0] < (food_x + GRID_SIZE) &&
//                snake_y[0] >= food_y && snake_y[0] < (food_y + GRID_SIZE)) begin
//                if (snake_length < SNAKE_MAX_LENGTH)
//                    snake_length <= snake_length + 1;
//                score <= score + 16'd10;
//                rand_enable <= 1'b1;
//                food_x <= rand_x;
//                food_y <= rand_y;
//            end
            
//            // Collision detection - ONLY after first 3 moves
//            if (move_count > 3) begin
//                // Wall collision - check if head is AT or PAST the border
//                if (snake_x[0] <= 11'd20 || snake_x[0] >= 11'd780 ||
//                    snake_y[0] <= 10'd20 || snake_y[0] >= 10'd580) begin
//                    game_over <= 1'b1;
//                end
                
//                // Self collision - only check segments that are far enough away
//                for (i = 5; i < snake_length; i = i + 1) begin
//                    if (snake_x[0] == snake_x[i] && snake_y[0] == snake_y[i]) begin
//                        game_over <= 1'b1;
//                    end
//                end
//            end
//        end
//    end

//endmodule



////////////WONT DIE BELOW
module snake_game_logic_800x600(
    input clk,
    input reset,
    input up_pressed,
    input down_pressed,
    input left_pressed,
    input right_pressed,
    input [10:0] rand_x,
    input [9:0] rand_y,
    output reg rand_enable,
    output reg [10:0] snake_head_x,
    output reg [9:0] snake_head_y,
    output reg [7:0] snake_length,
    output reg [10:0] food_x,
    output reg [9:0] food_y,
    output reg game_over,
    output reg [15:0] score,
    output reg [1099:0] snake_x_flat,
    output reg [999:0] snake_y_flat
);

    parameter GRID_SIZE = 20;
    parameter SNAKE_MAX_LENGTH = 100;
    
    reg [10:0] snake_x [0:99];
    reg [9:0] snake_y [0:99];
    
    reg [1:0] direction;
    integer i;
    
    reg [19:0] game_speed_counter;
    reg game_tick;
    
    always @(*) begin
        for (i = 0; i < SNAKE_MAX_LENGTH; i = i + 1) begin
            snake_x_flat[i*11 +: 11] = snake_x[i];
            snake_y_flat[i*10 +: 10] = snake_y[i];
        end
    end
    
    always @(*) begin
        snake_head_x = snake_x[0];
        snake_head_y = snake_y[0];
    end
    
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            game_speed_counter <= 0;
            game_tick <= 0;
        end else begin
            if (game_speed_counter == 20'd1000000 - 1) begin
                game_speed_counter <= 0;
                game_tick <= 1;
            end else begin
                game_speed_counter <= game_speed_counter + 1;
                game_tick <= 0;
            end
        end
    end
    
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            snake_x[0] <= 11'd400;
            snake_y[0] <= 10'd300;
            snake_x[1] <= 11'd380;
            snake_y[1] <= 10'd300;
            snake_x[2] <= 11'd360;
            snake_y[2] <= 10'd300;
            
            for (i = 3; i < SNAKE_MAX_LENGTH; i = i + 1) begin
                snake_x[i] <= 11'd0;
                snake_y[i] <= 10'd0;
            end
            
            snake_length <= 8'd3;
            direction <= 2'd0;
            food_x <= 11'd500;
            food_y <= 10'd400;
            game_over <= 1'b0;  // ? NEVER set to 1
            score <= 16'd0;
            rand_enable <= 1'b0;
            
        end else if (game_tick) begin  // ? REMOVED: !game_over check
            rand_enable <= 1'b0;
            
            // Button handling
            if (right_pressed) direction <= 2'd0;
            if (left_pressed) direction <= 2'd2;
            if (down_pressed) direction <= 2'd1;
            if (up_pressed) direction <= 2'd3;
            
            // Move snake body
            for (i = SNAKE_MAX_LENGTH-1; i > 0; i = i - 1) begin
                snake_x[i] <= snake_x[i-1];
                snake_y[i] <= snake_y[i-1];
            end
            
            // Move snake head
            case (direction)
                2'd0: snake_x[0] <= snake_x[0] + GRID_SIZE;
                2'd1: snake_y[0] <= snake_y[0] + GRID_SIZE;
                2'd2: snake_x[0] <= snake_x[0] - GRID_SIZE;
                2'd3: snake_y[0] <= snake_y[0] - GRID_SIZE;
            endcase
            
            // ? COMPLETELY REMOVED: All collision detection
            // Snake can go through walls and itself!
            
            // Food collision
            if (snake_x[0] >= food_x && snake_x[0] < (food_x + GRID_SIZE) &&
                snake_y[0] >= food_y && snake_y[0] < (food_y + GRID_SIZE)) begin
                score <= score + 16'd10;
                rand_enable <= 1'b1;
                food_x <= rand_x;
                food_y <= rand_y;
            end
        end
    end

endmodule