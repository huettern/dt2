# Stimuli fuer component "control_game"
#--------------------------------------
restart -f
delete wave *
add wave dice_top/reset_n
add wave dice_top/clock
add wave dice_top/start_n
add wave dice_top/hex_n
add wave -divider {CONTROL GAME}
add wave dice_top/control_game_inst/current_state
add wave dice_top/control_game_inst/state
add wave -divider DECELERATE
add wave dice_top/decelerate_inst/ani_en
add wave dice_top/decelerate_inst/ani_stop
add wave -divider RANDOMIZE
add wave dice_top/randomize_inst/rnd_number
add wave dice_top/randomize_inst/rnd_pattern
add wave -divider ROTATE
add wave dice_top/rotate_inst/ani_pattern


# clock-Frequenz : 50 MHz:
force clock 0 0 ns, 1 10 ns -repeat 20 ns

force reset_n 0 0 ns, 1 40 ns
force start_n 1 0 ns, 0 120 ns, 1 250 ms

run 2.5 sec