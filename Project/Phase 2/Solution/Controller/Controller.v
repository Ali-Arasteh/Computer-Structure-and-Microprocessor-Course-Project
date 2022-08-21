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
module Controller(Op_Code,Function,Zero,Memory_to_Register,Memory_Write,PC_Source,ALU_Control,ALU_Source,Register_Destination,Register_Write,Sign_Zero);
input [5:0] Op_Code;
input [5:0] Function;
input Zero;
output Memory_to_Register;
output Memory_Write;
output PC_Source;
output [2:0] ALU_Control;
output ALU_Source;
output Register_Destination;
output Register_Write;
output Sign_Zero;    
reg [9:0] Reg_Output;
always @(*)
begin
	casex({Op_Code,Function})
		12'b000000100000:Reg_Output=10'b0000000110;
		12'b000000100001:Reg_Output=10'b0000000110;
		12'b000000100010:Reg_Output=10'b0000010110;
		12'b000000100011:Reg_Output=10'b0000010110;
		12'b000000100100:Reg_Output=10'b0000100110;
		12'b000000100101:Reg_Output=10'b0000110110;
		12'b000000100110:Reg_Output=10'b0001000110;
		12'b000000100111:Reg_Output=10'b0001010110;
		12'b000000101010:Reg_Output=10'b0001100110;
		12'b000000101011:Reg_Output=10'b0001110110;
		12'b100011xxxxxx:Reg_Output=10'b1000001011;
		12'b101011xxxxxx:Reg_Output=10'b0100001001;
		12'b000100xxxxxx:Reg_Output={2'b00,Zero,7'b0010101};
		12'b000101xxxxxx:Reg_Output={2'b00,~Zero,7'b0010101};
		12'b001100xxxxxx:Reg_Output=10'b0000101010;
		12'b001101xxxxxx:Reg_Output=10'b0000111010;
		12'b001110xxxxxx:Reg_Output=10'b0001001010;
		12'b001000xxxxxx:Reg_Output=10'b0000001011;
		12'b001001xxxxxx:Reg_Output=10'b0000001010;
		12'b001010xxxxxx:Reg_Output=10'b0001101011;
		12'b001011xxxxxx:Reg_Output=10'b0001111010;
	endcase
end
assign {Memory_to_Register,Memory_Write,PC_Source,ALU_Control,ALU_Source,Register_Destination,Register_Write,Sign_Zero} = Reg_Output;
endmodule