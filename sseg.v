`define Hex0 ~7'b0111111
`define Hex1 ~7'b0000110
`define Hex2 ~7'b1011011
`define Hex3 ~7'b1001111
`define Hex4 ~7'b1100110
`define Hex5 ~7'b1101101
`define Hex6 ~7'b1111101
`define Hex7 ~7'b0000111
`define Hex8 ~7'b1111111
`define Hex9 ~7'b1101111
`define Hex10 ~7'b1110111
`define Hex11 ~7'b1111100
`define Hex12 ~7'b0111001
`define Hex13 ~7'b1011110
`define Hex14 ~7'b1111001
`define Hex15 ~7'b1110001
module sseg(in,segs);
  input [3:0] in;
  output reg [6:0] segs;

	always@(*) begin
		
	case(in)
		4'd0: segs = `Hex0;
		4'd1: segs = `Hex1;
		4'd2: segs = `Hex2;
		4'd3: segs = `Hex3;
		4'd4: segs = `Hex4;
		4'd5: segs = `Hex5;
		4'd6: segs = `Hex6;
		4'd7: segs = `Hex7;
		4'd8: segs = `Hex8;
		4'd9: segs = `Hex9;
		4'd10: segs = `Hex10;
		4'd11: segs = `Hex11;
		4'd12: segs = `Hex12;
		4'd13: segs = `Hex13;
		4'd14: segs = `Hex14;
		4'd15: segs = `Hex15;
		default: segs = 7'bxxxxxxx;
	endcase
	
		
	end

endmodule
