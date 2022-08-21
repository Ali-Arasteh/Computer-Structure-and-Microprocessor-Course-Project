`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    14:19:50 06/28/2019 
// Design Name: 
// Module Name:    Top 
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
module Top(Clk,Reset,Hit,MemSysOut);
input Clk;
input Reset;
output Hit;
output [7:0] MemSysOut;
reg [26:0] Cache [7:0];
reg start;
reg flag;
wire RWB;
wire [5:0] Address;
wire [7:0] Data;
wire [7:0] ReadData;
wire [7:0] WriteData;
wire [5:0] ReadAddress;
wire [5:0] WriteAddress;
wire ReadEn;
wire WriteEn;
wire [2:0] LSBsOfAddress;
wire [26:0] SelectedSet;
wire [7:0] Data0;
wire [2:0] Tag0;
wire ValidityBit0;
wire DirtyBit0;
wire [7:0] Data1;
wire [2:0] Tag1;
wire ValidityBit1;
wire DirtyBit1;
wire LRUBit;
assign LSBsOfAddress = Address[2:0];
assign SelectedSet = Cache[LSBsOfAddress];
assign Data0 = SelectedSet[7:0];
assign Tag0 = SelectedSet[10:8];
assign ValidityBit0 = SelectedSet[11];
assign DirtyBit0 = SelectedSet[12];
assign Data1 = SelectedSet[20:13];
assign Tag1 = SelectedSet[23:21];
assign ValidityBit1 = SelectedSet[24];
assign DirtyBit1 = SelectedSet[25];
assign LRUBit = SelectedSet[26];
assign Hit = ((Address[5:3] == Tag0) && (ValidityBit0)) || ((Address[5:3] == Tag1) && (ValidityBit1));
assign WriteData = (LRUBit) ? (Data1) : (Data0);
assign ReadAddress = Address;
assign WriteAddress = {((LRUBit) ? (Tag1) : (Tag0)),LSBsOfAddress};
assign ReadEn = ((!RWB) && (!Hit));
assign WriteEn = ((!Hit) && (((!LRUBit) && DirtyBit0 && ValidityBit0) || (LRUBit && DirtyBit1 && ValidityBit1)));
assign MemSysOut = (((!RWB) && (Address[5:3] == Tag0) && ValidityBit0) ? (Data0) : (((!RWB) && ((Address[5:3] == Tag1)) && ValidityBit1) ? (Data1) : ((!RWB) ?  ReadData : 8'b0)));
integer i;
always @(posedge Clk) 
begin 
	if(Reset)
	begin 
		for(i=0;i<8;i=i+1)
			Cache[i] <= 27'b0;
		start <= 1'b0;
		flag <= 1'b0;
	end
	else
	begin
		if((start == 0) && (flag == 0))
		begin
			start <= 1'b1;
			flag <= 1'b1;
		end
		else if (start == 1)
			start <= 1'b0;
		if(!RWB)
		begin
			if(ValidityBit0 == 0)
			begin
				Cache[LSBsOfAddress][12:0] <= {2'b01,Address[5:3],ReadData};
				Cache[LSBsOfAddress][26] <= 1;
			end
			else if(ValidityBit1 == 0)
			begin 
				Cache[LSBsOfAddress][25:13] <= {2'b01,Address[5:3],ReadData};
				Cache[LSBsOfAddress][26] <= 0;
			end
			else
			begin
				if(Address[5:3] == Tag0)
					Cache[LSBsOfAddress][26] <= 1;
				else if(Address[5:3] == Tag1)
					Cache[LSBsOfAddress][26] <= 0;
				else if(LRUBit == 0)
				begin
					Cache[LSBsOfAddress][26] <= 1;
					Cache[LSBsOfAddress][10:0] <= {Address[5:3],ReadData};
				end
				else
				begin
					Cache[LSBsOfAddress][26] <= 0;
					Cache[LSBsOfAddress][23:13] <= {Address[5:3],ReadData};
				end
			end
		end
		else if(RWB)
		begin 
			if(ValidityBit0 == 0)
			begin
				Cache[LSBsOfAddress][12:0] <= {2'b11,Address[5:3],Data};
				Cache[LSBsOfAddress][26] <= 1;
			end
			else if(ValidityBit1 == 0)
			begin 
				Cache[LSBsOfAddress][25:13] <= {2'b11,Address[5:3],Data};
				Cache[LSBsOfAddress][26] <= 0;
			end
			else
			begin
				if(Address[5:3] == Tag0)
				begin 
					Cache[LSBsOfAddress][10:0] <= {Address[5:3],Data};
					Cache[LSBsOfAddress][12] <= 1;
					Cache[LSBsOfAddress][26] <= 1;
				end
				else if(Address[5:3] == Tag1)
				begin
					Cache[LSBsOfAddress][23:13] <= {Address[5:3],Data};
					Cache[LSBsOfAddress][25] <= 1;
					Cache[LSBsOfAddress][26] <= 0;
				end
				else if(LRUBit == 0)
				begin
					Cache[LSBsOfAddress][10:0] <= {Address[5:3],Data};
					Cache[LSBsOfAddress][12] <= 1;
					Cache[LSBsOfAddress][26] <= 1;
				end
				else
				begin
					Cache[LSBsOfAddress][23:13] <= {Address[5:3],Data};
					Cache[LSBsOfAddress][25] <= 1;
					Cache[LSBsOfAddress][26] <= 0;
				end
			end
		end
	end
end
Processor Processor_Instantiation(Clk,start,RWB,Address,Data);
RAM RAM_Instantiation(ReadData,WriteData,Reset,ReadAddress,WriteAddress,Clk,WriteEn,ReadEn);		
endmodule 