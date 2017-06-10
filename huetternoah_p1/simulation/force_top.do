force rst 1
force clk 0 0ns, 1 5ns -r 10ns
run 10ns
force rst 0
run 1000ns