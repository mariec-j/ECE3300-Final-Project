`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/30/2025 03:41:59 PM
// Design Name: 
// Module Name: snake_game
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

module snake_game(
input clk,
input rst,
output reg [7:0] snake_x, //axis
output reg [7:0] snake_y, //axis
output reg [7:0] fruit_x,
output reg [7:0] fruit_y,
output reg [1:0] direction,
output reg [7:0] color_Red,
output reg [7:0] color_Yellow,
output reg [7:0] color_Green,
output reg game_status, // to display red or green on rgb leds 
output reg [7:0] score
);
//defines the body of the frame
parameter WIDTH = 140;
parameter HEIGHT = 140;
//the snakes initial length(starts as 1 and inc by 1 as it eats)
parameter initial_length = 1;
parameter max_length = 2159; //where does this # come from?
//choosing direction by using a two bit reg
parameter [1:0] right = 2'b00;
parameter [1:0] left = 2'b01;
parameter [1:0] down = 2'b10;
parameter [1:0] up = 2'b11;

//initial start defines the initail position of the snake and randomly generate fruits starting position
//(snake_x)/2 && (snake_y)/2 just puts starting snake in the middle
initial begin
    //center snake
    snake_x = WIDTH/2;
    snake_y = WIDTH/2;
    //make snake go up
    direction = left;
    //randomiaze fruit location
    fruit_x = $random % WIDTH;
    fruit_y = $random % HEIGHT;
end

//making directions - so if u go right inc x axis by 1 etc....
always @(posedge clk)begin //when clk is High
    if(!rst)begin //so if reset does not happen
        case(direction) 
            right: snake_x <= snake_x + 1;
            left: snake_x <= snake_x - 1;
            up: snake_y <= snake_y + 1;
            down: snake_y <= snake_y - 1;
        endcase
    end     
end

// adding score info
always @(posedge clk) begin
    if(rst)
        score <= 0;
    else if (snake_x == fruit_x && snake_y == fruit_y)
        score <= score + 1;
    end
    
always @(*) begin
    //checking if snake lands on fruit & yellow color is displayed
    if(snake_x == fruit_x && snake_y == fruit_y)begin
        //if does land on fruit than... randomize fruit again
        fruit_x = $random % WIDTH;
        fruit_y = $random % HEIGHT;
        //inc snake size by one bc it ate the apple
        snake_y = snake_y + 1;
        //displaying yellow
        color_Red = 8'b0000_0000;
        color_Yellow = 8'b1111_1111;
        color_Green = 8'b0000_0000;
        game_status = 1'b1; // game is still playing
    end

    /////
    else if (snake_x != fruit_x && snake_y != fruit_y)begin
        //snake touches the borders
        if(snake_x == WIDTH && snake_y == HEIGHT)begin
            color_Red = 8'b1111_1111;
            color_Yellow = 8'b0000_0000;
            color_Green = 8'b0000_0000;
            $display("out of bounds you lose!");
        end
        //snake runs into itself
        else if(snake_x == snake_y)begin
            color_Red = 8'b1111_1111;
            color_Yellow = 8'b0000_0000;
            color_Green = 8'b0000_0000;
            $display("ate your tail! you lose!");
        end
        //when you lose based off the cases above
        $display("GAME OVER!");
        game_status = 1'b0;
    end
    //hit max length so automatically you win
    else if (snake_y == max_length)begin
            color_Red = 8'b0000_0000;
            color_Yellow = 8'b0000_0000;
            color_Green = 8'b1111_1111;
            $display("YOU WIN");
            game_status = 1'b0;
            $finish; 
    end
    else begin
        //default condition when snake misses the fruit
        fruit_x = $random % WIDTH;
        fruit_y = $random % HEIGHT;
        direction = right;
        $display("So close but you missed the fruit :(");
        game_status = 1'b1;
    end
end


endmodule

