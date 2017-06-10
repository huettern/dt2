-- Name: Huetter
-- Vorname: Noah
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity peak_detect is
	port (
		rst        : in  std_ulogic;
		clk        : in  std_ulogic;
		data_in    : in  unsigned(7 downto 0);
		data_valid : in  std_ulogic;
		peak_rst   : in  std_ulogic;
		peak       : out unsigned(7 downto 0)
	);
end entity peak_detect;

architecture rtl of peak_detect is
begin
	
	p_peak : process (rst, clk) is
	begin
		if rst = '1' then
			peak <= (others => '0');
		elsif rising_edge(clk) then
			if peak_rst = '1' then
				peak <= (others => '0');
			elsif data_valid = '1' and data_in > peak then
				peak <= data_in;
			end if;	
		end if;
	end process p_peak;
	
end architecture rtl;