onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /counter/rst_n
add wave -noupdate /counter/clk
add wave -noupdate /counter/cnt
add wave -noupdate /counter/ctrl
add wave -noupdate /counter/count
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {180 ns} 0}
quietly wave cursor active 1
configure wave -namecolwidth 227
configure wave -valuecolwidth 51
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
WaveRestoreZoom {153 ns} {277 ns}
