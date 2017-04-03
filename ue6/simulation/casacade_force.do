force reset 1
force clk 0 0ns, 1 10ns -r 20ns
run 40ns
force reset 0
run 3000ns
