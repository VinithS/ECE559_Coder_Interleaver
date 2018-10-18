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
	
	initial
	begin
	
		$display("<< Starting the Simulation >>");
		clock = 1'b0; //time 0
		@(negedge clock);
		A <= 6144'd125;
		data_expectation <= 6144'd125;
	
		
		
		@(posedge clock);
		if(B != data_expectation) begin
			$display("<< Wrong Answer >>");
		end
	
		
		else begin
		$display("<< Correct Answer >>");
		end
		
		
		//$stop;
		
	end
		
endmodule 

