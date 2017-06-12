# Stimuli fuer component "control_game"
#--------------------------------------
restart -f
delete wave *
add wave reset_n
add wave clock
add wave start_n
add wave ani_stop
add wave current_state
add wave state

# clock-Frequenz : 50 MHz:
force clock 0 0 ns, 1 10 ns -repeat 20 ns

force reset_n   0 0 ns, 1 40 ns
force start_n   1 0 ns, 0 105 ns, 1 305 ns, 0 505 ns, 1 605 ns
force ani_stop  0 0 ns, 1 205 ns, 0 225 ns, 1 405 ns, 0 425 ns, 1 705 ns, 0 725 ns
run 1000 ns
