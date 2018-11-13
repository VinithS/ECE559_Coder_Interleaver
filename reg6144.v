`ifndef reg6144_H
`define reg6144_H
module reg6144(
	input clk,
	input rst,
	input en,
	input [6143:0] D,
	output reg  [6143:0] Q);
	
//	reg [6143:0] Q;
	initial begin
		Q <= 6144'b0;
	end
	always@(posedge clk or posedge rst) begin
		if (rst) begin
			Q <= 6144'b0;
		end
		else begin
			Q <= en?D:Q;
		end
	end
	
endmodule
`endif