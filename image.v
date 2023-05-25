module image(input vga_clk, input arst_n, output reg [7:0] red, output reg [7:0] green, output reg [7:0] blue);
   reg [19:0] row_counter;
   reg [1:0]  rgb_state;
   reg [19:0] current_pixel;
   

   always@(posedge vga_clk, negedge arst_n) begin
      
      if (arst_n == 1'b0) begin
	 row_counter <= 'b0;
	 rgb_state <= 2'b00;
	 current_pixel <= 'b0;
      end
      else begin
	 if(current_pixel >= 20'd420000) begin
	    current_pixel <= 20'b0;
	 end
	 else begin
	    current_pixel <= current_pixel + 1'b1;
	    
	    if(current_pixel >= 20'd384000) begin
	       rgb_state <= rgb_state;
	       current_pixel <= current_pixel + 1'b1;
	    end
	    else begin
	       if(row_counter >= 19'd128000) begin
		  row_counter <= 'b0;
		  case(rgb_state)
		    2'b00: begin
		       rgb_state <= 2'b01;
		    end
		    2'b01: begin
		       rgb_state <= 2'b10;
		    end
		    2'b10: begin
		       rgb_state <= 2'b00;
		    end
		    default: begin
		       rgb_state <= 2'bxx;
		    end
		  endcase // case (rgb_state)
	       end
	       else begin
		  row_counter <= row_counter + 1'b1;
	       end
	    end // else: !if(row_counter >= 10'd800)
	 end
      end // else: !if(arst_n == 1'b0)
   end // always@ (posedge vga_clk, negedge arst_n)

   always@(*) begin
      case(rgb_state)
	2'b00: begin
	   red = 8'hFF;
	   green = 8'h00;
	   blue = 8'h00;
	end
	2'b01: begin
	   red = 8'h00;
	   green = 8'hFF;
	   blue = 8'h00;
	end
	2'b10: begin
	   red = 8'h00;
	   green = 8'h00;
	   blue = 8'hFF;
	end
	default: begin
	   red = 8'bx;
	   green = 8'bx;
	   blue = 8'bx;
	end
      endcase // case (rgb_state)
   end // always@ (*)
   
   
endmodule

module image2(input vga_clk, input arst_n, output reg [7:0] red, output reg [7:0] green, output reg [7:0] blue);
   reg [19:0] current_pixel;
   reg	      is_different;
   
   always@(posedge vga_clk, negedge arst_n) begin
      
      if (arst_n == 1'b0) begin
	 is_different <= 1'b0;
	 current_pixel <= 20'b0;
      end
      else begin
	 if(current_pixel >= 20'd420000 - 1'b1) begin
	    current_pixel <= 20'b0;
	 end
	 else begin
	    current_pixel <= current_pixel + 1'b1;
	    
	    if(current_pixel >= 20'd384000 - 1'b1) begin
	       red <= 8'b0;
	       green <= 8'b0;
	       blue <= 8'b0;
	    end
	    else begin
	       if(current_pixel >= 20'd192000 - 1'b1 && current_pixel <= 20'd192800 - 1'b1) begin
		  red <= 8'hFF;
		  green <= 8'h00;
		  blue <= 8'hff;
	       end
	       else begin
		  red <= 8'hFF;
		  green <= 8'hC0;
		  blue <= 8'hCB;
	       end
	    end // else: !if(current_pixel >= 20'd384000 - 1'b1)
	 end // else: !if(current_pixel >= 20'd420000 - 1'b1)
      end // else: !if(arst_n == 1'b0)
   end // always@ (posedge vga_clk, negedge arst_n)
   
endmodule

module image3(input vga_clk, input arst_n, output [7:0] red, output [7:0] green, output [7:0] blue);
   reg [7:0] gradient;
   reg [19:0] current_pixel;
   reg [2:0]  count5;
   
   
   always@(posedge vga_clk, negedge arst_n) begin
      if(arst_n == 1'b0) begin
	 gradient <= 'b0;
	 current_pixel <= 'b0;
      end
      else begin
	 if(current_pixel >= 20'd420000 - 1'b1) begin
	    current_pixel <= 20'b0;
	 end
	 else begin
	    current_pixel <= current_pixel + 1'b1;
	 end
	 if(count5 == 3'd5) begin
	    count5 <= 3'd0;
	    gradient <= gradient + 2'd2;
	 end
	 else begin
	    count5 <= count5 + 1'b1;
	 end
	 
      end
   end

   assign red = current_pixel >= 30'd384000 - 1'b1 ? 8'b0 : gradient;
   assign blue = current_pixel >= 30'd384000 - 1'b1 ? 8'b0 : gradient + 8'd85;
   assign green = current_pixel >= 30'd384000 - 1'b1 ? 8'b0 : gradient + 8'd170;
   
endmodule // image3
