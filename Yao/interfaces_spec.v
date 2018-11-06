
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

//once the above implementation works, at least the transmission of a full block can be tested. Its success means that the basic function of this module and a successful integration is achieved. This interface might not work for more than one blocks

//the next step is to move the shift register buffer outside of our module and make a duplicate to give the code-block group more controls over writing to the buffer. They can also implement the ping-pong mechanism. Or we could just block the dataflow for now until interleaver finishes transmitting the old block of data

//Here are the final module interfaces

module interleaver_top_level_final(
	input k_size_6144,      // 0 if 1056, 1 if 6144 block size
	input [6143:0] datablock,  // the whole data block
	input clock,         // clock 
	input rst,			// reset
	input ready_in,      // asserted to indicate the whole block is ready for us to process
	output process_complete,	//asserted to indicate the current whole block is processed
	output outi, // bitserial output using the same sequence as input, i.e. ci
	output outpii // bitserial output after remapping, i.e. cpii
	);

module shiftreg_6144(
	input aclr,
	input clk,
	input [7:0] shiftin,
	output [6143:0] q,
	output [7:0] shiftout //not really used
);