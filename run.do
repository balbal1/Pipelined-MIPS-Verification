vlib work
vlog src/instruction.sv
vlog src/pipelined_mips_top.sv src/pipelined_mips_if.sv src/pipelined_mips.sv src/pipelined_mips_tb.sv src/pipelined_mips_sva.sv src/pipelined_mips_monitor.sv +cover
vsim -voptargs=+acc work.pipelined_mips_top
add wave /pipelined_mips_top/_if/*
add wave /pipelined_mips_top/DUT/instruction_memory
add wave /pipelined_mips_top/DUT/data_memory
run -all
#quit -sim
#vcover report pipelined_mips.ucdb -details -annotate -all -output coverage_report.txt
