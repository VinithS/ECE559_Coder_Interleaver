module top_level_interleaver(
	input k_size,      // 0 if 1056, 1 if 6144 block size
	input databit_in,  // bitserial input
	input clk,         // clock  
	input ready,       // ready signal saying data is coming in
	input clear,
	output databit_out // bitserial output
	);
	
	// bitserial shift wires
	wire  reg1out,  reg2out,  reg3out,  reg4out,  reg5out,  reg6out,  reg7out,  reg8out,  reg9out, reg10out;
	wire reg11out, reg12out, reg13out, reg14out, reg15out, reg16out, reg17out, reg18out, reg19out, reg20out;
	wire reg21out, reg22out, reg23out, reg24out;
	
	// data wires
	wire[255:0]  reg1dat,  reg2dat,  reg3dat,  reg4dat,  reg5dat,  reg6dat,  reg7dat,  reg8dat,  reg9dat, reg10dat;
	wire[255:0] reg11dat, reg12dat, reg13dat, reg14dat, reg15dat, reg16dat, reg17dat, reg18dat, reg19dat, reg20dat;
	wire[255:0] reg21dat, reg22dat, reg23dat, reg24dat;

	// shift registers
	input_shifter  reg1(.aclr(clear), .clock(clk), .shiftin(databit_in), .q(reg1dat), .shiftout(reg1out));
	input_shifter  reg2(.aclr(clear), .clock(clk), .shiftin(reg1out), .q(reg2dat), .shiftout(reg2out));
	input_shifter  reg3(.aclr(clear), .clock(clk), .shiftin(reg2out), .q(reg3dat), .shiftout(reg3out));
	input_shifter  reg4(.aclr(clear), .clock(clk), .shiftin(reg3out), .q(reg4dat), .shiftout(reg4out));
	input_shifter  reg5(.aclr(clear), .clock(clk), .shiftin(reg4out), .q(reg5dat), .shiftout(reg5out));
	input_shifter  reg6(.aclr(clear), .clock(clk), .shiftin(reg5out), .q(reg6dat), .shiftout(reg6out));
	input_shifter  reg7(.aclr(clear), .clock(clk), .shiftin(reg6out), .q(reg7dat), .shiftout(reg7out));
	input_shifter  reg8(.aclr(clear), .clock(clk), .shiftin(reg7out), .q(reg8dat), .shiftout(reg8out));
	input_shifter  reg9(.aclr(clear), .clock(clk), .shiftin(reg8out), .q(reg9dat), .shiftout(reg9out));
	input_shifter reg10(.aclr(clear), .clock(clk), .shiftin(reg9out), .q(reg10dat), .shiftout(reg10out));
	input_shifter reg11(.aclr(clear), .clock(clk), .shiftin(reg10out), .q(reg11dat), .shiftout(reg11out));
	input_shifter reg12(.aclr(clear), .clock(clk), .shiftin(reg11out), .q(reg12dat), .shiftout(reg12out));
	input_shifter reg13(.aclr(clear), .clock(clk), .shiftin(reg12out), .q(reg13dat), .shiftout(reg13out));
	input_shifter reg14(.aclr(clear), .clock(clk), .shiftin(reg13out), .q(reg14dat), .shiftout(reg14out));
	input_shifter reg15(.aclr(clear), .clock(clk), .shiftin(reg14out), .q(reg15dat), .shiftout(reg15out));
	input_shifter reg16(.aclr(clear), .clock(clk), .shiftin(reg15out), .q(reg16dat), .shiftout(reg16out));
	input_shifter reg17(.aclr(clear), .clock(clk), .shiftin(reg16out), .q(reg17dat), .shiftout(reg17out));
	input_shifter reg18(.aclr(clear), .clock(clk), .shiftin(reg17out), .q(reg18dat), .shiftout(reg18out));
	input_shifter reg19(.aclr(clear), .clock(clk), .shiftin(reg18out), .q(reg19dat), .shiftout(reg19out));
	input_shifter reg20(.aclr(clear), .clock(clk), .shiftin(reg19out), .q(reg20dat), .shiftout(reg20out));
	input_shifter reg21(.aclr(clear), .clock(clk), .shiftin(reg20out), .q(reg21dat), .shiftout(reg21out));
	input_shifter reg22(.aclr(clear), .clock(clk), .shiftin(reg21out), .q(reg22dat), .shiftout(reg22out));
	input_shifter reg23(.aclr(clear), .clock(clk), .shiftin(reg22out), .q(reg23dat), .shiftout(reg23out));
	input_shifter reg24(.aclr(clear), .clock(clk), .shiftin(reg23out), .q(reg24dat), .shiftout(reg24out));

	// data bit to select from
	wire[1055:0] tmp_dat_1056 = {reg1dat, reg2dat, reg3dat, reg4dat, reg5dat[255:223]};
	wire[6143:0] dat_1056 = {5088'b0, tmp_dat_1056};
	
	wire[6143:0] dat_6144 = { tmp_dat_1056, reg5dat[222:0] ,  reg6dat,  reg7dat,  reg8dat, reg9dat, reg10dat,
									 reg11dat, reg12dat, reg13dat, reg14dat, reg15dat, reg16dat, reg17dat, reg18dat,
									 reg19dat, reg20dat, reg21dat, reg22dat, reg23dat, reg24dat};
	
	
	wire[6143:0] interleaver_input = k_size ? data_6144 : data_1056;
	
	// interleaver
	wire[6143:0] interleaver_output;
	
	coder_interleaver dummy_inst(
		.cin(interleaver_input),
		.K_eq_6144(k_size),
		.cout(interleaver_output)
	);
	
	// select data to serialize
	wire[1055:0] out_dat_1056 = interleaver_output[1055:0];
	wire[6143:0] out_dat_6144 = interleaver_output;
	
	// bit-serial output
	
	/* Put Cheg's module here */
	wire serial_out;
	
	

endmodule