# Stimuli fuer component "randomize"
#-----------------------------------
restart -f
delete wave *
add wave reset_n
add wave clock
add wave state
add wave rnd_number
add wave rnd_pattern

# clock-Frequenz : 50 MHz:
force clock 0 0 ns, 1 10 ns -repeat 20 ns

force reset_n 0 0 ns, 1 40 ns
force state   00 0 ns, 01 105 ns, 10 305 ns , 11 405 ns , 00 505 ns
run 1 us
