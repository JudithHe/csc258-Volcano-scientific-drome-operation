# simulation for SpeedController
vlib work

vlog -timescale 1ns/1ns SpeedController.v

vsim -L altera_mf_ver SpeedController

# Log all signals and add some signals to waveform window.
log {/*}
# add wave {/*} would add all items in top level simulation module.
add wave {/*}

force {game_level} 0
force {clk} 1 0,0 10ns -r 20ns
run 260_0000ns

force {game_level} 1
force {clk} 1 0,0 10ns -r 20ns
run 250_0000ns