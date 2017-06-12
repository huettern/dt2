# Stimuli fuer component "rotate_leds"
#-------------------------------------
restart -f
delete wave *
add wave reset_n
add wave clock
add wave ani_en
add wave state
add wave pattern
add wave ani_pattern

# clock-Frequenz : 50 MHz:
force clock 0 0 ns, 1 10 ns -repeat 20 ns

force reset_n 0 0 ns, 1 40 ns
force ani_en  0 0 ns, 1 80 ns , 0 100 ns -repeat 100 ns
force state   00 0 ns, 01 255 ns, 10 855 ns , 10 1455 ns, 00 1655 ns
run 1.7 us
