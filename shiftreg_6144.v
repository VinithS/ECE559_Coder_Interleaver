module shiftreg_6144(
	input aclr,
	input clk,
	input [7:0] shiftin,
	output [6143:0] q_6144,
	output [1055:0] q_1056,
	output [7:0] shiftout
							);
	
	reg [6143:0] mem;
	
	// async clear
	// Shift right by 8 bits every clock cycle
	always@(posedge clk or posedge aclr) begin
		if (aclr) begin
			mem <= 6144'b0;
		end
		else begin
			mem <= {shiftin, mem[6143:8]};

		end
	end
	
	assign q_6144 = mem;
	assign q_1056 = mem[6143:5088];
	assign shiftout = mem[7:0];
	
endmodule
