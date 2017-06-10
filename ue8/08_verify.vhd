-----------------------------------------------------
-- Musterloesung dt2 Uebung 7
-----------------------------------------------------
-- File    : 07_verify.vhd
-- Library : work
-- Author  : stefan.brantschen@fhnw.ch
-- Created : 12.02.2013
-- Company : Institute of Microelectronics (IME) FHNW
-- Copyright(C) IME
-----------------------------------------------------
library ieee;
use ieee.std_logic_1164.all;
use std.textio.all;

entity verify_u07 is
  port(
    rst_n : out std_ulogic;
    clk   : out std_ulogic;
    btn_n : out std_ulogic;
    hex_n : in  std_ulogic_vector(6 downto 0)
  );
end entity verify_u07;

architecture stimuli_behaviour of verify_u07 is
	constant c_cycle_time : time := 20 ns;
	signal enable : boolean := true;
begin

  -- System reset:
  rst_n <= transport '0', '1' after 10 ns;
  
  
  -- 50MHz
  p_system_clk : process
  begin
  	while enable loop
	    clk <= '0';
	    wait for c_cycle_time/2;
	    clk <= '1';
	    wait for c_cycle_time/2;
	end loop;
	wait;
  end process p_system_clk;
  
  
  -- Test-cases: 
  --   - wrap-around for both "count"
  --   - all values for "bin2hex"
  p_button : process
  begin
    btn_n <= '1';  -- initial value
    wait for 5*c_cycle_time;
    btn_n <= '0';
    wait for 16*200 ms;  -- see specification : max frequency is 10 Hz, so we use 5 Hz
    btn_n <= '1';
    wait for 10*c_cycle_time;
    wait;
  end process p_button;

-- monitor
p_monitor_results : process
begin
	wait until rst_n ='1';
	assert hex_n = "1000000" report "representation of 0 wrong: " & to_string(hex_n) & "instead of 1000000" severity error;
	wait on hex_n;
	assert hex_n = "1111001" report "representation of 1 wrong: " & to_string(hex_n) & "instead of 1111100" severity error;
	wait on hex_n;
	assert hex_n = "0100100" report "representation of 2 wrong: " & to_string(hex_n) & "instead of 0100100" severity error;
	wait on hex_n;
	assert hex_n = "0110000" report "representation of 3 wrong: " & to_string(hex_n) & "instead of 0110000" severity error;
	wait on hex_n;
	assert hex_n = "0011001" report "representation of 4 wrong: " & to_string(hex_n) & "instead of 0011001" severity error;
	wait on hex_n;
	assert hex_n = "0010010" report "representation of 5 wrong: " & to_string(hex_n) & "instead of 0010010" severity error;
	wait on hex_n;
	assert hex_n = "0000011" report "representation of 6 wrong: " & to_string(hex_n) & "instead of 0000011" severity error;
	wait on hex_n;
	assert hex_n = "1111000" report "representation of 7 wrong: " & to_string(hex_n) & "instead of 1111000" severity error;
	wait on hex_n;
	assert hex_n = "0000000" report "representation of 8 wrong: " & to_string(hex_n) & "instead of 0000000" severity error;
	wait on hex_n;
	assert hex_n = "0010000" report "representation of 9 wrong: " & to_string(hex_n) & "instead of 0010000" severity error;
	wait on hex_n;
	assert hex_n = "0001000" report "representation of a wrong: " & to_string(hex_n) & "instead of 0001000" severity error;
	wait on hex_n;
	assert hex_n = "0000011" report "representation of b wrong: " & to_string(hex_n) & "instead of 0000011" severity error;
	wait on hex_n;
	assert hex_n = "1000110" report "representation of c wrong: " & to_string(hex_n) & "instead of 1000110" severity error;
	wait on hex_n;
	assert hex_n = "0100001" report "representation of d wrong: " & to_string(hex_n) & "instead of 0100001" severity error;
	wait on hex_n;
	assert hex_n = "0000110" report "representation of e wrong: " & to_string(hex_n) & "instead of 0000110" severity error;
	wait on hex_n;
	assert hex_n = "0001110" report "representation of f wrong: " & to_string(hex_n) & "instead of 0001110" severity error;
	wait on hex_n;
	
	--report "All tested" severity note;
    write(output, "all tested" & lf);
    wait for 100 ns;
    enable <= false;
    
end process p_monitor_results;

-- status messages
p_info : process(rst_n, hex_n)
    variable v_nr : integer := 0;
begin
	if now /= 0 ns then
		if rising_edge(rst_n) then
			write(output, "Verification of number 0..." & lf);
			v_nr := v_nr+1;
		else
			write(output, "Verification of number " & to_string(v_nr) & "..." & lf);	
			v_nr := v_nr+1;
		end if;
	end if;	
end process p_info;


end architecture stimuli_behaviour;
