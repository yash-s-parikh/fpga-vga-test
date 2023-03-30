`define INPUT_CLK_F 50000000
`define RES_X 640
`define RES_Y 480
`define REFRESH_R 60
`define V_REF 31469
`define PIXEL_CLK 25000000

module vga(input clk,
	   input	    arst_n,
	   input [7:0]	    blue,
	   input [7:0]	    red,
	   input [7:0]	    green,
	   output	    vga_blank_n,
	   output reg [7:0] vga_b,
	   output reg [7:0] vga_g,
	   output reg [7:0] vga_r,
	   output reg	    vga_clk,
	   output	    vga_sync_n,
	   output reg	    vga_hs,
	   output reg	    vga_vs);
   
   parameter		    x_active_video_length = 10'd640;
   parameter		    x_front_porch = 5'd16;
   parameter		    x_sync_pulse = 7'd96;
   parameter		    x_back_porch = 6'd48;
   parameter		    x_whole_line = 10'd800;
   
   parameter		    y_active_video_height = 10'd480;
   parameter		    y_front_porch = 4'd10;
   parameter		    y_sync_pulse = 2'd2;
   parameter		    y_back_porch = 6'd32;
   parameter		    y_whole_frame = 10'd525;
   
   
   
   reg			    vga_clk_gen;
   
   reg [9:0]		    x_counter;
   reg [9:0]		    y_counter;
   
   always@(posedge clk, negedge arst_n) begin : clock_gen_block
      if (arst_n == 1'b0) begin
	 vga_clk_gen <= 1'b0;
      end
      
      else begin
	 vga_clk_gen <= ~vga_clk_gen;
	 if(vga_clk_gen == 1'b1) begin
	    vga_clk <= 1'b1;
	 end
	 else
	   vga_clk <= 1'b0;
      end // else: !if(rst == 1'b1)
   end 

   always@(posedge vga_clk, negedge arst_n) begin
      if (arst_n == 1'b0) begin // Reset
	 x_counter <= 10'b0;
	 y_counter <= 10'b0;
	 vga_hs <= 1'b1;
      end
      
      else begin
	 x_counter <= x_counter + 1'b1; // increment counter every cycle

	 if(x_counter >= x_whole_line) begin // reset counter to 0 upon reaching 800
	    x_counter <= 10'd0;
	    vga_r <= red;
	    vga_g <= green;
	    vga_b <= blue;
	    if(y_counter >= y_whole_frame) begin
	       y_counter <= 10'd0;
	    end
	    else
	      y_counter <= y_counter + 1'b1;
	 end
	 
	 else if(x_counter >= x_whole_line - x_back_porch) begin // raise sync pulse for back porch
	    vga_hs <= 1'b1;
	 end
	 else if(x_counter >= x_whole_line - x_back_porch - x_sync_pulse) begin //lower sync pulse
	    vga_hs <= 1'b0;
	 end
	 else if(x_counter >= x_active_video_length) begin // black out rgb for hsync
	    vga_r <= 8'b0;
	    vga_g <= 8'b0;
	    vga_b <= 8'b0;
	 end
	 else if (x_counter < x_active_video_length && y_counter < y_active_video_height) begin // drive rgb as normal
	    vga_r <= red;
	    vga_g <= green;
	    vga_b <= blue;
	 end
	 
	 else begin // error condition
	    vga_r <= 8'b0;
	    vga_g <= 8'b0;
	    vga_b <= 8'b0;
	 end
	 if((y_counter >= (y_whole_frame - y_back_porch - y_sync_pulse)) && (y_counter <= (y_whole_frame - y_back_porch)) ) begin
	    vga_vs <= 1'b0;
	 end
	 else begin
	    vga_vs <= 1'b1;
	 end
	 
      end // else: !if(arst_n == 1'b0)
      
   end	 

   


   assign vga_sync_n = 1'b1;
   assign vga_blank_n = 1'b1; 
   
   
endmodule // vga
