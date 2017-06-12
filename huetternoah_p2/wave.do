onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate -divider TB
add wave -noupdate /tb_reg_if/comp_duv/rst_n
add wave -noupdate /tb_reg_if/comp_duv/clk
add wave -noupdate /tb_reg_if/comp_duv/uart_rxd
add wave -noupdate /tb_reg_if/comp_duv/reg_addr
add wave -noupdate /tb_reg_if/comp_duv/reg_data
add wave -noupdate /tb_reg_if/comp_duv/reg_wr
add wave -noupdate /tb_reg_if/comp_duv/rx_data
add wave -noupdate /tb_reg_if/comp_duv/rx_data_rdy
add wave -noupdate -divider DUV
add wave -noupdate /tb_reg_if/comp_duv/rst_n
add wave -noupdate /tb_reg_if/comp_duv/clk
add wave -noupdate /tb_reg_if/comp_duv/uart_rxd
add wave -noupdate /tb_reg_if/comp_duv/reg_addr
add wave -noupdate /tb_reg_if/comp_duv/reg_data
add wave -noupdate /tb_reg_if/comp_duv/reg_wr
add wave -noupdate /tb_reg_if/comp_duv/rx_data
add wave -noupdate /tb_reg_if/comp_duv/rx_data_rdy
add wave -noupdate -divider VERIFY
add wave -noupdate /tb_reg_if/comp_verify/reg_addr
add wave -noupdate /tb_reg_if/comp_verify/reg_data
add wave -noupdate /tb_reg_if/comp_verify/reg_wr
add wave -noupdate /tb_reg_if/comp_verify/rst_n
add wave -noupdate /tb_reg_if/comp_verify/clk
add wave -noupdate /tb_reg_if/comp_verify/uart_txd
add wave -noupdate /tb_reg_if/comp_verify/enable
add wave -noupdate /tb_reg_if/comp_verify/uart_state
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {0 ns} 0}
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
WaveRestoreZoom {0 ns} {2406713 ns}
