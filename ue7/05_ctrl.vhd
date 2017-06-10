-----------------------------------------------------
-- Musterloesung dt2 Uebung 5
-----------------------------------------------------
-- File    : 05_ctrl.vhd
-- Library : work
-- Author  : stefan.brantschen@fhnw.ch
-- Created : 11.02.2013
-- Company : Institute of Microelectronics (IME) FHNW
-- Copyright(C) IME
-----------------------------------------------------
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity ctrl is
  port(rst_n : in  std_ulogic;
       clk   : in  std_ulogic;
       btn_n : in  std_ulogic;
       value : out std_ulogic_vector (3 downto 0));
end entity ctrl ;


architecture rtl of ctrl is

  constant c_end_value    : natural := 2**23-1;
  signal slow_down_cnt    : unsigned(22 downto 0);  -- ~ 6 Hz
  signal enable_value_cnt : std_ulogic;
  signal value_cnt        : unsigned(3 downto 0);
  
begin

  -- to see the different values, "value_cnt" shall run 
  -- at a frequency less than 10hz. otherwise the human
  -- eye will see all segments lighted
  p_slow_down : process (clk, rst_n)
    begin 
      if rst_n = '0' then
        slow_down_cnt <= (others => '0');

      elsif rising_edge(clk) then
        if btn_n = '0' then                    -- enable counting
          slow_down_cnt <= slow_down_cnt + 1;  -- counting up with wrap-around
        end if;   
        
      end if;
  end process p_slow_down;

  enable_value_cnt <= '1' when slow_down_cnt = c_end_value else '0';

  ------------------------------------------------------------------

  -- stimulate all possible values: count 0 to 15
  p_values : process (clk, rst_n)
    begin 
      if rst_n = '0' then
        value_cnt <= (others => '0');

      elsif rising_edge(clk) then
        if enable_value_cnt = '1' then   -- enable counting
          value_cnt <= value_cnt + 1;    -- counting up with wrap-around
        end if;   
        
      end if;
  end process p_values;

  value <= std_ulogic_vector(value_cnt);
  
end architecture rtl;

