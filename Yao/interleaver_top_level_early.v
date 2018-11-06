//early model with shift register inside our module
//the interleaver will only process one block at a time since there's only one set of turbo coders

module interleaver_top_level_early(
	input k_size_6144,      // 0 if 1056, 1 if 6144 block size
	input [7:0] databyte_in,  // byte-wise serial input
	input clock,         // clock 
	input rst,			// reset
	input ready_in,       // asserted to indicate the whole block is filled and this module starts output serial stream; as of now it needs to be asserted for at least K cycles
	output outi, // bitserial output using the same sequence as input, i.e. ci
	output outpii // bitserial output after remapping, i.e. cpii
	);

	wire clk;
	assign clk=clock;

	wire clear;
	assign clear=rst;

	// shift register taking in byte-wise input
	wire [6143:0] shift_reg_out;//,shift_reg_out1;
	// assign shift_reg_out = shift_reg_out1;
	// wire [7:0]
	//**********to do in the future, have 2 shiftreg to 
	shiftreg_6144 input_shiftreg_inst1(.aclr(clear),
										.clk(clk),
										.shiftin(databyte_in),
										.q_6144(shift_reg_out),
										.shiftout()
										 );
	
	//remapping module
	//*********passive module, unless a bug is spotted, it's done**************
	wire [6143:0] remap_in, remap_out;
	assign remap_in = shift_reg_out;
	coder_interleaver ci_inst(.cin(remap_in),
									  .K_eq_6144(k_size_6144),
									  .cout(remap_out)
									  );

	//counter
	//*******module to be finish and tested***********
	wire [13:0] mux_ind;
	ind_gen counter(.clock(clk),
					.k(k_size_6144),
					.ready(ready_in),
					.reset(clear),
					.out(mux_ind)
					);

	//mux
	//*******module to be finish and tested***********
	wire [6143:0] ci_array, cpii_array;
	assign ci_array = shift_reg_out;
	assign cpii_array = remap_out;

	mux6144 ci_mux( .arr(ci_array),
					.ind(mux_ind),
					.r(outi)
					);
	mux6144 cpii_mux(	.arr(cpii_array),
						.ind(mux_ind),
						.r(outpii)
						);


endmodule