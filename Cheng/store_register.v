module store_register(
// inputs
clk, enable, d, reset,
// outputs
q
);

parameter N = 6144;

input clk;
input enable;
input reset;
input [N-1:0] d;
output [N-1:0] q;
reg [N-1:0] r;
assign q = r;

always @ (posedge clk or posedge reset)
begin
    if (reset == 1) begin
        r <= 0;
    end else if (enable == 1) begin
        r <= d;
    end
end                
endmodule