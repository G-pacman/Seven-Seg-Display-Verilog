`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/30/2020 01:29:08 PM
// Design Name: 
// Module Name: lab6_top
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


module lab6_top(
 output [5:0] q,
 output [7:0] seg,
 output [3:0] an,
 input clk,
 input [7:0] sw,
 input [2:0] stsw
 );


wire [7:0] displaychar [0:3];
wire [2:0] d_stsw; // debounce state switches


debounce DSW0 (clk, stsw[0], d_stsw[0]);
debounce DSW1 (clk, stsw[1], d_stsw[1]);
debounce DSW2 (clk, stsw[2], d_stsw[2]);

clock_divider #(.timeconst(75)) CDIV (clk, cout); // clock for switching displaychar values
clock_divider #(.timeconst(20)) CDIV2(clk, cout2); // default 20 clock for the seven segment

lab6_fsm FSM (clk, cout, d_stsw, sw, displaychar[0], displaychar[1], displaychar[2], displaychar[3], null, q);
    
lab6_sevseg SEVSEG(cout2, displaychar[0], displaychar[1], displaychar[2], displaychar[3], seg, an);

endmodule