`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12/03/2025 04:48:42 PM
// Design Name: 
// Module Name: VGA_sync
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


//VGA timing generator creates syn signals that coordinate the pixelson 
//on VGA monitor at 640X480 res @60Hz
module VGA_sync(
    input clk_VGA, //comes from clk divider
    output reg [9:0] x_count, //tracks horzantial pixel (800) 640 pixels + 160(invisible pixels) = 800 total
    output reg [9:0] y_count, //tracks the vertical pixels
    output reg displayArea, //0-639(visible)(displayArea = 1), 640-799(not vible dont draw)(displayArea = 0), 
    output VGA_hsync,
    output VGA_vsync
);  
//input or output?
    reg p_hsync;
    reg p_vsync;

/*Official VGA 640x480 @ 60Hz Standard:
- Visible pixels: 640
- Front porch: 16 pixels
- Sync pulse: 96 pixels  
- Back porch: 48 pixels
Total: 640 + 16 + 96 + 48 = 800
*/
integer porchHF = 640; //start of horizontal front porch 
integer syncH = 656;   //start of horizontal sync 640+16 =656
integer porchHB = 752; //start of horizontal back porch 656+96=752
integer maxH = 800;    //total length of line. ← HERE!752+48 =800


integer porchVF = 480; //start of vertical front porch 
integer syncV = 490;   //start of vertical sync 640+16 =656
integer porchVB = 492; //start of vertical back porch 656+96=752
integer maxV = 525;


always @(posedge clk_VGA)begin
    if(x_count == maxH) //maxH -1 ??? may need to add this change
    x_count <= 0;
    else
    x_count <= x_count + 1'b1;
end

always @(posedge clk_VGA)begin
    
    if(x_count == maxH) //maxH -1 ??? may need to add this change
    begin
        if(y_count == maxV) //maxV -1 ??? may need to add this change
            y_count <= 0;
    else
        y_count <= y_count + 1'b1;
    end
end

// Display area signal (HIGH when in visible region)
    always @(posedge clk_VGA) begin
        displayArea <= ((x_count < porchHF) && (y_count < porchVF));
    end

    // Horizontal sync signal (active during sync pulse)
    always @(posedge clk_VGA) begin
        p_hsync <= ((x_count >= syncH) && (x_count < porchHB));
        // Vertical sync signal (active during sync pulse)
        p_vsync <= ((y_count >= syncV) && (y_count < porchVB));
    end

    // Invert sync signals (VGA sync is active LOW)
    assign VGA_hsync = ~p_hsync;
    assign VGA_vsync = ~p_vsync;

endmodule
