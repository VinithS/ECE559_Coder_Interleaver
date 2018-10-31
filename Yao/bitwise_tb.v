`include "coder_interleaver.v"
`timescale 1 ns / 100 ps

module turbo_tb();
	reg [6143:0] A;
	reg k;
	wire [6143:0] B;
	reg [6143:0] data_expectation;
	
	reg clock;
	
	coder_interleaver test (
		.cin(A),
		.K_eq_6144(k),
		.cout(B)
	);
	parameter f1_6144=263;

	parameter f1_1056=17;

	parameter f2_6144=480;

	parameter f2_1056=66;

	integer  i;
	initial
	begin
	
		$display("<< Starting the Simulation >>");
		// A={6144{1'b1}};
		$display("A=%b",A);
		clock = 1'b0; //time 0

		k=0;
		$display("k!=6144");
		for(i=0;i<1056;i=i+1) begin
			A[i]=1'b1;

		end

		$display("A=%b",A);
		
		#100
		$display("trying to verify that output bits before 1056 matches");
		for(i=0;i<1056;i=i+1) begin
			#5
			A[i]=0;
			// $display("changing input bit %d to 0",i);
			#5
			if (B[(f1_1056*i+f2_1056*i*i) % 1056]!==1'b0) begin
				$display("Should be 0, Mismatch at %d and B[%d] = %b",i,(f1_1056*i+f2_1056*i*i) % 1056,B[i]);
			end
			#5
			A[i]=1;
			$display("changing input bit %d to 1",i);
			#5
			if (B[(f1_1056*i+f2_1056*i*i) % 1056]!==1'b1) begin
				$display("Should be 1, Mismatch at %d and B[%d] = %b",i,(f1_1056*i+f2_1056*i*i) % 1056,B[i]);
			end

		end
		
		// $display("trying to verify that all output bits after 1056 are 0");
		// #10
		// for(i=1056;i<1058;i=i+1) begin
			
		// 	if (B[i]!==1'b0) begin
		// 		$display("Mismatch at %d and B[%d] = %b",i,i,B[i]);
		// 	end
		// end

		// k=1;
		// $display("k!=6144");

		// #10
		// $display("trying to verify that output bit matches");
		// for(i=0;i<6144;i=i+1) begin
		// 	#5
		// 	A[i]=0;
		// 	// $display("changing input bit %d to 0",i);
		// 	#5
		// 	if (B[(f1_6144*i+f2_6144*i*i) % 6144]!==1'b0) begin
		// 		$display("Mismatch at %d",i);
		// 	end
		// 	#5
		// 	A[i]=1;
		// 	$display("changing input bit %d to 1",i);
		// 	#5
		// 	if (B[(f1_1056*i+f2_1056*i*i) % 1056]!==1'b1) begin
		// 		$display("Mismatch at %d",i);
		// 	end

		// end
		
		$stop;
		$finish;
	end
		
endmodule 

