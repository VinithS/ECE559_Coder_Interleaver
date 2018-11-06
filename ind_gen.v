module ind_gen(
	input  clock,
	input  k,
	input  ready,
	input  reset,
	output  [13:0] out
);



	reg [13:0] cnt;
	assign out = cnt;

	initial begin
		cnt<= 13'd0;
	end // init

	//use counter to get ind
	// negedge ready or 
	always @ (posedge reset or posedge clock)
	begin
		if(reset) begin
			cnt <= 13'd0;
		end

		else if(cnt === 13'd1055 & !k) begin
			cnt <= cnt;
			//proc_comp<=1'b1;
		end
		else if(cnt === 13'd6143 & k) begin 
			cnt <= cnt;
			//proc_comp<=1'b1;
		end 

		else begin 
			cnt <= cnt + 1'd1;
		end
	end

endmodule
