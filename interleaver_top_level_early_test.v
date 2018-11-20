//early model with shift register inside our module
//the interleaver will only process one block at a time since there's only one set of turbo coders

module interleaver_top_level_early_test(
	input k_size_6144,      // 0 if 1056, 1 if 6144 block size
	input [7:0] databyte_in,  // byte-wise serial input
	input clock,         // clock 
	input rst,			// reset
	input shift_en,
	input ready_in,       // asserted to indicate the whole block is filled and this module starts output serial stream; as of now it needs to be asserted for at least K cycles
	output outi, // bitserial output using the same sequence as input, i.e. ci
	output outpii // bitserial output after remapping, i.e. cpii
	//output process_complete
	);

	wire clk;
	assign clk=clock;

	wire clear;
	assign clear=rst;

	// shift register taking in byte-wise input
	//there is room for an extra byte if ready/datavalid is asserted one cycle after datavalid full block is full
	wire [6151:0] shift_reg_out;//,shift_reg_out1;
	// assign shift_reg_out = shift_reg_out1;
	shiftreg_buf input_shiftreg_inst1(.aclr(clear),
										.clk(clk),
										.shiftin(databyte_in),
										.shiften(shift_en),
										.q_out(shift_reg_out)
										);
	
	//secondary buffer
	wire [6143:0] reg_buf_out,reg_buf_in;
	//!!!!!!!!!!might need extra changes
	assign reg_buf_in=shift_reg_out[6143:0];
	reg6144 reg_rst(.clk(clk),
	.rst(clear),
	.en(ready_in),
	.D(reg_buf_in),
	.Q(reg_buf_out));


	//remapping module
	//*********passive module, unless a bug is spotted, it's done**************
	wire [6143:0] remap_in, remap_out, ci_array;
	//!!!!!!!!!!!!!!!!!!!this might need changing depending on the timing related to ready signal
	assign remap_in = reg_buf_out;
	coder_interleaver ci_inst(.cin(remap_in),
								.K_eq_6144(k_size_6144),
								.cout(remap_out),
								.ciout(ci_array)
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
	wire [6143:0] cpii_array;

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