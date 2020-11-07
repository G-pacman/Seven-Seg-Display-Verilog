`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/30/2020 06:57:32 PM
// Design Name: 
// Module Name: lab6_sevseg
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


module lab6_sevseg(
    input clk,
    input [7:0] displaychar1,
    input [7:0] displaychar2,
    input [7:0] displaychar3,
    input [7:0] displaychar4,
    output reg [7:0] seg,
    output reg [3:0] an
    );
    
reg [1:0] counter;
        
always @ (posedge clk) begin
    counter <= counter + 2'b01;
end

always @ (*) begin
  case(counter)
    2'b00: begin 
        an <= 4'b1110;
        seg <= displaychar1;
    end
    2'b01: begin 
        an <= 4'b1101;
        seg <= displaychar2;
    end
    2'b10: begin 
        an <= 4'b1011;
        seg <= displaychar3;
    end
    2'b11: begin 
        an <= 4'b0111;
        seg <= displaychar4;
    end
  endcase
end // always block

endmodule
