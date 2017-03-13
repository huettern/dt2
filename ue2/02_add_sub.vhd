-----------------------------------------------------
-- Musterloesung dt2 Uebung 2
-----------------------------------------------------
-- File    : 02_add_sub.vhd
-- Library : work
-- Author  : stefan.brantschen@fhnw.ch
-- Created : 25.01.2013
-- Company : Institute of Microelectronics (IME) FHNW
-- Copyright(C) IME
-----------------------------------------------------
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity add_sub is
  port(x        : in  unsigned(7 downto 0);
       y        : in  unsigned(7 downto 0);
       mode     : in  std_ulogic;
       result   : out unsigned(7 downto 0);
       ov_un_fl : out std_ulogic);
end entity add_sub;

architecture logic of add_sub is
  signal tmp : unsigned(8 downto 0);  -- 1 bigger to store over-/underflow
begin

  tmp <= resize(x,tmp'length) + resize(y,tmp'length) when mode = '0' else
         resize(x,tmp'length) - resize(y,tmp'length);
         
  result <= tmp(7 downto 0);
  ov_un_fl <= tmp(8);
  
end architecture logic;

-----------------------------------------------------
-- alternative architecture using a process
-----------------------------------------------------

architecture logic2 of add_sub is
  signal tmp : unsigned(8 downto 0);  -- 1 bigger to store over-/underflow
begin

  p_add_sub : process(all)
  begin
    if mode = '0' then
      tmp <= resize(x,tmp'length) + resize(y,tmp'length);
    else
      tmp <= resize(x,tmp'length) - resize(y,tmp'length);
    end if;
  end process p_add_sub;
         
  result <= tmp(7 downto 0);
  ov_un_fl <= tmp(8);
  
end architecture logic2;


