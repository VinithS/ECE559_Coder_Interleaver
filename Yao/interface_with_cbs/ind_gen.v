module ind_gen(
	input  clock,
	input  k,//keq6144
	input  ready,
	input  reset,
	output  [13:0] out
);

//proc_comp to be added can be asserted for up to 2 cycles and maybe just one cycle

	reg [13:0] cnt;
	reg [1:0] state;
	assign out = cnt;

	initial begin
		cnt<= 13'd0;
	end // init

	//use counter to get ind
	// negedge ready or 
	always @ (posedge reset or posedge clock)
	begin
		if(reset) begin//===1'b1||ready===1'b0)
			cnt <= 13'd0;
		end

		else begin//FSM
			casex(state) 
				2'd0: begin: waiting
					if (ready===1'b1) begin
						state<=2'd1;
					end
					else begin
						cnt <= 13'd0;
						//proc_comp<=1'b0;
					end
				end
				2'd1: begin: counting
					if(cnt === 13'd1055 & !k) begin
						cnt <= cnt;
						state<=2'd2;					
					end
					else if(cnt === 13'd6143 & k) begin 
						cnt <= cnt;
						state<=2'd2;
					end 
			
					else begin 
						cnt <= cnt + 1'd1;
					end
				end
				2'd2: begin: completed1
					state<=2'd3;
					//proc_comp<=1'b1;
				end
				2'd3: begin: completed2
					state<=2'd1;
					//proc_comp<=1'b1;
				end
			endcase
		end
	end


endmodule

