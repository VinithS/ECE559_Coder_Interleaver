module ind_gen(
	clock,
	k,
	ready,
	reset,
	out
);

	input clock;
	input k;
	input ready;
	input reset;
	output [13:0] out; 


	reg [13:0] cnt;
	assign out = cnt;

	//use counter to get ind
	always @ (negedge ready or posedge reset or posedge clock)
	begin
		if(!ready | reset) begin
			cnt <= 13'd0;
		end

		else if(cnt == 1055 & !k) begin
			cnt <= cnt;
		end
		else if(cnt == 6143) begin 
			cnt <= cnt;
		end 
		else begin cnt <= cnt + 1'd1;
		end
	end

endmodule
