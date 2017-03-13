onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /bin2hex/data
add wave -noupdate /bin2hex/a
add wave -noupdate /bin2hex/b
add wave -noupdate /bin2hex/c
add wave -noupdate /bin2hex/d
add wave -noupdate /bin2hex/e
add wave -noupdate /bin2hex/f
add wave -noupdate /bin2hex/g
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {124 ns} 0}
quietly wave cursor active 1
configure wave -namecolwidth 150
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
WaveRestoreZoom {0 ns} {621 ns}
