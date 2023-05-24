`include "sseg.v"
module simple_counter_test_top(KEY, HEX0, HEX1, HEX2, HEX3, HEX4, HEX5, CLOCK_50);
   input [3:0] KEY;
	input CLOCK_50;
   output [6:0]	HEX0, HEX1, HEX2, HEX3, HEX4, HEX5;
   reg [15:0]	counter;
   reg [27:0]	clk_halfsec_count;
   wire		rst_n;
   wire		clk;
   

   sseg m_sseg0(counter[3:0], HEX0);
   sseg m_sseg1(counter[7:4], HEX1);
   sseg m_sseg2(counter[11:8], HEX2);
   sseg m_sseg3(counter[15:12], HEX3);

   assign HEX4 = ~7'b0000000;
   assign HEX5 = ~7'b0000000;
   assign rst_n = KEY[1];
   assign clk = CLOCK_50;
   
   always@(posedge clk, negedge rst_n) begin
      if(rst_n == 1'b0) begin
	 counter <= 16'b0;
      end
      else begin
	 if(clk_halfsec_count == 28'd25_000_000) begin
	    counter <= counter + 1'b1;
	    clk_halfsec_count <= 28'b0;
	 end
	 else begin
	    clk_halfsec_count <= clk_halfsec_count + 1'b1;
	 end
      end // else: !if(rst_n == 1'b0)
   end // always@ (posedge clk, negedge rst_n)

   
   
   
   
endmodule // simple_counter_test_top

