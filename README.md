# Verilog-Lab

Displays character on the Basys3 board predefined by the switches.

Code can be simulated with Iverilog or Vivado. 
Code can be run on Basys3 Artix-7 FPGA board.

displays characters input by switches(sw) and change states by state switches(stsw):
- state 110: load state
- state 111: store state
- state 010: reset state
- otherwise: display characters stored.
