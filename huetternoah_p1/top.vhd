-- Name: Huetter
-- Vorname: Noah

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity top is
	port (
		rst : in std_ulogic;
		clk : in std_ulogic;
		peak : out unsigned(7 downto 0)
	);
end entity top;

architecture structural of top is
	component data_gen
		generic(g_end_value : integer := 10);
		port(
			rst        : in  std_ulogic;
			clk        : in  std_ulogic;
			data       : out unsigned(7 downto 0);
			data_ready : out std_ulogic;
			peak_reset : out std_ulogic
		);
	end component data_gen;
	component peak_detect
		port(
			rst        : in  std_ulogic;
			clk        : in  std_ulogic;
			data_in    : in  unsigned(7 downto 0);
			data_valid : in  std_ulogic;
			peak_rst   : in  std_ulogic;
			peak       : out unsigned(7 downto 0)
		);
	end component peak_detect;
	
	signal data_in : unsigned(7 downto 0);
	signal data_valid : std_ulogic;
	signal peak_rst : std_ulogic;
begin
	data_gen_1 : data_gen
		generic map(
			g_end_value => 25
		)
		port map(
			rst        => rst,
			clk        => clk,
			data       => data_in,
			data_ready => data_valid,
			peak_reset => peak_rst
		);
		
	peak_detect_1 : component peak_detect
		port map(
			rst        => rst,
			clk        => clk,
			data_in    => data_in,
			data_valid => data_valid,
			peak_rst   => peak_rst,
			peak       => peak
		);
	
end architecture structural;

