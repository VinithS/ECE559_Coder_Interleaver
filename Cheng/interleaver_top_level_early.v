//early model with shift register inside our module
//the interleaver will only process one block at a time since there's only one set of turbo coders

module interleaver_top_level_early(
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
	shiftreg_buff input_shiftreg_inst1(.aclr(clear),
										.clk(clk),
										.shiftin(databyte_in),
										.shiften(shift_en),
										.qout(shift_reg_out),
										);
	


	//store register store the content of shift register with ready_in as enable, so it contains the data when ready while shift register is constantly changing
	//store register takes the last 6144 bits from shift register, since the shift register has extra space due to the delay on ready_in

	store_register store_reg_inst1(.clk(clock),
								   .enable(ready_in),
								   .reset(rst),
								   .d(shift_reg_out [6143:0]),
								   .q(remap_in)



	//remapping module
	//*********passive module, unless a bug is spotted, it's done**************
	wire [6143:0] remap_in, remap_out;
	//!!!!!!!!!!!!!!!!!!!this might need changing depending on the timing related to ready signal
	///assign remap_in = shift_reg_out[6143:0];
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