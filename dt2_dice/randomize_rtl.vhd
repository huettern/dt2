-----------------------------------------------------
-- Project DICE
-----------------------------------------------------
-- File    : ramdomize_rtl.vhd
-- Library : work
-- Author  : stefan.brantschen@fhnw.ch
-- Created : 28.03.2012
-- Company : Institute of Microelectronics (IME) FHNW
-- Copyright(C) IME
-----------------------------------------------------
-- As long as state indicates animation (fast or slow)
-- the random-number is "calculated" by counting from
-- 1 to 6. 
-- The random-number is coded to be shown on a 7-seg-
-- display.
-----------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;
library work;
use work.dice_package.all;

entity randomize is
  port( 
     clock       : in  std_ulogic;
     reset_n     : in  std_ulogic;
     state       : in  std_ulogic_vector (1 downto 0);
     rnd_pattern : out std_ulogic_vector (6 downto 0)
  );
end entity randomize ;

architecture rtl of randomize is
  signal rnd_number : integer range 0 to 6;
begin

  -- sequential process
  p_counter_reg : process (reset_n, clock)
  begin
    if reset_n = '0' then
      rnd_number <= 0;
    elsif rising_edge (clock) then
      if state = "01" then
        if rnd_number = 6 then
          rnd_number <= 1;
        else
          rnd_number <= rnd_number + 1;
        end if;
      end if;
    end if;
  end process p_counter_reg;

  -- combinational process
  p_decode_cmb : process (rnd_number)
  begin
    case rnd_number is
      when 1      => rnd_pattern <= c_cipher_1;
      when 2      => rnd_pattern <= c_cipher_2;
      when 3      => rnd_pattern <= c_cipher_3;
      when 4      => rnd_pattern <= c_cipher_4;
      when 5      => rnd_pattern <= c_cipher_5;
      when 6      => rnd_pattern <= c_cipher_6;
      when others => rnd_pattern <= c_cipher_0;
    end case;
  end process p_decode_cmb;

end architecture rtl;

