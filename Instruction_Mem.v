`timescale 1ns / 1ps
module Instruction_Mem(clk, reset, read_address, instruction_output);
input clk, reset;
input [31:0] read_address;
output [31:0] instruction_output;

reg [31:0] I_Mem [63:0];
integer k;

assign instruction_output = I_Mem[read_address >> 2];

initial begin
    for(k=0; k<64; k=k+1) I_Mem[k] = 32'b0;
    I_Mem[0]  = 32'b00000000000000000000000000000000;
    I_Mem[1]  = 32'b0000000_11001_10000_000_01101_0110011;
    I_Mem[2]  = 32'b0100000_00011_01000_000_00101_0110011;
    I_Mem[3]  = 32'b0000000_00011_00010_111_00001_0110011;
    I_Mem[4]  = 32'b0000000_00101_00011_110_00100_0110011;
    I_Mem[5]  = 32'b000000000011_10101_000_10110_0010011;
    I_Mem[6]  = 32'b000000000001_01000_110_01001_0010011;
    I_Mem[7]  = 32'b000000001111_00101_010_01000_0000011;
    I_Mem[8]  = 32'b000000000011_00011_010_01001_0000011;
    I_Mem[9]  = 32'b0000000_01111_00101_010_01100_0100011;
    I_Mem[10] = 32'b0000000_01110_00110_010_01010_0100011;
    I_Mem[11] = 32'h00948663;
end

endmodule