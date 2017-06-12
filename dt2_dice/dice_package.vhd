-----------------------------------------------------
-- Project DICE
-----------------------------------------------------
-- File    : dice_package.vhd
-- Library : work
-- Author  : stefan.brantschen@fhnw.ch
-- Created : 28.03.2012
-- Company : Institute of Microelectronics (IME) FHNW
-- Copyright(C) IME
-----------------------------------------------------
-- Constant definitions for random ciphers
--  
-- 7-segment displays:
-- Applying a low logic level to a segment causes it to light up, and 
-- applying a high logic level turns it off
--
--    ____
-- D5| D0 |D1
--   |____|
--   | D6 |
-- D4|____|D2
--     D3      
-----------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;

package dice_package is
  --                                                             
  constant c_cipher_0 : std_ulogic_vector(6 downto 0) := "0110110";   -- reset
	         
  constant c_cipher_1 : std_ulogic_vector(6 downto 0) := "1111001";   -- 1 
                                  
  constant c_cipher_2 : std_ulogic_vector(6 downto 0) := "0100100";   -- 2

  constant c_cipher_3 : std_ulogic_vector(6 downto 0) := "0110000";   -- 3

  constant c_cipher_4 : std_ulogic_vector(6 downto 0) := "0011001";   -- 4

  constant c_cipher_5 : std_ulogic_vector(6 downto 0) := "0010010";   -- 5

  constant c_cipher_6 : std_ulogic_vector(6 downto 0) := "0000010";   -- 6
  
end package dice_package;
-------------------------------------------------------------------------------
package body dice_package is
  -- empty
end package body dice_package;
