
module shiftreg_6144(aclr,
	clock,
	shiftin,
	q,
	shiftout);

	input	  aclr;
	input	  clock;
	input	  [7:0] shiftin;
	output	[6143:0]  q;
	output	  shiftout;

endmodule
