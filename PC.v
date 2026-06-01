`timescale 1ns / 1ps
module Program_Counter(clk,reset, PC_in,PC_out);
input clk;
input reset;
input [31:0] PC_in;
output reg [31:0] PC_out;

always @(posedge clk or posedge reset)
begin
    if(reset)
        PC_out <= 32'b0;
    else
        PC_out <= PC_in;
end
endmodule
