`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    13:14:19 05/09/2019 
// Design Name: 
// Module Name:    Data_Path 
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
module Data_Path(Clk,Reset);
input Clk;
input Reset;
reg [31:0] PC;
wire [31:0] Instruction;
wire [4:0] Read_Reg_1;
wire [4:0] Read_Reg_2;
wire [4:0] Write_Reg;
wire [31:0] Read_Data_1;
wire [31:0] Read_Data_2;
wire [31:0] Register_Write_Data;
wire [31:0] Source_A;
wire [31:0] Source_B;
wire [31:0] ALU_Result;
wire Zero;
wire [31:0] Data_Memory_Write_Data;
wire [31:0] Read_Data;
wire [5:0] Op_Code;
wire [5:0] Function;
wire Memory_to_Register;
wire Memory_Write;
wire PC_Source;
wire [2:0] ALU_Control;
wire ALU_Source;
wire Register_Destination;
wire Register_Write;
wire Sign_Zero;
wire [31:0] Sign_Immediate;
wire [31:0] PC_Plus_4;
wire [31:0] PC_Branch;
wire [31:0] Next_PC;
initial
begin
	PC <= 0;
end
assign Read_Reg_1 = Instruction[25:21];
assign Read_Reg_2 = Instruction[20:16];
assign Write_Reg = (Register_Destination) ? Instruction[15:11] : Instruction[20:16];
assign Register_Write_Data = (Memory_to_Register) ? Read_Data : ALU_Result;
assign Source_A = Read_Data_1;
assign Source_B = (ALU_Source) ? Sign_Immediate : Read_Data_2;
assign Data_Memory_Write_Data = Read_Data_2;
assign Op_Code = Instruction[31:26];
assign Function = Instruction[5:0];
assign Sign_Immediate = (Sign_Zero) ? {{16{Instruction[15]}},Instruction[15:0]} : {16'h0000,Instruction[15:0]};
assign PC_Plus_4 = PC + 4;
assign PC_Branch = PC_Plus_4 + (Sign_Immediate << 2);
assign Next_PC = (PC_Source) ? PC_Branch : PC_Plus_4;
always @(posedge Clk)
begin 
	if(Reset == 1)
		PC <= 0;
	else 
		PC <= Next_PC;
end
Instruction_Memory Instuction_Memory_Instantiation(PC,Instruction);
Register_File Register_File_Instantiation(Clk,Register_Write,Read_Reg_1,Read_Reg_2,Write_Reg,Register_Write_Data,Read_Data_1,Read_Data_2);
ALU ALU_Instantiation(Source_A,Source_B,ALU_Control,ALU_Result,Zero);
Data_Memory Data_Memory_Instantiation(Clk,Memory_Write,ALU_Result,Data_Memory_Write_Data,Read_Data);
Controller Controller_Instantiation(Op_Code,Function,Zero,Memory_to_Register,Memory_Write,PC_Source,ALU_Control,ALU_Source,Register_Destination,Register_Write,Sign_Zero);
endmodule
