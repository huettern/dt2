force rst_n 1
force clk 0 0ns, 1 10ns -r 20ns
run 20ns
run 20ns
run 20ns
run 20ns
run 20ns
force e10rp true
run 20ns
run 20ns
force e10rp false
run 20ns
run 20ns
run 20ns
force e50rp true
run 20ns
force e50rp false
run 20ns

