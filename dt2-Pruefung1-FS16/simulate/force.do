force clk 0 0ns, 1 5ns -r 10ns
force tx 10#0
force rst_int 0
force threshold 10#15
force limit 10#3840
force tx 10#0
force rst_n 0
run 30ns
force rst_n 1
run 30ns
force tx 10#14
run 10ns
force tx 10#16
run 10ns
force tx 10#10
run 10ns
force tx 10#15
run 10ns
force tx 10#255
run 200ns
force rst_int 1
run 10ns
force rst_int 0
run 50ns