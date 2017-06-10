onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /tb_hex_count_u11/stimuli_gen/rst_n
add wave -noupdate /tb_hex_count_u11/stimuli_gen/clk
add wave -noupdate /tb_hex_count_u11/stimuli_gen/btn_n
add wave -noupdate -divider VERIFY
add wave -noupdate /tb_hex_count_u11/stimuli_gen/enable
add wave -noupdate -radix symbolic /tb_hex_count_u11/stimuli_gen/hex_n
add wave -noupdate -divider DUV
add wave -noupdate /tb_hex_count_u11/stimuli_gen/btn_n
add wave -noupdate -radix symbolic /tb_hex_count_u11/duv/hex_n
add wave -noupdate -divider DUV/CTRL
add wave -noupdate -radix hexadecimal /tb_hex_count_u11/duv/i0_ctrl/slow_down_cnt
add wave -noupdate /tb_hex_count_u11/duv/i0_ctrl/enable_value_cnt
add wave -noupdate -radix unsigned /tb_hex_count_u11/duv/i0_ctrl/value_cnt
add wave -noupdate -divider DUV/BIN2HEX
add wave -noupdate -radix hexadecimal /tb_hex_count_u11/duv/i0_bin2hex/data
add wave -noupdate /tb_hex_count_u11/duv/i0_bin2hex/a
add wave -noupdate /tb_hex_count_u11/duv/i0_bin2hex/b
add wave -noupdate /tb_hex_count_u11/duv/i0_bin2hex/c
add wave -noupdate /tb_hex_count_u11/duv/i0_bin2hex/d
add wave -noupdate /tb_hex_count_u11/duv/i0_bin2hex/e
add wave -noupdate /tb_hex_count_u11/duv/i0_bin2hex/f
add wave -noupdate /tb_hex_count_u11/duv/i0_bin2hex/g
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {392 ns} 0} {{Cursor 2} {1365 ns} 0}
quietly wave cursor active 1
configure wave -namecolwidth 234
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
WaveRestoreZoom {0 ns} {1156 ns}
