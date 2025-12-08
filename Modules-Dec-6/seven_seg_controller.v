`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12/05/2025 12:48:50 PM
// Design Name: 
// Module Name: seven_seg_controller
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
module seven_seg_controller(
    input clk,              // 100 MHz clock
    input reset,
    input [15:0] score,     // Score to display
    output reg [6:0] seg,   // Segment outputs (active low)
    output reg [7:0] an     // Anode outputs (active low)
);

    // Refresh counter for multiplexing (1 kHz refresh rate)
    reg [16:0] refresh_counter;
    wire [2:0] digit_select;
    
    // Extract individual digits from score
    reg [3:0] digit0, digit1, digit2, digit3;
    reg [3:0] current_digit;
    
    always @(*) begin
        digit0 = score % 10;                    // Ones
        digit1 = (score / 10) % 10;             // Tens
        digit2 = (score / 100) % 10;            // Hundreds
        digit3 = (score / 1000) % 10;           // Thousands
    end
    
    // Refresh counter
    always @(posedge clk or posedge reset) begin
        if (reset)
            refresh_counter <= 0;
        else
            refresh_counter <= refresh_counter + 1;
    end
    
    assign digit_select = refresh_counter[16:14];  // Select digit every ~1ms
    
    // Select which digit to display
    always @(*) begin
        case (digit_select)
            3'b000: begin
                an = 8'b11111110;  // Rightmost digit (digit 0)
                current_digit = digit0;
            end
            3'b001: begin
                an = 8'b11111101;  // Digit 1
                current_digit = digit1;
            end
            3'b010: begin
                an = 8'b11111011;  // Digit 2
                current_digit = digit2;
            end
            3'b011: begin
                an = 8'b11110111;  // Digit 3 (leftmost)
                current_digit = digit3;
            end
            default: begin
                an = 8'b11111111;  // All off
                current_digit = 4'b0000;
            end
        endcase
    end
    
    // 7-segment decoder (active low outputs)
    always @(*) begin
        case (current_digit)
            4'd0: seg = 7'b1000000;  // 0
            4'd1: seg = 7'b1111001;  // 1
            4'd2: seg = 7'b0100100;  // 2
            4'd3: seg = 7'b0110000;  // 3
            4'd4: seg = 7'b0011001;  // 4
            4'd5: seg = 7'b0010010;  // 5
            4'd6: seg = 7'b0000010;  // 6
            4'd7: seg = 7'b1111000;  // 7
            4'd8: seg = 7'b0000000;  // 8
            4'd9: seg = 7'b0010000;  // 9
            default: seg = 7'b1111111;  // Blank
        endcase
    end

endmodule
