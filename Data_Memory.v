`timescale 1ns / 1ps
module Data_Memory(clk, reset, MemWrite, MemRead, read_address, Write_data, MemData_out);
input clk, reset;
input MemWrite, MemRead;
input [31:0] read_address, Write_data;
output [31:0] MemData_out;

reg [31:0] D_Memory [63:0];
integer k;

initial begin
    for(k=0; k<64; k=k+1) D_Memory[k] = 32'b0;
    // preload some data for load instructions
    // lw x8, 15(x5) ? address = x5+15 = 1+15 = 16 ? index 4
    D_Memory[4]  = 32'd100;
    // lw x9, 3(x3) ? address = x3+3 = 24+3 = 27 ? index 6
    D_Memory[6]  = 32'd200;
end

always @(posedge clk) begin
    if(MemWrite)
        D_Memory[read_address >> 2] <= Write_data;
end

assign MemData_out = (MemRead) ? D_Memory[read_address >> 2] : 32'b0;

endmodule