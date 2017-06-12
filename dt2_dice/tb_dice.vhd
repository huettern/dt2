-----------------------------------------------------
-- Project DICE
-----------------------------------------------------
-- File    : tb_dice.vhd
-- Library : work
-- Author  : stefan.brantschen@fhnw.ch
-- Created : 28.03.2012
-- Company : Institute of Microelectronics (IME) FHNW
-- Copyright(C) IME
-----------------------------------------------------
library ieee;
use ieee.std_logic_1164.all;

entity tb_dice is
end entity tb_dice ;

architecture struct of tb_dice is

  signal clock   : std_ulogic;
  signal hex_n   : std_ulogic_vector(6 downto 0);
  signal reset_n : std_ulogic;
  signal start_n : std_ulogic;

  -- component declarations
  component dice_top
  port (
    clock   : in  std_ulogic ;
    reset_n : in  std_ulogic ;
    start_n : in  std_ulogic ;
    hex_n   : out std_ulogic_vector (6 downto 0)
  );
  end component;
  component verify
  port (
    hex_n   : in  std_ulogic_vector (6 downto 0);
    clock   : out std_ulogic ;
    reset_n : out std_ulogic ;
    start_n : out std_ulogic 
  );
  end component;

  for all : dice_top use entity work.dice_top(struct);
  for all : verify   use entity work.verify(stimulate_and_monitor);

begin

   duv : dice_top
      port map (
         clock   => clock,
         reset_n => reset_n,
         start_n => start_n,
         hex_n   => hex_n
      );
			
   verify_inst : verify
      port map (
         hex_n   => hex_n,
         clock   => clock,
         reset_n => reset_n,
         start_n => start_n
      );

end architecture struct;
