transcript on
if {[file exists rtl_work]} {
	vdel -lib rtl_work -all
}
vlib rtl_work
vmap work rtl_work

vlog -vlog01compat -work work +incdir+C:/Users/0yaoy/Documents/GitHub/ECE559_Coder_Interleaver {C:/Users/0yaoy/Documents/GitHub/ECE559_Coder_Interleaver/dummy_top.v}
vlog -vlog01compat -work work +incdir+C:/Users/0yaoy/Documents/GitHub/ECE559_Coder_Interleaver {C:/Users/0yaoy/Documents/GitHub/ECE559_Coder_Interleaver/coder_interleaver.v}

vlog -vlog01compat -work work +incdir+C:/Users/0yaoy/Documents/GitHub/ECE559_Coder_Interleaver/Yao {C:/Users/0yaoy/Documents/GitHub/ECE559_Coder_Interleaver/Yao/bitwise_tb.v}

vsim -t 1ps -L altera_ver -L lpm_ver -L sgate_ver -L altera_mf_ver -L altera_lnsim_ver -L cyclonev_ver -L cyclonev_hssi_ver -L cyclonev_pcie_hip_ver -L rtl_work -L work -voptargs="+acc"  turbo_tb

add wave *
view structure
view signals
run -all
