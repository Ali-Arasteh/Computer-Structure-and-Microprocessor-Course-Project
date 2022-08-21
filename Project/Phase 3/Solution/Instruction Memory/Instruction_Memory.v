`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    11:02:49 05/09/2019 
// Design Name: 
// Module Name:    Instruction_Memory 
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
module Instruction_Memory(PC,Instruction);
input [31:0] PC;
output [31:0] Instruction;
reg [31:0] RAM[1023:0];
//initial
//begin
//	$readmemh("memfile.dat",RAM);
//end
assign Instruction = RAM[(PC >> 2)];
endmodule
