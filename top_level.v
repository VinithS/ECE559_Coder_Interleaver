module top_level(
	input k_size_6144,      // 0 if 1056, 1 if 6144 block size
	input [7:0] databit_in1,  // bite-wise serial input
	input CLOCK_50,         // clock , or do we want to do manual clock?
	input ready_in,       // start out put serial stream
	input KEY_0, //active low: pushed=0, using for reset/clear
	output LEDR0, //to be determined how to use these
	output LEDR1, 
	output LEDR2, 
	output LEDR3, 
	output LEDR4, 
	output LEDR5, 
	output LEDR6, 
	output LEDR7,
	output outi, // bitserial output using the same sequence as input
	output outpii, // bitserial output after remapping
	output [6:0] seg0, seg1, seg2, seg3, seg4, seg5,
	input switch
	);
	
	wire clk;
	assign clk = CLOCK_50;

	wire clear;
	assign clear = ~KEY_0;
	
	reg [9:0] mem_counter;
	reg led_latch;
	
//	reg [6143:0] test_case_one = 6144'b001110110111111011111000000110001110110111010000011101000101000011011101011110111111101100011001001001001010110011011001011110111000110001000110100001111110100000110110101101111010001011000101101001111100110111111010101110101101001000100000011100111100110000011101101111001100010000110000110110101000100001000001011100100010110100010111000110111001000111110111110100111011011010100110001011011101000010110100100001010101011011110011101011011101000100010001010111111101101010111101111011010000011010000110010101100110110101011110101110010010101111010111111101110110001100100110110110101011010111111110110111110110111110101001011101001011000000011001000000101111000101110111001011110010011100010010000110010110000010100111000000011111101011000110101001111101110110011101100101000010101010011110000000010111111011100100011000000001110011100101111101001110101001101011001011101111101100110011100110000110101110001111000100001000001001111001001101001100100111101001010110001110111100000000101111100101100010101010100110010111111100000100001000001011110010011011110011000101001000011111110010101000110011010010011101011111000001101110010011001101111110011011100101001001011110111100001110100110000110110111111000000111010010111010101000111000101000000010110000000010001010010111000100101001001110011110110101101101101111111100100000100011000111010001011111100000001011000100101111100101111111010000001010101101010100110001001001101000111110111101011111000011111010000011110001010010101001011011010111101001001001000100000001011010010110010111011100001010010100111110000011110101011110001010001011100011100000011010001111110001100011101011001010110000010010001101000111101111101110000100011000100001111010101000100010111001011010110110001001110000010000010111000101110010101110011110101011101100000100001101011101100101001110001100101110001100001111010011010100000101010000011011000000101000011101110010010010101101110101011111000000101101100101111010001011111110001011110101111001000010100110110001111000110000000011001101100100010100001010101100010001101111101000001110100101110100111111010100101000011111101001000111001111011101011110011110001100010111000010001001101111100100010000010010011000010101000101000001100000000111111100000010011010010110101001111011110010110111100100101001111010101110101100100111101111000111000011111001000100100000010010000100101010111110001101001010101100101111011101000011010101110101101010011011010110010111001110000001000101000110011110001100001100101110011100010110100111000110000010100001010010001111100110011111000100000100110111110100101000101001101010000000100101011100011111000100011100110000011011010001100011010110100000100000101000110111111001000101111011010000100011100011010010011100111010001001111111011110010001000011011101000001000110000100010001010111001001000001110001110001110100100100100100111111100011100101000010101100001001001010011101100001001010011110101100011100010001001110000110000010010011000110101010110000100100110000001000111011001010010101000101100100110010011011110101101010001110011110110100011000010110010010100111101001111100111010100011111111111001101111100011111010000110110010011000110101111001000010001101110110000110110000111110010000011101101001011010001101110111010001000110110101101100011001000011011001011001000101101001101100001101000100001011001010001101001000010100100010101111111100111011101110111000000001001000101011111010011101101101011001111101101011101011100100111110011001001010001100111011011101011010111100001110011101010110100011110100011000110000000000100100010100011110001110111110000001100000010001100010000011110100110000000101101001000111101000111011100011011000101100001001000101100111101101101001001010010010111011111001110110010100111111110001010011100010110000110110100010101111000000101100101101111111010011011101000011100000101101101001110000011000110100001001111000000101000001000100101100011000010000111011101001100101100001001010001011000000111110010101010100001100111010100000001010000111001111100011111010111001100100000110101101010111010000000000011110111101110111100101011100100111101011000011011100110110010011000100000001001000110100001001101100010000111101100011000011111001011000000011000101101001010000100100011110110100101111001010100000111011011011110110111111111100110010100111100110110000011110100101111111011100101000111010011110000000001000110001011010100110101011101111001011011110010010111100110010011000001000011000100100101110010100110001001101111010101111010101111110100011101011011010100001110100101100000011101001010100100110010010001101001001011011111100101100111101111000100101110101100001010101101011110000011111110101011111111001011001010000100110000100001001110001110000010011000000000110001001100101011001001001010001001100101111111000000100001001111110001110011111110001101010111001110101011110010100111111000100010110010110111011100111101001100011000111000010011101110111110001000000000011110010001011101011110110111101011010000111111011001001010011000101110101001001110110001100100110110011010100111001100010000001010010001110110001001000011011101011100010110011011000110010011011110111100000110110111100100100011100001100101001001000000100011100101101110001000010100001111011111110101110010010001100111111110100000111000111111011001001001101011111000000010101110100010011010100011010100111001100100011001000000101101100011010100100001000011100001101111000110001111101101111101001100011000010110001000100110001011001101011001110110100011111100000100001111000000011011101101100111110000000001110001011111110100000000100000010001101110100000001000000011111110101011100010100111110010100000001000100000010111100011101100101010000101000100100000010011010111100001111101110101011110000010110000001111000001100111011011011001100011100010110110111110101111000110011101110101110010111001110001111011001101101100101101001011011111111101100111010110010110100100100111001010110010011100111000111010011111100100110011100110101010100100100100000101001011000100001110111100100101000001101000101000100111110011011000101100110010100111101000001011010000110101110010010011101010100000011001110010111000100110001100011110011110111;
	// MSB 8 bits = 10111111
	reg test_case_one_k_size = 1'b1;
	
	initial begin
		mem_counter = 10'b0;
		led_latch = 1'b0;
		led_val_latch = 16'b0;
		disp_clk = 1'b0;
	end
	
	reg [19:0] count_20;
	reg disp_clk; // 50 Hz clock
	always @(posedge clk) begin
		count_20 <= count_20 + 1'd1;
		if(count_20 == 1000000)
		begin
			count_20<=0;
			disp_clk <= !disp_clk;
		end
	end
	
	/********************** DATA FROM OUTPUT SEQUENCE ****************/
	wire [6:0] out_0, out_1, out_2, out_3, out_4, out_5;
	
	
	wire [3:0] t_out_5, t_out_4, t_out_3, t_out_2, t_out_1, t_out_0;
	assign t_out_0 = led_val_latch[3:0];
	assign t_out_1 = led_val_latch[7:4];
	assign t_out_2 = led_val_latch[11:8];
	assign t_out_3 = led_val_latch[15:12];
	assign t_out_4 = led_val_latch[19:16];
	assign t_out_5 = led_val_latch[23:20];
	
	hex_to_seven datout0(t_out_0, out_0);
	hex_to_seven datout1(t_out_1, out_1);
	hex_to_seven datout2(t_out_2, out_2);
	hex_to_seven datout3(t_out_3, out_3);
	hex_to_seven datout4(t_out_4, out_4);
	hex_to_seven datout5(t_out_5, out_5);
	
	/*********************** DATA FROM MEMORY ************************/
	wire [6:0] counter0, counter1, counter2;
	wire [6:0] counter3 = 7'b0;
	
	// output of ROM
	wire [6:0] mem_dat0, mem_dat1;
	hex_to_seven memout1(memory_dat[7:4], mem_dat1);
	hex_to_seven memout2(memory_dat[3:0], mem_dat0);	
	
	// Counter value
	hex_to_seven counter1h(counter_val_latch[3:0], counter0);
	hex_to_seven counter2h(counter_val_latch[7:4], counter1);
	hex_to_seven counter3h({2'b0, counter_val_latch[9:8]}, counter2);
	/******************************************************************/
	
	/****** LOGIC TO SELECT SEVEN SEGMENT OUTPUT BASED ON SWITCH ******/
	assign seg0 = switch ? out_0 : mem_dat0;
	assign seg1 = switch ? out_1 : mem_dat1;
	assign seg2 = switch ? out_2 : counter0;
	assign seg3 = switch ? out_3 : counter1;
	assign seg4 = switch ? out_4 : counter2;
	assign seg5 = switch ? out_5 : counter3;
	
	
	// counter
	reg done = 0;
	always @(posedge clk or posedge clear) begin
		if (clear) begin
			mem_counter <= 10'b0 ;
			done <= 1'b0;
		end
		else if (mem_counter >= 10'd767) begin
//			mem_counter <= 10'b0;			
			done <= 1'b1;
		end
		else begin
			mem_counter <= mem_counter + 1'd1;
//			done <= 1'b0;
		end
		
	end
		
	reg [23:0] led_val_latch;
	reg [9:0] counter_val_latch;
	reg ctr_latch;
	
	
	always@(*) begin
		if (~done) begin
			led_val_latch <= remap_out[23:0];
			counter_val_latch <= mem_counter;
		end
//		else begin
//			led_val_latch <= 16'b0;
//			counter_val_latch <= 10'b0;
//		end
	end
	
	assign LEDR0 = led_val_latch[0];
	assign LEDR1 = led_val_latch[1];
	assign LEDR2 = led_val_latch[2];
	assign LEDR3 = led_val_latch[3];
	assign LEDR4 = led_val_latch[4];
	assign LEDR5 = led_val_latch[5];
	assign LEDR6 = led_val_latch[6];
	assign LEDR7 = led_val_latch[7];
	
	
	/********************************************
						MEMORY
    ********************************************/
	 dat_mem shifting_data(
			.address    (mem_counter),            // address of data
			.clock      (~clk),             // you may need to invert the clock
			.q          (memory_dat)      // shift data
		);
	
	wire [7:0] memory_dat;
	
	// shift register taking in byte-wise input
	wire [6143:0] shift_reg_out,shift_reg_out1;
	assign shift_reg_out = shift_reg_out1;
	// wire [7:0]
	//**********to do in the future, have 2 shiftreg to 
	shiftreg_6144 input_shiftreg_inst1(.aclr(clear),
												  .clk(clk),
//												  .clk(disp_clk),
//												  .shiftin(databit_in1),
												  .shiftin(memory_dat),
//												  .shiftin(test_case_one),
												  .q_6144(shift_reg_out1),
											     .shiftout()
												  );
	
	// // bitserial shift wires
	// wire  reg1out,  reg2out,  reg3out,  reg4out,  reg5out,  reg6out,  reg7out,  reg8out,  reg9out, reg10out;
	// wire reg11out, reg12out, reg13out, reg14out, reg15out, reg16out, reg17out, reg18out, reg19out, reg20out;
	// wire reg21out, reg22out, reg23out, reg24out;
	
	//remapping module
	//*********passive module, unless a bug is spotted, it's done**************
	wire [6143:0] remap_in, remap_out;
	assign remap_in = shift_reg_out;
	coder_interleaver ci_inst(.cin(remap_in),
//									  .K_eq_6144(k_size_6144),
									  .K_eq_6144(test_case_one_k_size),
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

	mux6144 ci_mux(.arr(ci_array),
						.ind(mux_ind),
						.r(outi)
						);
	mux6144 cpii_mux(.arr(cpii_array),
						  .ind(mux_ind),
						  .r(outpii)
						  );

endmodule
