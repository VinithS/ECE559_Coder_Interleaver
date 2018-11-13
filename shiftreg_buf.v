
//chaning 6144 to 6145 and potentially more to deal with timing
module shiftreg_buf(
	input aclr,
	input clk,
	input [7:0] shiftin,//right most bit is lsb or earliest bit
	input shiften,
	output [6151:0] q_out
	);
	
	reg [6151:0] mem;
	
	initial begin
		mem <= 6152'b0;
	end
	// async clear
	// Shift right by 8 bits every clock cycle
	always@(posedge clk or posedge aclr) begin
		if (aclr) begin
			mem <= 6152'b0;
		end
		else begin
			mem <= shiften?{shiftin, mem[6151:8]}:mem;
		end
	end
	
	assign q_out = mem;
	// assign q_1056 = mem[6143:5088];
	// assign shiftout = mem[7:0];
	
endmodule
