vdel -lib work -all
vlib work
vmap work work
vlog tb/parameter_pkg.sv
vlog tb/my_pkg.sv
vlog tb/interfaces/fifo_if.sv
vlog tb/fifo_sva.sv
vlog rtl/fifo.sv
vlog tb/top.sv
vopt +acc top -o top_op
vsim -sv_seed random -assertdebug top_op
add wave -position insertpoint sim:/top/dut/*
run -all
