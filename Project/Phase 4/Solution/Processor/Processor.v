`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    14:15:07 06/28/2019 
// Design Name: 
// Module Name:    Processor 
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
module Processor(clk,start,RWB,Address,Data);
input clk;
input	start;
output RWB;
output reg [5:0] Address;
output reg [7:0] Data;
reg Addreg;
always@(posedge clk)
begin
	begin
		Data[0] <= start ? 1'b0 : Data[7] ^ Data[6];
		Data[6:1] <= start ? 6'b0 : Data[5:0];
		Data[7] <= start ? 1'b1 : Data[6];
		Address[0] <= start ? 1'b0 : Address[5] ^ Addreg;
		{Addreg,Address[3:1]} <= start ? 4'b0 : Address[3:0];
		Address[4] <= 0;
		Address[5] <= start ? 1'b1 : Addreg;
	end
end
assign RWB = Data[5];
endmodule
