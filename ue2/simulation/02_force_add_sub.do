# addition
force mode 0 0ns
force x 00000001 0ns, 11110000 10ns
force y 00000001 0ns, 00001111 10ns, 00010000 20ns
run 30 ns

# subtraction
force mode 1 0ns
force x 16#FF 10ns, 16#01 20ns
force y 16#F0 10ns, 16#01 20ns, 16#03 30ns
run 40ns
