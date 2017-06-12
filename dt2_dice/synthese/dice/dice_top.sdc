## -----------------------------------------------------------------------------
## Filename: dice_top.sdc
## Author  : stefan.brantschen@fhnw.ch
## Date    : 27.05.2011
## Content : Timing Constraints
## -----------------------------------------------------------------------------

# Clock constraints
create_clock -name "clk_50" -period 20ns [get_ports {clock}] -waveform {0.000ns 10.000ns}

# Automatically constrain PLL and other generated clocks
derive_pll_clocks -create_base_clocks

# Automatically calculate clock uncertainty to jitter and other effects.
derive_clock_uncertainty

# tsu/th constraints

# tco constraints

# tpd constraints
