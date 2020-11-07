`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/30/2020 03:01:28 PM
// Design Name: 
// Module Name: lab6_fsm
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


module lab6_fsm(
    input clk,
    input clk2,
    input [2:0] stsw,
    input [7:0] sw, 
    output reg [7:0] displaychar1,
    output reg [7:0] displaychar2,
    output reg [7:0] displaychar3,
    output reg [7:0] displaychar4,
    output reg [5:0] counter,
    output reg [5:0] curchar
    );
    
parameter limit = 20; // limit of characters
    
reg [2:0] state, nextstate;
reg [7:0] char [0:19]; // 20 characters
reg [7:0] modchar; // placeholder character to change
reg [5:0] prevchar = 0; // previous number of characters
reg rstcounter = 0; // reset the counter
reg secondpass = 0; // to get the zero part

initial begin
    curchar <= 0;
    counter <= 0;
end

always @(posedge clk) begin
    state <= nextstate;
    if(stsw == 3'b110) begin
        modchar <= ~sw;
        curchar <= prevchar;
    end else if(stsw == 3'b111) begin
        curchar <= prevchar + 1;
    end else if(stsw == 3'b010) begin
        curchar <= 0;
    end else
        curchar <= prevchar;
end

always @(posedge clk2) begin
    if(counter >= curchar || rstcounter) begin
        counter <= 0;
        if(rstcounter)
            secondpass <= 0;
    end else begin
        counter <= counter + 1;
        if(counter == 0)
            secondpass <= 1;
    end
end

always @(*) begin
  case(state)
    3'b110: begin // edit character
        displaychar1 = ~sw;
        displaychar2 = ~'b0;
        displaychar3 = ~'b0;
        displaychar4 = 'b1000_1111; // L

        prevchar = curchar;
        rstcounter = 1; // rstcounter on
        nextstate = stsw;
    end
    3'b111: begin // disp last character
        displaychar1 = 'b0100_0111; // o
        displaychar2 = ~'b0;
        displaychar3 = ~'b0;
        displaychar4 = modchar;
        
        prevchar = prevchar;
        char[curchar - 1] = modchar;
        rstcounter = 1; // rstcounter on
        nextstate = stsw;
    end
    3'b010: begin // reset state
        displaychar1 = ~'b0;
        displaychar2 = ~'b0;
        displaychar3 = ~'b0;
        displaychar4 = ~'b0;
        
        prevchar = 0;
        rstcounter = 1; // rstcounter on
        nextstate = stsw;
    end
    default: begin // diplay moving characters        
        if(curchar < 5) begin
            displaychar1 = (curchar > 0)? char[curchar - 1] : ~'b0;
            displaychar2 = (curchar > 1)? char[curchar - 2] : ~'b0;
            displaychar3 = (curchar > 2)? char[curchar - 3] : ~'b0;
            displaychar4 = (curchar > 3)? char[curchar - 4] : ~'b0;
        end else if(curchar > 4 && !secondpass) begin // first pass
            // will need to rotate characters here
            displaychar1 = (curchar > counter + 3)? char[counter + 3] : char[counter - curchar + 3];
            displaychar2 = (curchar > counter + 2)? char[counter + 2] : char[counter - curchar + 2];
            displaychar3 = (curchar > counter + 1)? char[counter + 1] : char[counter - curchar + 1];
            displaychar4 = (curchar > counter + 0)? char[counter + 0] : char[counter - curchar /* 0 */];
        end else if(curchar > 4 && secondpass) begin // second pass 
            // will need to rotate characters here
            displaychar1 = (curchar > counter + 3)? char[counter + 3] : (counter + 2 < curchar)? ~'b0 : char[counter - curchar + 2];
            displaychar2 = (curchar > counter + 2)? char[counter + 2] : (counter + 1 < curchar)? ~'b0 : char[counter - curchar + 1];
            displaychar3 = (curchar > counter + 1)? char[counter + 1] : (counter + 0 < curchar)? ~'b0 : char[counter - curchar + 0];
            displaychar4 = (curchar > counter + 0)? char[counter + 0] : (counter - 1 < curchar)? ~'b0 : char[counter - curchar - 1];
        end
       
        prevchar = curchar;
        nextstate = stsw;
        rstcounter = 0; // rst counter off
    end
  endcase
end
   
endmodule
