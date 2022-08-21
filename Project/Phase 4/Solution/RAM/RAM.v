`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    14:17:05 06/28/2019 
// Design Name: 
// Module Name:    RAM 
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
module RAM (ReadData,WriteData,Reset,readAddress,writeAddress,Clk,writeEn,readEn);
output [7 : 0] ReadData;
input [7 : 0] WriteData;
input [5 : 0] readAddress;
input [5 : 0] writeAddress;
input Clk;
input writeEn;
input readEn;
input Reset;
reg [7 : 0] Memory [0 : 63];
integer i;
assign ReadData = (readEn)? Memory[readAddress]:8'bzzzzzzzz;
always @(posedge Clk)
	if (Reset)
		begin
			for(i=0;i<64;i=i+1)
				Memory [i] = 8'b00000000;		
		end
	else if (writeEn)
		Memory [writeAddress] = WriteData;		 
endmodule


