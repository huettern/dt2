onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate -radix unsigned /add_sub_my/x
add wave -noupdate -radix unsigned /add_sub_my/y
add wave -noupdate -radix binary /add_sub_my/mode
add wave -noupdate -radix unsigned /add_sub_my/result
add wave -noupdate -radix binary /add_sub_my/ov_un_fl
add wave -noupdate -radix hexadecimal /add_sub_my/tmp
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {0 ns} 0}
quietly wave cursor active 0
configure wave -namecolwidth 314
configure wave -valuecolwidth 100
configure wave -justifyvalue left
configure wave -signalnamewidth 0
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
WaveRestoreZoom {0 ns} {838 ns}
