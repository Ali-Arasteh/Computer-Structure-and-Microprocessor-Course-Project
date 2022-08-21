`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    21:31:02 06/01/2019 
// Design Name: 
// Module Name:    hazard_unit 
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
module Hazard_Unit(RsD,RtD,RsE,RtE,MemtoRegE,WriteRegM,RegWriteM,WriteRegW,RegWriteW,StallF,StallD,FlushE,ForwardAE,ForwardBE);
input [4:0] RsD;
input [4:0] RtD;
input [4:0] RsE;
input [4:0] RtE;
input MemtoRegE;
input [4:0] WriteRegM;
input RegWriteM;
input [4:0] WriteRegW;
input RegWriteW;
output StallF;
output StallD;
output FlushE;
output [1:0] ForwardAE;
output [1:0] ForwardBE;
assign StallF = (MemtoRegE && ((RtD == RtE) || (RsD == RtE)));
assign StallD = (MemtoRegE && ((RtD == RtE) || (RsD == RtE)));
assign FlushE = (MemtoRegE && ((RtD == RtE) || (RsD == RtE)));
assign ForwardAE = (((RsE != 0) && RegWriteM && (WriteRegM== RsE)) ? 2'b10 : (((RsE != 0) && RegWriteW && (WriteRegW == RsE)) ? 2'b01 : 2'b00));
assign ForwardBE = (((RtE != 0) && RegWriteM && (WriteRegM== RtE)) ? 2'b10 : (((RtE != 0) && RegWriteW && (WriteRegW == RtE)) ? 2'b01 : 2'b00));
endmodule
