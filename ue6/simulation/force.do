force clk 0 0ns, 1 10ns -r 20ns
force reset 1
run 40ns
force reset 0
force enable 1
run 400ns
