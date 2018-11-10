
module hex_to_seven (
	input [3:0] bin_number,
	output [6:0] seven_seg_display
);

assign seven_seg_display =
		({7{(bin_number == 4'h0)}} & 7'b1000000) |
		({7{(bin_number == 4'h1)}} & 7'b1111001) |
		({7{(bin_number == 4'h2)}} & 7'b0100100) |
		({7{(bin_number == 4'h3)}} & 7'b0110000) |
		({7{(bin_number == 4'h4)}} & 7'b0011001) |
		({7{(bin_number == 4'h5)}} & 7'b0010010) |
		({7{(bin_number == 4'h6)}} & 7'b0000010) |
		({7{(bin_number == 4'h7)}} & 7'b1111000) |
		({7{(bin_number == 4'h8)}} & 7'b0000000) |
		({7{(bin_number == 4'h9)}} & 7'b0010000) |
		({7{(bin_number == 4'hA)}} & 7'b0001000) |
		({7{(bin_number == 4'hB)}} & 7'b0000011) |
		({7{(bin_number == 4'hC)}} & 7'b1000110) |
		({7{(bin_number == 4'hD)}} & 7'b0100001) |
		({7{(bin_number == 4'hE)}} & 7'b0000110) |
		({7{(bin_number == 4'hF)}} & 7'b0001110); 


endmodule

