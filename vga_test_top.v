/*
 Author: Yash Parikh
 File: vga_test_top.v
 Description: Top level module of my DE1-SoC VGA test project
*/

//=======================================================
//  This code is generated by Terasic System Builder
//=======================================================

module vga_test_top(

	//////////// CLOCK //////////
	input 		          		CLOCK2_50,
	input 		          		CLOCK3_50,
	input 		          		CLOCK4_50,
	input 		          		CLOCK_50,

	//////////// SEG7 //////////
	output		     [6:0]		HEX0,
	output		     [6:0]		HEX1,
	output		     [6:0]		HEX2,
	output		     [6:0]		HEX3,
	output		     [6:0]		HEX4,
	output		     [6:0]		HEX5,

	//////////// KEY //////////
	input 		     [3:0]		KEY,

	//////////// VGA //////////
	output		          		VGA_BLANK_N,
	output		     [7:0]		VGA_B,
	output		          		VGA_CLK,
	output		     [7:0]		VGA_G,
	output		          		VGA_HS,
	output		     [7:0]		VGA_R,
	output		          		VGA_SYNC_N,
	output		          		VGA_VS
);



//=======================================================
//  REG/WIRE declarations
//=======================================================




//=======================================================
//  Structural coding
//=======================================================
   vga m_vga( .clk(CLOCK_50), .arst_n(KEY[0]), .blue({1'b1,HEX0}), .red({1'b1, HEX1}), .green({1'b1, HEX2}), .vga_blank_n(VGA_BLANK_N), .vga_b(VGA_B), .vga_g(VGA_G), .vga_r(VGA_R), .vga_clk(VGA_CLK), .vga_sync_n(VGA_SYNC_N), .vga_hs(VGA_HS), .vga_vs(VGA_VS) );

    simple_counter_test_top m_simple_counter_test_top(KEY, HEX0, HEX1, HEX2, HEX3, HEX4, HEX5, CLOCK_50);


endmodule
