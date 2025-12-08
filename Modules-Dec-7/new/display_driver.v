`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/10/2025 03:15:25 PM
// Design Name: 
// Module Name: seg7_driver
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
module display_driver(
                        input disp_clk, 
                        input disp_rst, 
                        input [31:0] disp_inp,
                        input switch,
                        //input [7:0] disp_sw_dp,
                        output [6:0] disp_seg,
                        output disp_dp,
                        output [7:0] disp_an
                  );
                  
                  // TIMING ENGINE
                  reg [19:0] count_tmp;
                  
                  always@(posedge disp_clk)
                    begin: TIME_SOURCE
                        if(disp_rst)
                            count_tmp <=0;
                        else
                            count_tmp <= count_tmp + 1;
                    end
                  
                    reg [3:0] digit;
                    wire [2:0] tmp_digsel;
                    assign tmp_digsel = count_tmp[15:13];
                    always@(*)
                        begin
                            case(tmp_digsel)
                            3'd0: digit = disp_inp[3:0];
                            3'd1: digit = disp_inp[7:4];
                            3'd2: digit = disp_inp[11:8];
                            3'd3: digit = disp_inp[15:12];
                            3'd4: digit = disp_inp[19:16];
                            3'd5: digit = disp_inp[23: 20];
                            3'd6: digit = disp_inp[27:24];
                            3'd7: digit = disp_inp[31:28];
                            default: digit = 4'h0;
                            endcase
                        end    
                  
                  reg dp_temp;         
                  reg [6:0] tmp_disp_seg;
                  always@(*)
                    begin:SEG_ENC
                    dp_temp = 1'b1;
                    tmp_disp_seg = 7'b1111111; // default everything off
                    
                    if (switch == 1) begin:alien_enc
                            case (digit)
                                       4'h0: begin tmp_disp_seg = 7'b0011110;
                                             dp_temp = 0; end
                                       4'h1: tmp_disp_seg = 7'b0111100;
                                       4'h2: tmp_disp_seg = 7'b1110000;
                                       4'h3: begin tmp_disp_seg = 7'b0110100;
                                                dp_temp= 0; end
                                       4'h4: begin tmp_disp_seg = 7'b1011001;
                                             dp_temp = 0; end
                                       4'h5: tmp_disp_seg = 7'b1000010;
                                       4'h6: begin tmp_disp_seg = 7'b0100010;
                                             dp_temp = 0; end
                                       4'h7: begin tmp_disp_seg = 7'b0111001;
                                             dp_temp = 0; end
                                       4'h8: tmp_disp_seg = 7'b0110110;
                                       4'h9: begin tmp_disp_seg = 7'b1010010;
                                             dp_temp = 0; end
                                       4'hA: tmp_disp_seg = 7'b0001000;                                 
                                       4'hB: tmp_disp_seg = 7'b0000011;
                                       4'hC: tmp_disp_seg = 7'b1000110;
                                       4'hD: tmp_disp_seg = 7'b0100001;
                                       4'hE: tmp_disp_seg = 7'b0000110;
                                       4'hF: tmp_disp_seg = 7'b0001110;                
                                       default:  tmp_disp_seg = 7'b1111111;
                                    endcase
                                    end       // end alien enc 
                      else begin:reg_enc
                                    case (digit)
                                                4'h0: tmp_disp_seg = 7'b1000000;
                                                4'h1: tmp_disp_seg = 7'b1111001;
                                                4'h2: tmp_disp_seg = 7'b0100100;
                                                4'h3: tmp_disp_seg = 7'b0110000;
                                                4'h4: tmp_disp_seg = 7'b0011001;
                                                4'h5: tmp_disp_seg = 7'b0010010;
                                                4'h6: tmp_disp_seg = 7'b0000010;
                                                4'h7: tmp_disp_seg = 7'b1111000;
                                                4'h8: tmp_disp_seg = 7'b0000000;
                                                4'h9: tmp_disp_seg = 7'b0010000;
                                                4'hA: tmp_disp_seg = 7'b0001000;
                                                4'hB: tmp_disp_seg = 7'b0000011;
                                                4'hC: tmp_disp_seg = 7'b1000110;
                                                4'hD: tmp_disp_seg = 7'b0100001;
                                                4'hE: tmp_disp_seg = 7'b0000110;
                                                4'hF: tmp_disp_seg = 7'b0001110;
                                                default: tmp_disp_seg = 7'b1111111;       
                                            endcase  
                                            end // end reg enc
                                            end // end enc
                       
                        assign disp_dp = dp_temp;
                        
                        assign disp_seg =tmp_disp_seg;

                                            
                    

 
                     reg [7:0] tmp_an;
                     always@(*)
                        begin
                            case(tmp_digsel)
                            3'd0: tmp_an = 8'b1111_1110;
                            3'd1: tmp_an = 8'b1111_1101;
                            3'd2: tmp_an = 8'b1111_1011;
                            3'd3: tmp_an = 8'b1111_0111;
                            3'd4: tmp_an = 8'b1110_1111;
                            3'd5: tmp_an = 8'b1101_1111;
                            3'd6: tmp_an = 8'b1011_1111;
                            3'd7: tmp_an = 8'b0111_1111;
                            default: tmp_an = 8'h11111111;
                            endcase
                        end
                     assign disp_an = tmp_an;
                     
                     //reg [7:0] tmp_dp;
                     /*
                     always@(tmp_digsel)
                        begin
                            case(tmp_digsel)
                            3'd0: tmp_dp = disp_sw_dp[0];
                            3'd1: tmp_dp = disp_sw_dp[1];
                            3'd2: tmp_dp = disp_sw_dp[2];
                            3'd3: tmp_dp = disp_sw_dp[3];
                            3'd4: tmp_dp = disp_sw_dp[4];
                            3'd5: tmp_dp = disp_sw_dp[5];
                            3'd6: tmp_dp = disp_sw_dp[6];
                            3'd7: tmp_dp = disp_sw_dp[7];
                            default: tmp_an = 1'bZ;
                            endcase
                        end
                        */
                     //assign disp_dp = disp_sw_dp[tmp_digsel];
                     
endmodule

