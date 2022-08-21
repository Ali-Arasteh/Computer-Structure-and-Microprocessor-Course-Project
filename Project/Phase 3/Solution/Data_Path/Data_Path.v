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

wire [31:0] Next_PC;

reg [31:0] PCF;
wire [31:0] PCPlus4F;
wire [31:0] InstrF;
wire StallF;

reg [31:0] InstrD;
reg [31:0] PCPlus4D;
wire RegWriteD;
wire MemtoRegD;
wire MemWriteD;
wire [2:0] ALUControlD;
wire ALUSrcD;
wire RegDstD;
wire BranchD;
wire BeqOrBneD;
wire SignZeroD;
wire [31:0] RD1D;
wire [31:0] RD2D;
wire [4:0] RsD;
wire [4:0] RtD;
wire [4:0] RdD;
wire [31:0] SignlmmD;
wire StallD;

reg RegWriteE;
reg MemtoRegE;
reg MemWriteE;
reg [2:0] ALUControlE;
reg ALUSrcE;
reg RegDstE;
reg BranchE;
reg BeqOrBneE;
reg [31:0] RD1E;
reg [31:0] RD2E;
reg [4:0] RsE;
reg [4:0] RtE;
reg [4:0] RdE;
reg [31:0] SignlmmE;
reg [31:0] PCPlus4E;
wire [31:0] SrcAE;
wire [31:0] SrcBE;
wire ZeroE;
wire PCSrcE;
wire [31:0] ALUOutE;
wire [31:0] WriteDataE;
wire [4:0] WriteRegE;
wire [31:0] PCBranchE;
wire FlushE;
wire [1:0] ForwardAE;
wire [1:0] ForwardBE;

reg RegWriteM;
reg MemtoRegM;
reg MemWriteM;
reg [31:0] ALUOutM;
reg [31:0] WriteDataM;
reg [4:0] WriteRegM;
wire [31:0] ReadDataM;

reg RegWriteW;
reg MemtoRegW;
reg [31:0] ReadDataW;
reg [31:0] ALUOutW;
reg [4:0] WriteRegW;
wire [31:0] ResultW;

initial
begin
	PCF <= 0;
	InstrD <= 0;
	PCPlus4D <= 0;
	RegWriteE <= 0;
	MemtoRegE <= 0;
	MemWriteE <= 0;
	ALUControlE <= 0;
	ALUSrcE <= 0;
	RegDstE <= 0;
	BranchE <= 0;
	BeqOrBneE <= 0;
	RD1E <= 0;
	RD2E <= 0;
	RsE <= 0;
	RtE <= 0;
	RdE <= 0;
	SignlmmE <= 0;
	PCPlus4E <= 0;
	RegWriteM <= 0;
	MemtoRegM <= 0;
	MemWriteM <= 0;
	ALUOutM <= 0;
	WriteDataM <= 0;
	WriteRegM <= 0;
	RegWriteW <= 0;
	MemtoRegW <= 0;
	ReadDataW <= 0;
	ALUOutW <= 0;
	WriteRegW <= 0;
end

assign Next_PC = (PCSrcE) ? (PCBranchE) : (PCPlus4F);
assign PCPlus4F = PCF + 4;
assign RsD = InstrD[25:21];
assign RtD = InstrD[20:16];
assign RdD = InstrD[15:11];
assign SignlmmD = (SignZeroD) ? {{16{InstrD[15]}},InstrD[15:0]} : {16'b0,InstrD[15:0]};
assign SrcAE = ((ForwardAE == 2'b00) ? (RD1E) : ((ForwardAE == 2'b01) ? (ResultW) : ((ForwardAE == 2'b10) ? (ALUOutM) : 32'b0)));
assign SrcBE = ((ALUSrcE) ? (SignlmmE) : ((ForwardBE == 2'b00) ? (RD2E) : ((ForwardBE == 2'b01) ? (ResultW) : ((ForwardBE == 2'b10) ? (ALUOutM) : 32'b0))));
assign PCSrcE = (BranchE && ((ZeroE && BeqOrBneE) ||(!ZeroE && !BeqOrBneE)));
assign WriteDataE = ((ForwardBE == 2'b00) ? (RD2E) : ((ForwardBE == 2'b01) ? (ResultW) : ((ForwardBE == 2'b10) ? (ALUOutM) : 32'b0)));
assign WriteRegE = ((RegDstE) ? (RdE) : (RtE));
assign PCBranchE = ({SignlmmE[29:0],2'b00} + PCPlus4E);
assign ResultW = (MemtoRegW) ? (ReadDataW) : (ALUOutW);

always @(posedge Clk)
begin
	if(Reset == 1)
		PCF <= 0;
	else if(StallF)
		PCF <= PCF;
	else 
		PCF <= Next_PC;
	
	if(PCSrcE || Reset == 1)
		begin
			InstrD <= 0;
			PCPlus4D <= 0;
		end
	else if(StallD)
		begin
			InstrD <= InstrD;
			PCPlus4D <= PCPlus4D;
		end
	else
		begin
			InstrD <= InstrF;
			PCPlus4D <= PCPlus4F;
		end
	
	if(FlushE || PCSrcE || Reset == 1)
		begin
			RegWriteE <= 0;
			MemtoRegE <= 0;
			MemWriteE <= 0;
			ALUControlE <= 0;
			ALUSrcE <= 0;
			RegDstE <= 0;
			BranchE <= 0;
			BeqOrBneE <= 0;
			RD1E <= 0;
			RD2E <= 0;
			RsE <= 0;
			RtE <= 0;
			RdE <= 0;
			SignlmmE <= 0;
			PCPlus4E <= 0;
		end
	else
		begin
			RegWriteE <= RegWriteD;
			MemtoRegE <= MemtoRegD;
			MemWriteE <= MemWriteD;
			ALUControlE <= ALUControlD;
			ALUSrcE <= ALUSrcD;
			RegDstE <= RegDstD;
			BranchE <= BranchD;
			BeqOrBneE <= BeqOrBneD;
			RD1E <= RD1D;
			RD2E <= RD2D;
			RsE <= RsD;
			RtE <= RtD;
			RdE <= RdD;
			SignlmmE <= SignlmmD;
			PCPlus4E <= PCPlus4D;
		end
		
	if(Reset == 1)
		begin
			RegWriteM <= 0;
			MemtoRegM <= 0;
			MemWriteM <= 0;
			ALUOutM <= 0;
			WriteDataM <= 0;
			WriteRegM <= 0;
		end
	else
		begin
			RegWriteM <= RegWriteE;
			MemtoRegM <= MemtoRegE;
			MemWriteM <= MemWriteE;
			ALUOutM <= ALUOutE;
			WriteDataM <= WriteDataE;
			WriteRegM <= WriteRegE;
		end

	if(Reset == 1)
		begin
			RegWriteW <= 0;
			MemtoRegW <= 0;
			ReadDataW <= 0;
			ALUOutW <= 0;
			WriteRegW <= 0;
		end
	else
		begin
			RegWriteW <= RegWriteM;
			MemtoRegW <= MemtoRegM;
			ReadDataW <= ReadDataM;
			ALUOutW <= ALUOutM;
			WriteRegW <= WriteRegM;
		end
end

Instruction_Memory Instruction_Memory_Instantiation(PCF,InstrF);
Register_File Register_File_Instantiation(Clk,RegWriteW,InstrD[25:21],InstrD[20:16],WriteRegW,ResultW,RD1D,RD2D);
ALU ALU_Instantiation(SrcAE,SrcBE,ALUControlE,ALUOutE,ZeroE);
Data_Memory Data_Memory_Instantiation(Clk,MemWriteM,ALUOutM,WriteDataM,ReadDataM);
Control_Unit Control_Unit_Instantiation(InstrD[31:26],InstrD[5:0],RegWriteD,MemtoRegD,MemWriteD,ALUControlD,ALUSrcD,RegDstD,BranchD,BeqOrBneD,SignZeroD);
Hazard_Unit Hazard_Unit_Instantiation(RsD,RtD,RsE,RtE,MemtoRegE,WriteRegM,RegWriteM,WriteRegW,RegWriteW,StallF,StallD,FlushE,ForwardAE,ForwardBE);
endmodule
