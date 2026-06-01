`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 31.05.2026 03:13:41
// Design Name: 
// Module Name: tb_top
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


module tb_top;
reg clk,reset;

top uut(.clk(clk),.reset(reset));

initial begin
    clk = 0;
    reset = 1;
    #12;        // hold reset long enough for at least one posedge
    reset = 0;
    #500;
end

always begin
    #5 clk = ~clk;  // period = 10ns
end
endmodule
