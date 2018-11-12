# Constrain clock port clk with a 10-ns requirement

create_clock -period 10 [get_ports clk]

# Automatically apply a generate clock on the output of phase-locked loops (PLLs) 
# This command can be safely left in the SDC even if no PLLs exist in the design

derive_pll_clocks

# Constrain the input I/O path

set_input_delay -clock clk -max 3 [databyte_in]

set_input_delay -clock clk -min 2 [databyte_in]

# Constrain the output I/O path

set_output_delay -clock clk -max 3 [outi]

set_output_delay -clock clk -min 2 [outi]

