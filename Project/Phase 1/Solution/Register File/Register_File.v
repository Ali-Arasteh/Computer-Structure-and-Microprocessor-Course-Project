`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    11:28:54 05/09/2019 
// Design Name: 
// Module Name:    Register_File 
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
module Register_File(Clk,Register_Write,Read_Reg_1,Read_Reg_2,Write_Reg,Register_Write_Data,Read_Data_1,Read_Data_2);
input Clk;
input Register_Write;
input [4:0] Read_Reg_1;
input [4:0] Read_Reg_2;
input [4:0] Write_Reg;
input [31:0] Register_Write_Data;
output [31:0] Read_Data_1;
output [31:0] Read_Data_2;
reg [31:0] Register_File_data[31:0];
assign Read_Data_1 = Register_File_data[Read_Reg_1];
assign Read_Data_2 = Register_File_data[Read_Reg_2];
always @(posedge Clk) 
begin
	if(Register_Write)
		Register_File_data[Write_Reg] <= Register_Write_Data;
	Register_File_data[0] <= 32'h00000000;
end
endmodule
