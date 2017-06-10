onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /integrate/clk
add wave -noupdate /integrate/rst_n
add wave -noupdate /integrate/rst_int
add wave -noupdate -radix unsigned /integrate/tx
add wave -noupdate -radix unsigned /integrate/threshold
add wave -noupdate -radix unsigned /integrate/limit
add wave -noupdate -radix unsigned /integrate/int_value
add wave -noupdate /integrate/int_error
add wave -noupdate -radix unsigned /integrate/integrate_value
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {569 ns} 0}
quietly wave cursor active 1
configure wave -namecolwidth 384
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
WaveRestoreZoom {496 ns} {838 ns}
