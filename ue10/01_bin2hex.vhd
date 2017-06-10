-----------------------------------------------------
-- Musterloesung dt2 Uebung 1
-----------------------------------------------------
-- File    : 01_bin2hex.vhd
-- Library : work
-- Author  : stefan.brantschen@fhnw.ch
-- Created : 16.02.2015
-- Company : Institute of Microelectronics (IME) FHNW
-- Copyright(C) IME
-----------------------------------------------------
library ieee;
use ieee.std_logic_1164.all;

entity bin2hex is
  port(
    data : in std_ulogic_vector(3 downto 0);
    a : out std_ulogic;
    b : out std_ulogic;
    c : out std_ulogic;
    d : out std_ulogic;
    e : out std_ulogic;
    f : out std_ulogic;
    g : out std_ulogic
  );
end entity bin2hex;

architecture logic of bin2hex is
  signal digit : std_ulogic_vector(6 downto 0);
begin
  -----------------------------------------------------
  -- assign "digit" using conditional signal-assignment:
  digit <= "0000001" when data = "0000" else
           "1001111" when data = "0001" else
           "0010010" when data = "0010" else
           "0000110" when data = "0011" else
           "1001100" when data = "0100" else
           "0100100" when data = "0101" else
           "0100000" when data = "0110" else
           "0001111" when data = "0111" else
           "0000000" when data = "1000" else
           "0000100" when data = "1001" else
           "0001000" when data = "1010" else   -- a
           "1100000" when data = "1011" else   -- b
           "0110001" when data = "1100" else   -- c
           "1000010" when data = "1101" else   -- d
           "0110000" when data = "1110" else   -- e
           "0111000" when data = "1111" else   -- f
           "1111111";  -- invalid
           
  -----------------------------------------------------
   
  a <= digit(6);
  b <= digit(5);
  c <= digit(4);
  d <= digit(3);
  e <= digit(2);
  f <= digit(1);
  g <= digit(0);   

end architecture logic;
