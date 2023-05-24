`include "vga_test_top.v"
module vga_test_top_tb();

   reg clk;
   wire vga_clk;
   wire	vga_blank_n, vga_sync_n, vga_hs, vga_vs;
   reg	key0;
   wire [6:0] hex0, hex1, hex2, hex3;
   wire [7:0] vga_r, vga_g, vga_b;

   vga_test_top DUT(.CLOCK_50(clk),
		    .HEX0(hex0),
		    .HEX1(hex1),
		    .HEX2(hex2),
		    .HEX3(hex3),
		    .VGA_CLK(vga_clk),
		    .VGA_BLANK_N(vga_blank_n),
		    .VGA_SYNC_N(vga_sync_n),
		    .VGA_HS(vga_hs),
		    .VGA_VS(vga_vs),
		    .KEY({3'b0, key0}),
		    .VGA_R(vga_r),
		    .VGA_G(vga_g),
		    .VGA_B(vga_b)
		    );
   
		    
  
   always #1 clk = ~clk;
   

   initial begin
      clk = 1'b0;
      key0 = 1'b1;
      
      #5
      key0 = 1'b0;
      #5;
      key0 = 1'b1;
      #20000000000;
      $finish;
      
   end
   initial begin
      $dumpfile("vga_test_top_tb_dump.vcd");
      $dumpvars(0, vga_test_top_tb);
   end  
endmodule // vga_test_top_tb



