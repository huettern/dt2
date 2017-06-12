-----------------------------------------------------
-- Project DICE
-----------------------------------------------------
-- File    : verify.vhd
-- Library : work
-- Author  : stefan.brantschen@fhnw.ch
-- Created : 28.03.2012
-- Company : Institute of Microelectronics (IME) FHNW
-- Copyright(C) IME
-----------------------------------------------------
library ieee;
use ieee.std_logic_1164.all;
library work;
use work.dice_package.all;
library std;
use std.textio.all;

entity verify is
  port( 
    hex_n   : in  std_ulogic_vector(6 downto 0);
    clock   : out std_ulogic;
    reset_n : out std_ulogic;
    start_n : out std_ulogic
  );
end entity verify ;

architecture stimulate_and_monitor of verify is
   
  constant c_rotate_1 : std_ulogic_vector(6 downto 0) := "1111110";
  constant c_rotate_2 : std_ulogic_vector(6 downto 0) := "1111101";
  constant c_rotate_3 : std_ulogic_vector(6 downto 0) := "1111011";
  constant c_rotate_4 : std_ulogic_vector(6 downto 0) := "1110111";
  constant c_rotate_5 : std_ulogic_vector(6 downto 0) := "1101111";
  constant c_rotate_6 : std_ulogic_vector(6 downto 0) := "1011111";
                                          
  constant c_clk_length : time := 20 ns;
  signal enable         : boolean := true;
   
begin

  p_generate_reset : process
  begin
    reset_n <= '0';
    wait for 50 ns;
    reset_n <= '1';
    wait;
  end process p_generate_reset;
   
      
  p_generate_clock : process
  begin
    while enable = true loop
      clock <= '1';
      wait for c_clk_length/2;
      clock <= '0';
      wait for c_clk_length/2;
    end loop;
    wait;
  end process p_generate_clock;
    
   
  p_input_sequence : process
  begin
    start_n <= '1';
    wait for 100 ns;
    wait until falling_edge(clock);    
    start_n <= '0';   -- button is pressed : rotation clockwise
    wait until hex_n = c_rotate_6;   
    wait until hex_n = c_rotate_1;   -- at least once around clockwise
    wait until falling_edge(clock);     
    start_n <= '1';   -- button is released : rotation anticlockwise
    wait;
  end process p_input_sequence;   
 

  p_check_leds : process
    variable start: time := 0 ns;
    variable duration: time := 0 ns;
  begin

    write(output, "check initial status" & lf);
    wait until reset_n = '1';  -- reset released
    assert hex_n = c_cipher_0 report "reset-state wrong: "& to_string(hex_n) & " instead of "& to_string(c_cipher_0) severity error;
      
    write(output, "check rotation (clockwise)" & lf);
	  wait until falling_edge(start_n);  -- button pressed
    wait on hex_n;
    assert hex_n = c_rotate_1 report "clockwise: 1st rotation-state wrong: "& to_string(hex_n) & " instead of "& to_string(c_rotate_1) severity error;
    start := now;
    write(output, ht & "1st clockwise rotation checked" & lf);

    wait on hex_n;
    assert hex_n = c_rotate_2 report "clockwise: 2nd rotation-state wrong: "& to_string(hex_n) & " instead of "& to_string(c_rotate_2) severity error;
    duration := now - start;
    start := now;
    write(output, ht & "2nd clockwise rotation checked" & lf);
             
    wait on hex_n;
    assert hex_n = c_rotate_3 report "clockwise: 3rd rotation-state wrong: "& to_string(hex_n) & " instead of "& to_string(c_rotate_3) severity error;
    assert now-start = duration report "clockwise: rotation-speed not constant: was "& to_string(duration) & ", but now "& to_string(now-start) severity error;
    start := now;
    write(output, ht & "3rd clockwise rotation checked" & lf);
       
    wait on hex_n;
    assert hex_n = c_rotate_4 report "clockwise: 4th rotation-state wrong: "& to_string(hex_n) & " instead of "& to_string(c_rotate_4) severity error;
    assert now-start = duration report "clockwise: rotation-speed not constant: was "& to_string(duration) & ", but now "& to_string(now-start) severity error;
    start := now;
    write(output, ht & "4th clockwise rotation checked" & lf);
       
    wait on hex_n;
    assert hex_n = c_rotate_5 report "clockwise: 5th rotation-state wrong: "& to_string(hex_n) & " instead of "& to_string(c_rotate_5) severity error;
    assert now-start = duration report "clockwise: rotation-speed not constant: was "& to_string(duration) & ", but now "& to_string(now-start) severity error;
    start := now;
    write(output, ht & "5th clockwise rotation checked" & lf);
       
    wait on hex_n;
    assert hex_n = c_rotate_6 report "clockwise: 6th rotation-state wrong: "& to_string(hex_n) & " instead of "& to_string(c_rotate_6) severity error;
    assert now-start = duration report "clockwise: rotation-speed not constant: was "& to_string(duration) & ", but now "& to_string(now-start) severity error;
    write(output, ht & "6th clockwise rotation checked" & lf);

    ----------------------------------------------------------------------------------
      
    write(output, "check rotation (anticlockwise)" & lf);
    wait until rising_edge(start_n);
        
    wait on hex_n;
    assert hex_n = c_rotate_6 report "anticlockwise: 1st rotation-state wrong: "& to_string(hex_n) & " instead of "& to_string(c_rotate_6) severity error;
    start := now;
    write(output, ht & "1st anticlockwise rotation checked" & lf);

    wait on hex_n;
    assert hex_n = c_rotate_5 report "anticlockwise: 2nd rotation-state wrong: "& to_string(hex_n) & " instead of "& to_string(c_rotate_5) severity error;
    duration := now - start;
    start := now;
    write(output, ht & "2nd anticlockwise rotation checked" & lf);
       
    wait on hex_n;
    assert hex_n = c_rotate_4 report "anticlockwise: 3rd rotation-state wrong: "& to_string(hex_n) & " instead of "& to_string(c_rotate_4) severity error;
    assert now-start > duration report "anticlockwise: rotation-speed is not decreasing: was "& to_string(duration) & ", but now "& to_string(now-start) severity error;
    duration := now - start;
    start := now;
    write(output, ht & "3rd anticlockwise rotation checked" & lf);
             
    wait on hex_n;
    assert hex_n = c_rotate_3 report "anticlockwise: 4th rotation-state wrong: "& to_string(hex_n) & " instead of "& to_string(c_rotate_3) severity error;
    assert now-start > duration report "anticlockwise: rotation-speed is not decreasing: was "& to_string(duration) & ", but now "& to_string(now-start) severity error;
    duration := now - start;
    start := now;
    write(output, ht & "4th anticlockwise rotation checked" & lf);
      
    wait on hex_n;
    assert hex_n = c_rotate_2 report "anticlockwise: 5th rotation-state wrong: "& to_string(hex_n) & " instead of "& to_string(c_rotate_2) severity error;
    assert now-start > duration report "anticlockwise: rotation-speed is not decreasing: was "& to_string(duration) & ", but now "& to_string(now-start) severity error;
    duration := now - start;
    start := now;
    write(output, ht & "5th anticlockwise rotation checked" & lf);

    wait on hex_n;
    assert hex_n = c_rotate_1 report "anticlockwise: 6th rotation-state wrong: "& to_string(hex_n) & " instead of "& to_string(c_rotate_1) severity error;
    assert now-start > duration report "anticlockwise: rotation-speed is not decreasing: was "& to_string(duration) & ", but now "& to_string(now-start) severity error;
    duration := now - start;
    start := now;
    write(output, ht & "6th anticlockwise rotation checked" & lf);

    wait on hex_n;
    assert hex_n = c_rotate_6 report "anticlockwise: 7th rotation-state wrong: "& to_string(hex_n) & " instead of "& to_string(c_rotate_6) severity error;
    assert now-start > duration report "anticlockwise: rotation-speed is not decreasing: was "& to_string(duration) & ", but now "& to_string(now-start) severity error;
    duration := now - start;
    start := now;
    write(output, ht & "7th anticlockwise rotation checked" & lf);

    wait on hex_n;
    assert hex_n = c_rotate_5 report "anticlockwise: 8th rotation-state wrong: "& to_string(hex_n) & " instead of "& to_string(c_rotate_5) severity error;
    assert now-start > duration report "anticlockwise: rotation-speed is not decreasing: was "& to_string(duration) & ", but now "& to_string(now-start) severity error;
    duration := now - start;
    start := now;
    write(output, ht & "8th anticlockwise rotation checked" & lf);

    wait on hex_n;
    assert hex_n = c_rotate_4 report "anticlockwise: 9th rotation-state wrong: "& to_string(hex_n) & " instead of "& to_string(c_rotate_4) severity error;
    assert now-start > duration report "anticlockwise: rotation-speed is not decreasing: was "& to_string(duration) & ", but now "& to_string(now-start) severity error;
    duration := now - start;
    start := now;
    write(output, ht & "9th anticlockwise rotation checked" & lf);
      
    wait on hex_n;
    assert hex_n = c_rotate_3 report "anticlockwise: 10th rotation-state wrong: "& to_string(hex_n) & " instead of "& to_string(c_rotate_3) severity error;
    assert now-start > duration report "anticlockwise: rotation-speed is not decreasing: was "& to_string(duration) & ", but now "& to_string(now-start) severity error;
    write(output, ht & "10th anticlockwise rotation checked" & lf);
      
    write(output, "check random value" & lf);
    -- it's possible to calculate the correct "random-value", because
    -- the duration is known.
    -- easy approach: check if random-value is between 1 and 6:
    wait on hex_n;
    assert (hex_n = c_cipher_1 or 
            hex_n = c_cipher_2 or
            hex_n = c_cipher_3 or
            hex_n = c_cipher_4 or
            hex_n = c_cipher_5 or
            hex_n = c_cipher_6 ) report "no valid random-number between 1 and 6: "& to_string(hex_n) severity error;
      
		wait for 1 us;
		
    report "### all tested ###" severity note;
    enable <= false;
    wait;
  end process p_check_leds;

end architecture stimulate_and_monitor;

