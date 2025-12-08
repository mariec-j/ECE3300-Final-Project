`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12/03/2025 04:40:19 PM
// Design Name: 
// Module Name: snake_clk_divider
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


module snake_clk_divider (
input clk_VGA,
//input rst_D,
output reg clk_D_out
);

//100MHz/4 = 25MHz(this is a good speed) sooo we need a counter and a value set to 4
//bc clock counts to 4(signiling div by 4 ;0,1,2,3)

integer check = 4; //# we divide by
integer count = 0; //counter goes 0,1,2,3

always @(posedge clk_VGA /*or posedge input rst_D*/)begin //include reset if there are problems
if(count < check )//idk if I need the -1 ; // 0,1,2,3 < 4 //
    begin
    count <= count + 1; //inc by 1
    clk_D_out <= 0;
    end
        else begin
            count <= 0; //else when its greater than 3 reset to 0
            clk_D_out <= 1;
        end
end
endmodule

//this is for game logic to update the snakes position- when snake is moving
//we are slowing this down to make snake move at 25Hz
module update_clk(
    //both use the same 100MHZ input clk_VGA
    input clk_VGA,
    output reg clk_up
   // input rst_D
);
//counter: 100MHz/25Hz = 4,000,000 so we are checking for 4,000,000
//21^2 = 4,194,303 (so yes 21 bits is enough space)
    reg [21:0] count;

    always @(posedge clk_VGA /*or posedge input rst_D*/) begin
        if(count < 3984064)begin
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
