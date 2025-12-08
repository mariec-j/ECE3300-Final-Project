`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12/05/2025 12:45:21 PM
// Design Name: 
// Module Name: vga_controller_800X600
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
module vga_controller_800x600(
    input clk,              // 40 MHz pixel clock
    input reset,
    output reg hsync,
    output reg vsync,
    output video_on,
    output reg [10:0] pixel_x,  // 0-799
    output reg [9:0] pixel_y    // 0-599
);

    // VGA 800x600 @ 60Hz timing parameters
    // Horizontal timing (pixels) - 40 MHz pixel clock
    parameter H_DISPLAY = 800;
    parameter H_FRONT = 40;
    parameter H_SYNC = 128;
    parameter H_BACK = 88;
    parameter H_TOTAL = H_DISPLAY + H_FRONT + H_SYNC + H_BACK;  // 1056
    
    // Vertical timing (lines)
    parameter V_DISPLAY = 600;
    parameter V_FRONT = 1;
    parameter V_SYNC = 4;
    parameter V_BACK = 23;
    parameter V_TOTAL = V_DISPLAY + V_FRONT + V_SYNC + V_BACK;  // 628
    
    // Counters
    reg [10:0] h_count;
    reg [9:0] v_count;
    
    // Horizontal counter
    always @(posedge clk or posedge reset) begin
        if (reset)
            h_count <= 0;
        else if (h_count == H_TOTAL - 1)
            h_count <= 0;
        else
            h_count <= h_count + 1;
    end
    
    // Vertical counter
    always @(posedge clk or posedge reset) begin
        if (reset)
            v_count <= 0;
        else if (h_count == H_TOTAL - 1) begin
            if (v_count == V_TOTAL - 1)
                v_count <= 0;
            else
                v_count <= v_count + 1;
        end
    end
    
    // Horizontal sync (positive polarity for 800x600)
    always @(posedge clk or posedge reset) begin
        if (reset)
            hsync <= 1;
        else
            hsync <= (h_count >= (H_DISPLAY + H_FRONT)) && 
                     (h_count < (H_DISPLAY + H_FRONT + H_SYNC));
    end
    
    // Vertical sync (positive polarity for 800x600)
    always @(posedge clk or posedge reset) begin
        if (reset)
            vsync <= 1;
        else
            vsync <= (v_count >= (V_DISPLAY + V_FRONT)) && 
                     (v_count < (V_DISPLAY + V_FRONT + V_SYNC));
    end
    
    // Video on signal
    assign video_on = (h_count < H_DISPLAY) && (v_count < V_DISPLAY);
    
    // Output pixel coordinates
    always @(posedge clk) begin
        if (h_count < H_DISPLAY)
            pixel_x <= h_count;
        if (v_count < V_DISPLAY)
            pixel_y <= v_count;
    end

endmodule
