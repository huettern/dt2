library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity control is
	port (
		rst_n : in std_ulogic;
		btn_n : in std_ulogic;
		clk : in std_ulogic;
		value : out std_ulogic_vector
	);
end entity control;

architecture rtl of control is
	
begin

end architecture rtl;
