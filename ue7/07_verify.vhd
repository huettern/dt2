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

entity verify_u07 is
  port(
    rst_n : out std_ulogic;
    clk   : out std_ulogic;
    btn_n : out std_ulogic
  );
end entity verify_u07;

architecture stimuli_behaviour of verify_u07 is
  constant c_cycle_time : time := 20 ns;
begin

  -- System reset:
  rst_n <= transport '0', '1' after 10 ns;
  
  
  -- 50MHz
  p_system_clk : process
  begin
    clk <= '0';
    wait for c_cycle_time/2;
    clk <= '1';
    wait for c_cycle_time/2;
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


end architecture stimuli_behaviour;
