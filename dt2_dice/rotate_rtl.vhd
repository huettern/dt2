-----------------------------------------------------
-- Project DICE
-----------------------------------------------------
-- File    : rotate_rtl.vhd
-- Library : work
-- Author  : stefan.brantschen@fhnw.ch
-- Created : 28.03.2012
-- Company : Institute of Microelectronics (IME) FHNW
-- Copyright(C) IME
-----------------------------------------------------
-- When state indicates fast-animation, segments
-- rotate clockwise, when indicating slow-animation,
-- rotate anti-clockwise.
-----------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;

entity rotate is
  port( 
    ani_en      : in  std_ulogic;
    clock       : in  std_ulogic;
    reset_n     : in  std_ulogic;
    state       : in  std_ulogic_vector (1 downto 0);
    ani_pattern : out std_ulogic_vector (6 downto 0)
  );
end entity rotate ;

architecture rtl of rotate is
  signal pattern: std_ulogic_vector(6 downto 0);
begin
   
  p_rot_reg: process(reset_n, clock)
  begin
    if reset_n = '0' then
      pattern <= "1111110";  -- segment d0 lighten
    elsif rising_edge(clock) then
      if ani_en = '1' then
        if state = "01" then  -- button pressed -> rotate clockwise
          pattern(6) <= '1';  -- d6=pattern(6) remains dark (not used for rotation)
          pattern(5) <= pattern(4);
          pattern(4) <= pattern(3);
          pattern(3) <= pattern(2);
          pattern(2) <= pattern(1);
          pattern(1) <= pattern(0);
          pattern(0) <= pattern(5);
        elsif state = "10" then  -- button not pressed -> rotate counterclockwise
--         else  -- button not pressed -> rotate counterclockwise
          pattern(6) <= '1';     -- d6=pattern(6) remains dark (not used for rotation)
          pattern(5) <= pattern(0);
          pattern(4) <= pattern(5);
          pattern(3) <= pattern(4);
          pattern(2) <= pattern(3);
          pattern(1) <= pattern(2);
          pattern(0) <= pattern(1);
        end if;
      end if;
    end if;
  end process p_rot_reg;
	
  -- output assignments
  ani_pattern <= pattern;            

end architecture rtl;

