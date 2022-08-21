`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    12:23:01 05/09/2019 
// Design Name: 
// Module Name:    Controller 
// Project Name: 
// Target Devices: 
// Tool versions: 
// Description: 
//
// Dependencies: 
//
// Revision: 
// Revision 0.01 - File Created
// Additional Comments: 
//
//////////////////////////////////////////////////////////////////////////////////
module Control_Unit(Op,Funct,RegWriteD,MemtoRegD,MemWriteD,ALUControlD,ALUSrcD,RegDstD,BranchD,BeqOrBneD,SignZeroD);
input [5:0] Op;
input [5:0] Funct;
output RegWriteD;
output MemtoRegD;
output MemWriteD;
output [2:0] ALUControlD;
output ALUSrcD;
output RegDstD;
output BranchD;
output BeqOrBneD;
output SignZeroD;    
reg [10:0] Reg_Output;
always @(*)
begin
	casex({Op,Funct})
		12'b000000100000: Reg_Output = 11'b10000001000;
		12'b000000100001: Reg_Output = 11'b10000001000;
		12'b000000100010: Reg_Output = 11'b10000101000;
		12'b000000100011: Reg_Output = 11'b10000101000;
		12'b000000100100: Reg_Output = 11'b10001001000;
		12'b000000100101: Reg_Output = 11'b10001101000;
		12'b000000100110: Reg_Output = 11'b10010001000;
		12'b000000100111: Reg_Output = 11'b10010101000;
		12'b000000101010: Reg_Output = 11'b10011001000;
		12'b000000101011: Reg_Output = 11'b10011101000;
		12'b100011xxxxxx: Reg_Output = 11'b11000010001;
		12'b101011xxxxxx: Reg_Output = 11'b00100010001;
		12'b000100xxxxxx: Reg_Output = 11'b00000101111;
		12'b000101xxxxxx: Reg_Output = 11'b00000101101;
		12'b001100xxxxxx: Reg_Output = 11'b10001010000;
		12'b001101xxxxxx: Reg_Output = 11'b10001110000;
		12'b001110xxxxxx: Reg_Output = 11'b10010010000;
		12'b001000xxxxxx: Reg_Output = 11'b10000010001;
		12'b001001xxxxxx: Reg_Output = 11'b10000010000;
		12'b001010xxxxxx: Reg_Output = 11'b10011010001;
		12'b001011xxxxxx: Reg_Output = 11'b10011110000;
		12'b000000000000: Reg_Output = 11'b00000000000;
	endcase
end
assign {RegWriteD,MemtoRegD,MemWriteD,ALUControlD,ALUSrcD,RegDstD,BranchD,BeqOrBneD,SignZeroD} = Reg_Output;
endmodule

