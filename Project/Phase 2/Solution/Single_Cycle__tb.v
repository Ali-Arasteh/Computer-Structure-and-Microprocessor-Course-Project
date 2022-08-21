`timescale 1ns/1ns

module Single_Cycle__tb;
   integer file;
   reg clk = 1;
   always @(clk)
      clk <= #5 ~clk;
   reg reset;
   initial begin
      reset = 1;
      @(posedge clk);
      @(posedge clk);
      @(posedge clk);
      #1;
      reset = 0;
   end
   initial
      $readmemh("isort32.hex", Data_Path_Instantiation.Instuction_Memory_Instantiation.RAM);
   parameter end_pc = 32'h78;
   integer i;
   always @(Data_Path_Instantiation.PC)
      if(Data_Path_Instantiation.PC == end_pc) begin
         for(i=0; i<96; i=i+1) begin
            $write("%x ", Data_Path_Instantiation.Data_Memory_Instantiation.RAM[32+i]); // 32+ for iosort32
            if(((i+1) % 16) == 0)
               $write("\n");
         end
         $stop;
      end  
   Data_Path Data_Path_Instantiation(.Clk(clk),.Reset(reset));
endmodule

