
`timescale 1ns / 1ps
module Reg_File(clk, reset, Reg_Write, Rs1, Rs2, Rd, Write_data, read_data1, read_data2);

input clk, reset, Reg_Write;
input [4:0] Rs1, Rs2, Rd;
input [31:0] Write_data;
output [31:0] read_data1, read_data2;

reg [31:0] registers [31:0];

// pre-load registers with initial values for simulation
initial begin
    registers[0]  = 0;
    registers[1]  = 4;
    registers[2]  = 2;
    registers[3]  = 100;
    registers[4]  = 4;
    registers[5]  = 50;
    registers[6]  = 44;
    registers[7]  = 4;
    registers[8]  = 2;
    registers[9]  = 1;
    registers[10] = 23;
    registers[11] = 4;
    registers[12] = 90;
    registers[13] = 10;
    registers[14] = 20;
    registers[15] = 30;
    registers[16] = 40;
    registers[17] = 50;
    registers[18] = 60;
    registers[19] = 70;
    registers[20] = 80;
    registers[21] = 7;
    registers[22] = 0;
    registers[23] = 0;
    registers[24] = 0;
    registers[25] = 90;
    registers[26] = 4;
    registers[27] = 0;
    registers[28] = 0;
    registers[29] = 34;
    registers[30] = 5;
    registers[31] = 10;
end

// synchronous write
always @(posedge clk) begin
    if(Reg_Write)
        registers[Rd] <= Write_data;
end

// combinational reads
assign read_data1 = registers[Rs1];
assign read_data2 = registers[Rs2];

endmodule