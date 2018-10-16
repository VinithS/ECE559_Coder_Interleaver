`ifndef CODER_INTERLEAVER_H
`define 

module coder_interleaver (
	input [6143:0] cin,    // Clock
	input K_eq_6144;
	output [6143:0] cout
);
	
	wire [6143:0] cj_6144, cj_1056;

// module mux2to1 (
// 	input in_a, in_b,    // Clock
// 	input sel, // Clock Enable
// 	input out,  // Asynchronous reset active low
// );

parameter f1_6144=263;

parameter f1_1056=17;

parameter f2_6144=480;

parameter f2_1056=66;





//for j from 0 to 6143
genvar  j;
generate
	for (j=0;j<1056;j=j+1)
	begin: loop0to6143
		assign cout[j]=K_eq_6144?cj_6144[j]:cj_1056[j];
	end
endgenerate


//for j from 0 to 1055

// cj_6144[j]=cin[(f1_6144*j+f2_6144*j*j)%6144]

// cj_1056[j]=cin[(f1_1056*j+f2_1056*j*j)%1056]

genvar  i1;
generate
	for (i1=0;i1<1056;i1=i1+1)
	begin: loop0to1055
		assign cj_6144[i1]=cin[(f1_6144*i1+f2_6144*i1*i1)%6144];
		assign cj_1056[i1]=cin[(f1_1056*i1+f2_1056*i1*i1)%1056];
	end
endgenerate


//for j from 1056 to 6143
genvar  i2;
generate
	for (i2=0;i2<1056;i2=i2+1)
	begin: loop1056to6143
		assign cj_6144[i2]=1'b0;
		assign cj_1056[i2]=cin[(f1_1056*i2+f2_1056*i2*i2)%1056];
	end
endgenerate



endmodule

`endif