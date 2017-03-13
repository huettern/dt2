onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /add_sub/mode
add wave -noupdate -radix symbolic -childformat {{/add_sub/x(7) -radix unsigned} {/add_sub/x(6) -radix unsigned} {/add_sub/x(5) -radix unsigned} {/add_sub/x(4) -radix unsigned} {/add_sub/x(3) -radix unsigned} {/add_sub/x(2) -radix unsigned} {/add_sub/x(1) -radix unsigned} {/add_sub/x(0) -radix unsigned}} -subitemconfig {/add_sub/x(7) {-height 15 -radix unsigned} /add_sub/x(6) {-height 15 -radix unsigned} /add_sub/x(5) {-height 15 -radix unsigned} /add_sub/x(4) {-height 15 -radix unsigned} /add_sub/x(3) {-height 15 -radix unsigned} /add_sub/x(2) {-height 15 -radix unsigned} /add_sub/x(1) {-height 15 -radix unsigned} /add_sub/x(0) {-height 15 -radix unsigned}} /add_sub/x
add wave -noupdate -radix symbolic /add_sub/y
add wave -noupdate -radix symbolic /add_sub/tmp
add wave -noupdate -radix symbolic /add_sub/result
add wave -noupdate /add_sub/ov_un_fl
add wave -noupdate -divider <NULL>
add wave -noupdate -radix unsigned /add_sub/x
add wave -noupdate -radix unsigned /add_sub/y
add wave -noupdate -radix unsigned /add_sub/result
add wave -noupdate /add_sub/ov_un_fl
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {20 ns} 0}
quietly wave cursor active 1
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
WaveRestoreZoom {0 ns} {63 ns}
