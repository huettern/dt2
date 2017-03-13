
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity add_sub_my is
	port (
		x, y : in unsigned(7 downto 0);
		mode : in std_ulogic;
		result : out unsigned(7 downto 0);
		ov_un_fl : out std_ulogic
	);
end entity add_sub_my;

architecture arch of add_sub_my is
	signal tmp : unsigned(8 downto 0);
begin
	
	tmp <= resize(x, tmp'length) + resize(y, tmp'length) when mode = '0' else
		   resize(x, tmp'length) - resize(y, tmp'length);
		   
	result <= tmp(7 downto 0);
	ov_un_fl <= tmp(8);	   
	
end architecture arch;

