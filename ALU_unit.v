`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 28.05.2026 02:43:13
// Design Name: 
// Module Name: ALU_unit
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


module ALU_unit(A,B,Control_in,ALU_Result, zero);
input [31:0] A,B;
input [3:0] Control_in;
output reg zero;
output reg [31:0] ALU_Result;

always @(Control_in or A or B)begin
    case(Control_in)
    4'b0000: begin zero<=0; ALU_Result<= A&B;end
    4'b0001: begin zero<=0; ALU_Result<=A|B;end
    4'b0010: begin ALU_Result <= A+B; zero <= 0; end
    4'b0110: begin ALU_Result <= A-B; zero <= (A==B) ? 1 : 0; end
    endcase
end
endmodule
