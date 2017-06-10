# huetter noah
force rst 1
force clk 0 0ns, 1 5ns -r 10ns
force data_in 10#0
force data_valid 0
force peak_rst 0
run 10ns
force rst 0
run 10ns
force data_in 10#10
force data_valid 1
run 10ns
force data_in 10#5
run 10ns
force data_in 10#7
run 10ns
force data_in 10#9
run 10ns
force data_in 10#11
run 10ns
force data_in 10#200
force data_valid 0
run 10ns
force data_in 10#100
run 10ns
force data_in 10#80
force data_valid 1
run 10ns
force data_in 10#90
force peak_rst 1
run 10ns
force data_in 10#50
force peak_rst 0
run 10ns
force data_valid 0
run 10ns

