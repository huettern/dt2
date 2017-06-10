-----------------------------------------------------
-- Musterloesung dt2 Uebung 5
-----------------------------------------------------
-- File    : 05_hex_count.vhd
-- Library : work
-- Author  : stefan.brantschen@fhnw.ch
-- Created : 11.02.2013
-- Company : Institute of Microelectronics (IME) FHNW
-- Copyright(C) IME
-----------------------------------------------------
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity hex_count is
	port (
		rst_n : in  std_ulogic;
		clk   : in  std_ulogic;
		btn_n : in  std_ulogic;
		hex_n : out std_ulogic_vector(6 downto 0)
	);
end entity hex_count;

architecture struct of hex_count is
	


	-- Component declarations
	component bin2hex
		port(
			data : in  std_ulogic_vector(3 downto 0);
			a    : out std_ulogic;
			b    : out std_ulogic;
			c    : out std_ulogic;
			d    : out std_ulogic;
			e    : out std_ulogic;
			f    : out std_ulogic;
			g    : out std_ulogic
		);
	end component bin2hex;

	component ctrl
		port(
			rst_n : in  std_ulogic;
			clk   : in  std_ulogic;
			btn_n : in  std_ulogic;
			value : out std_ulogic_vector(3 downto 0)
		);
	end component ctrl;  

  -- Internal signal declarations
  signal value : std_ulogic_vector(3 downto 0);

  -- Optional embedded configurations
  for i0_ctrl : ctrl use entity work.ctrl(rtl);
  for i0_bin2hex : bin2hex use entity work.bin2hex(logic);

begin



 	i0_ctrl :component ctrl
 		port map(
 			rst_n => rst_n,
 			clk   => clk,
 			btn_n => btn_n,
 			value => value
 		);            

	i0_bin2hex : component bin2hex
		port map(
			data => value,
			a    => hex_n(0),
			b    => hex_n(1),
			c    => hex_n(2),
			d    => hex_n(3),
			e    => hex_n(4),
			f    => hex_n(5),
			g    => hex_n(6)
		);

end architecture struct;
