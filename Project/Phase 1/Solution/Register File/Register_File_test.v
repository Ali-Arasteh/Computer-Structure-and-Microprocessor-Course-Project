`timescale 10ns/1ns

module Register_File_test();
	reg clk;
	reg WriteEnable;
	reg [31:0]WriteData;
	reg [4:0]Address1;
	reg [4:0]Address2;
	reg [4:0]Address3;
	wire [31:0]ReadData1;
	wire [31:0]ReadData2;
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
			Address3 <= 5'd0;
			WriteData <= 32'd20;
			@(posedge clk);
			Address3 <= 5'd2;
			WriteData <= 32'd40;
			@(posedge clk);
			Address3 <= 5'd4;
			WriteData <= 32'd80;
			@(posedge clk);
			Address3 <= 5'd8;
			WriteData <= 32'd160;
			@(posedge clk);
			Address3 <= 5'd16;
			WriteData <= 32'd320;
			@(posedge clk);
			Address3 <= 5'd31;
			WriteData <= 32'd640;
			@(posedge clk);
			WriteEnable <= 0;
			#32;
			Address1 <= 5'd0;
			Address2 <= 5'd2;
			#32;
			Address1 <= 5'd4;
			Address2 <= 5'd8;
			#32;
			Address1 <= 5'd16;
			Address2 <= 5'd31;
			#32;
		$stop();
		end
	Register_File Register_File_Instantiation(.Clk(clk),.Register_Write(WriteEnable),.Read_Reg_1(Address1),.Read_Reg_2(Address2),.Write_Reg(Address3),.Register_Write_Data(WriteData),.Read_Data_1(ReadData1),.Read_Data_2(ReadData2));          
endmodule
