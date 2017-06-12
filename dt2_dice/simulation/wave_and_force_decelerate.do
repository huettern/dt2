# Stimuli fuer component "decelerate" #
#--------------------------------------
vsim -gg_test=true decelerate 
add wave reset_n
add wave clock
add wave state
add wave ani_en
add wave ani_stop
add wave scale_cnt
add wave slow_down_cnt
add wave step_cnt

# clock-Frequenz : 50 MHz:
force clock 0 0 ns, 1 10 ns -repeat 20 ns

force reset_n 0 0 ns, 1 40 ns
force state   00 0 ns, 01 105 ns, 10 455 ns, 00 7005 ns, 01 7105 ns, 10 8000 ns
run 13 us
