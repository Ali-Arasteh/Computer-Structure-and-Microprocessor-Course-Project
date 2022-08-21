`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    11:11:20 05/09/2019 
// Design Name: 
// Module Name:    Data_Memory 
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
module Data_Memory(Clk,Memory_Write,ALU_Result,Memory_Write_Data,Read_Data);
input Clk;
input Memory_Write;
input [31:0] ALU_Result;
input [31:0] Memory_Write_Data;
output [31:0] Read_Data;
reg [31:0] RAM[1023:0];
wire [29:0] Word_Number;
assign Word_Number = ALU_Result[31:2];
assign Read_Data = RAM[Word_Number];
always @(posedge Clk)
begin
	if(Memory_Write)
		RAM[Word_Number] <= Memory_Write_Data;
end
endmodule