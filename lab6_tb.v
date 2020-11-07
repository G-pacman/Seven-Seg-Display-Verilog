`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/30/2020 02:44:24 PM
// Design Name: 
// Module Name: lab6_tb
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


module lab6_tb(

    );
    
reg clk = 0;
reg [2:0] stsw;
reg [7:0] sw;
wire [7:0] displaychar1;
wire [7:0] displaychar2;
wire [7:0] displaychar3;
wire [7:0] displaychar4;
wire [5:0] counter;
wire [5:0] curchar;

lab6_fsm TEST(clk, clk, stsw, sw, displaychar1, displaychar2, displaychar3, displaychar4, counter, curchar);
    
always #3 clk = ~clk;
       
// stimulus (inputs)
initial begin
    #8 stsw = 3'b110; sw = 8'b1111_1110;
    #8 stsw = 3'b111;
    #8 stsw = 3'b000; // display char1
    
    #16 stsw = 3'b110; sw = 8'b1111_1101;
    #8 stsw = 3'b111;
    #8 stsw = 3'b000; // displayce char2
    
    #16 stsw = 3'b110; sw = 8'b1111_1100;
    #8 stsw = 3'b111;
    #8 stsw = 3'b000; // display char3
    
    #16 stsw = 3'b110; sw = 8'b1111_1011;
    #8 stsw = 3'b111;
    #8 stsw = 3'b000; // display char 4
    
    #16 stsw = 3'b110; sw = 8'b1111_1010;
    #8 stsw = 3'b111;
    #8 stsw = 3'b000; // display char 5 shouldnt change anything
    
    #16 stsw = 3'b110; sw = 8'b1111_1001;
    #8 stsw = 3'b111;
    #8 stsw = 3'b000; // display char 5 shouldnt change anything

    // reset state
    #150 stsw = 3'b010;
    #20 stsw = 3'b000;
    #10 $finish;
end

endmodule
