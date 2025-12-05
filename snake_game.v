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

module snake_game
(
input clk,
input rst,
input [1:0] direction, // now controlled only by direction input file
output reg [7:0] snake_x, //axis
output reg [7:0] snake_y, //axis
input [7:0] fruit_x_in, // input from rand point
input [7:0] fruit_y_in,
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

reg [7:0] fruit_x;
reg [7:0] fruit_y;

//initial start defines the initail position of the snake and randomly generate fruits starting position
//(snake_x)/2 && (snake_y)/2 just puts starting snake in the middle
initial begin
    //center snake
    snake_x = WIDTH/2;
    snake_y = WIDTH/2;

    fruit_x = fruit_x_in;
    fruit_y = fruit_y_in;
    
    color_Red = 8'b0;
    color_Yellow = 8'b0;
    color_Green = 8'b0;
    game_status = 1'b1;
    score = 0;
end

//making directions - so if u go right inc x axis by 1 etc....
always @(posedge clk)begin //when clk is High
    if(rst) begin
        snake_x <= WIDTH/2;
        snake_y <= HEIGHT/2;
        score <= 0;
        color_Red <= 8'b0;
        color_Yellow <= 8'b0;
        color_Green <= 8'b0;
        game_status <= 1'b1;
        fruit_x <= fruit_x_in;
        fruit_y <= fruit_y_in;
        end
    else begin
    // move snake
        case(direction) 
            right: snake_x <= snake_x + 1;
            left: snake_x <= snake_x - 1;
            up: snake_y <= snake_y + 1;
            down: snake_y <= snake_y - 1;
        endcase

  // different game scenarios  
    
    //checking if snake lands on fruit & yellow color is displayed
        if(snake_x == fruit_x && snake_y == fruit_y) begin
            //if does land on fruit than... randomize fruit again
            fruit_x <= fruit_x_in;
            fruit_y <= fruit_y_in;
            //inc snake size by one bc it ate the apple
            snake_y <= snake_y + 1;
            score <= score + 1;
            //displaying yellow
            color_Red <= 8'b0000_0000;
            color_Yellow <= 8'b1111_1111;
            color_Green <= 8'b0000_0000;
            game_status <= 1'b1; // game is still playing
        end
        
            // lose conditions

            //snake touches the borders
            else if(snake_x == WIDTH && snake_y == HEIGHT) begin
                color_Red <= 8'b1111_1111;
                color_Yellow <= 8'b0000_0000;
                color_Green <= 8'b0000_0000;
                game_status <= 1'b0;
                $display("out of bounds you lose!");
                $display("GAME OVER");
            end
            //snake runs into itself
            else if(snake_x == snake_y)begin
                color_Red <= 8'b1111_1111;
                color_Yellow <= 8'b0000_0000;
                color_Green <= 8'b0000_0000;
                game_status <= 1'b0;
                $display("ate your tail! you lose!");
                $display("GAME OVER");
            end

        // win conditions
        
        //hit max length so automatically you win
        else if (snake_y == max_length)begin
                color_Red <= 8'b0000_0000;
                color_Yellow <= 8'b0000_0000;
                color_Green <= 8'b1111_1111;
                game_status <= 1'b0;
                $display("YOU WIN");
                $finish; 
        end
        
        // default condition: snake misses the fruit
        else begin
            fruit_x <= fruit_x_in;
            fruit_y <= fruit_y_in;
            game_status <= 1'b1;
            color_Red <= 8'b0000_0000;
            color_Yellow <= 8'b0000_0000;
            color_Green <= 8'b0000_0000;
            $display("So close but you missed the fruit :(");
            end
    end // end else
    end // end always block
    
endmodule

