`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// CompanALU_Result: 
// Engineer: 
// 
// Create Date:    11:47:17 05/09/2019 
// Design Name: 
// Module Name:    ALU 
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
module ALU(A,B,ALU_Control,ALU_Result,Zero);
input [31:0] A;
input [31:0] B;
input [2:0] ALU_Control;
output [31:0] ALU_Result;
output Zero;
reg [31:0] Reg_ALU_Result;
wire [31:0] Subtract;
wire [32:0] Unsigned_Subtract;
assign Subtract = A - B;
assign Unsigned_Subtract = {1'b0,A} - {1'b0,B};
always @(*)
begin 
	case(ALU_Control)
		3'b000: Reg_ALU_Result <= A + B;
		3'b001: Reg_ALU_Result <= A - B;
		3'b010: Reg_ALU_Result <= A & B;
		3'b011: Reg_ALU_Result <= A | B;
		3'b100: Reg_ALU_Result <= A ^ B;
		3'b101: Reg_ALU_Result <= ~(A | B);
		3'b110: Reg_ALU_Result <= {31'b0,Subtract[31]};
		3'b111: Reg_ALU_Result <= {31'b0,Unsigned_Subtract[32]};
	endcase
end
assign ALU_Result = Reg_ALU_Result;
assign Zero = (ALU_Result == 0) ? 1'b1 : 1'b0;
endmodule
