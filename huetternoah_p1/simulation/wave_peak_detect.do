onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /peak_detect/rst
add wave -noupdate /peak_detect/clk
add wave -noupdate -radix unsigned /peak_detect/data_in
add wave -noupdate /peak_detect/data_valid
add wave -noupdate /peak_detect/peak_rst
add wave -noupdate -radix unsigned /peak_detect/peak
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {0 ns} 0}
quietly wave cursor active 0
configure wave -namecolwidth 307
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
WaveRestoreZoom {0 ns} {687 ns}
