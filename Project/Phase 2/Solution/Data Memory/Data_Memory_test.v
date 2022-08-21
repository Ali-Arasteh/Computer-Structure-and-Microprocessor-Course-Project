`timescale 10ns/1ns

module Data_Memory_test();
	reg clk;
	reg WriteEnable;
	reg [31:0]WriteData;
	reg [31:0]Address;
	wire [31:0]ReadData;
	initial
		begin
			clk = 0;
		end
	always
		begin
			#10 clk <= ~clk;  
		end
	initial 
		begin
			WriteEnable <= 1;
			Address <= 32'd64;
			WriteData <= 32'd45;
			@(posedge clk);
			Address <= 32'd128;
			WriteData <= 32'd100;
			@(posedge clk);
			WriteEnable <= 0;
			Address <= 32'd64;
			#32;
			Address <= 32'd128;
			#38;
		$stop();
		end
	Data_Memory Data_Memory_Instantiation(.Clk(clk),.Memory_Write(WriteEnable),.ALU_Result(Address),.Memory_Write_Data(WriteData),.Read_Data(ReadData));          
endmodule
