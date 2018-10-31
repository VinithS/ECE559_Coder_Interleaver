module shift_reg_tester(
	input clk,
	input [7:0] shiftin,
	output [99:0] out,
	input aclr
	);
	
	/*
	
		input aclr,
	input clk,
	input [7:0] shiftin,
	output [6143:0] q_6144,
	output [1055:0] q_1056,
	output [7:0] shiftout
							);
	*/
	wire [6143:0] dum;
	
	shiftreg_6144 inst(.clk(clk), .aclr(aclr), .shiftin(shiftin), .q_6144(dum), .shiftout());
	
	assign out = dum[6143:6044];
	
endmodule
	