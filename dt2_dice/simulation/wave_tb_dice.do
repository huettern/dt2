onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate -format Logic /tb_dice/reset_n
add wave -noupdate -format Logic /tb_dice/clock
add wave -noupdate -format Logic /tb_dice/start_n
add wave -noupdate -divider CONTROL_GAME
add wave -noupdate -format Logic /tb_dice/duv/control_game_inst/start_n
add wave -noupdate -format Logic /tb_dice/duv/control_game_inst/ani_stop
add wave -noupdate -format Literal /tb_dice/duv/control_game_inst/current_state
add wave -noupdate -divider RANDOMIZE
add wave -noupdate -format Literal /tb_dice/duv/randomize_inst/rnd_number
add wave -noupdate -format Literal /tb_dice/duv/randomize_inst/rnd_pattern
add wave -noupdate -divider DECELERATE
add wave -noupdate -format Literal /tb_dice/duv/decelerate_inst/state
add wave -noupdate -format Logic /tb_dice/duv/decelerate_inst/ani_en
add wave -noupdate -format Logic /tb_dice/duv/decelerate_inst/ani_stop
add wave -noupdate -divider ROTATE_LEDS
add wave -noupdate -format Literal /tb_dice/duv/rotate_inst/state
add wave -noupdate -format Logic /tb_dice/duv/rotate_inst/ani_en
add wave -noupdate -format Literal /tb_dice/duv/rotate_inst/pattern
add wave -noupdate -format Literal /tb_dice/duv/rotate_inst/ani_pattern
add wave -noupdate -divider DICE_TOP
add wave -noupdate -format Literal /tb_dice/duv/state
add wave -noupdate -format Literal /tb_dice/duv/rnd_pattern
add wave -noupdate -format Literal /tb_dice/duv/ani_pattern
add wave -noupdate -format Literal /tb_dice/duv/hex_n
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {21146728 ns} 0}
configure wave -namecolwidth 150
configure wave -valuecolwidth 100
configure wave -justifyvalue left
configure wave -signalnamewidth 1
configure wave -snapdistance 10
configure wave -datasetprefix 0
configure wave -rowmargin 4
configure wave -childrowmargin 2
configure wave -gridoffset 0
configure wave -gridperiod 1
configure wave -griddelta 40
configure wave -timeline 0
configure wave -timelineunits ns
update
WaveRestoreZoom {0 ns} {44040360 ns}
