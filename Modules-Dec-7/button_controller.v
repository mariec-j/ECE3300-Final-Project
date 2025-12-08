`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12/05/2025 12:49:34 PM
// Design Name: 
// Module Name: button_controller
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
module button_controller(
    input clk,              // 100 MHz clock
    input reset,
    input btn_up,
    input btn_down,
    input btn_left,
    input btn_right,
    output reg up_pressed,
    output reg down_pressed,
    output reg left_pressed,
    output reg right_pressed
);

    // Debounce counters (need ~10ms debounce at 100MHz)
    reg [19:0] up_counter, down_counter, left_counter, right_counter;
    reg up_state, down_state, left_state, right_state;
    reg up_state_prev, down_state_prev, left_state_prev, right_state_prev;
    
    parameter DEBOUNCE_LIMIT = 20'd1000000; // 10ms at 100MHz
    
    // Debounce UP button
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            up_counter <= 0;
            up_state <= 0;
            up_state_prev <= 0;
        end else begin
            up_state_prev <= up_state;
            if (btn_up) begin
                if (up_counter < DEBOUNCE_LIMIT)
                    up_counter <= up_counter + 1;
                else
                    up_state <= 1;
            end else begin
                up_counter <= 0;
                up_state <= 0;
            end
        end
    end
    
    // Debounce DOWN button
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            down_counter <= 0;
            down_state <= 0;
            down_state_prev <= 0;
        end else begin
            down_state_prev <= down_state;
            if (btn_down) begin
                if (down_counter < DEBOUNCE_LIMIT)
                    down_counter <= down_counter + 1;
                else
                    down_state <= 1;
            end else begin
                down_counter <= 0;
                down_state <= 0;
            end
        end
    end
    
    // Debounce LEFT button
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            left_counter <= 0;
            left_state <= 0;
            left_state_prev <= 0;
        end else begin
            left_state_prev <= left_state;
            if (btn_left) begin
                if (left_counter < DEBOUNCE_LIMIT)
                    left_counter <= left_counter + 1;
                else
                    left_state <= 1;
            end else begin
                left_counter <= 0;
                left_state <= 0;
            end
        end
    end
    
    // Debounce RIGHT button
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            right_counter <= 0;
            right_state <= 0;
            right_state_prev <= 0;
        end else begin
            right_state_prev <= right_state;
            if (btn_right) begin
                if (right_counter < DEBOUNCE_LIMIT)
                    right_counter <= right_counter + 1;
                else
                    right_state <= 1;
            end else begin
                right_counter <= 0;
                right_state <= 0;
            end
        end
    end
    
    // Generate press pulses (rising edge detection)
    always @(posedge clk) begin
        up_pressed <= up_state && !up_state_prev;
        down_pressed <= down_state && !down_state_prev;
        left_pressed <= left_state && !left_state_prev;
        right_pressed <= right_state && !right_state_prev;
    end

endmodule
