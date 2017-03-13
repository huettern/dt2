force rst_n 1

force clk 0 0ns, 1 10ns -r 20ns

run 400ns

force rst_n 0

run 50ns

force rst_n 1

run 100ns
