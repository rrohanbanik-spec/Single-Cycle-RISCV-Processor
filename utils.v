`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 29.05.2026 17:48:07
// Design Name: 
// Module Name: utils
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


// AND logic - for branch decision
module AND_logic(branch, zero, and_out);
input branch, zero;
output and_out;

assign and_out = branch & zero;
endmodule

// Adder - used for PC+4 and branch target
module Adder(in_1, in_2, Sum_out);
input [31:0] in_1, in_2;
output [31:0] Sum_out;

assign Sum_out = in_1 + in_2;
endmodule