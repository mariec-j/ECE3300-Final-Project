`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12/05/2025 12:50:11 PM
// Design Name: 
// Module Name: random_generator
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
module random_generator(
    input clk,
    input reset,
    input enable,           // Generate new random number
    output reg [10:0] rand_x,  // 11 bits for 800 pixels
    output reg [9:0] rand_y    // 10 bits for 600 pixels
);

    // 16-bit LFSR (Linear Feedback Shift Register) for pseudo-random generation
    reg [15:0] lfsr;
    wire feedback;
    
    // Feedback polynomial: x^16 + x^15 + x^13 + x^4 + 1
    assign feedback = lfsr[15] ^ lfsr[14] ^ lfsr[12] ^ lfsr[3];
    
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            lfsr <= 16'hACE1; // Non-zero seed value
            rand_x <= 11'd400;
            rand_y <= 10'd300;
        end else begin
            // Always shift LFSR to keep it random
            lfsr <= {lfsr[14:0], feedback};
            
            // Generate new position when enabled
            if (enable) begin
                // Map LFSR bits to valid game coordinates
                // X: 20 to 760 (stay within borders, aligned to 20-pixel grid)
                rand_x <= 11'd20 + ((lfsr[10:0] % 11'd740) / 20) * 20;
                
                // Y: 20 to 560 (stay within borders, aligned to 20-pixel grid)
                rand_y <= 10'd20 + ((lfsr[15:6] % 10'd560) / 20) * 20;
            end
        end
    end

endmodule
