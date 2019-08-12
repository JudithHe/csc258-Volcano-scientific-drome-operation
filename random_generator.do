# simulation for RandomGenerator
vlib work

vlog -timescale 1ns/1ns draw.v

vsim -L altera_mf_ver random_generator

# Log all signals and add some signals to waveform window.
log {/*}
# add wave {/*} would add all items in top level simulation module.
add wave {/*}

force {resetn} 0
force {clk} 1 0,0 10ns -r 20ns
run 40ns

force {resetn} 1
force {clk} 1 0,0 10ns -r 20ns
run 200ns