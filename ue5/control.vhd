library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity control is
	port (
		rst_n : in std_ulogic;
		btn_n : in std_ulogic;
		clk : in std_ulogic;
		value : out std_ulogic_vector(3 downto 0)
	);
end entity control;

architecture rtl of control is
	constant c_end_value : natural := 10;
  	signal div : natural range 0 to c_end_value;  -- ~ 6 Hz
	signal ctr : natural range 0 to 15;
begin
	p_div : process (clk, rst_n) is
	begin
		if rst_n = '0' then
			div <= 0;
			ctr <= 0;
		elsif rising_edge( clk ) then
			if div = c_end_value then
				div <= 0;
				if btn_n = '0' then
					if ctr = 15 then
						ctr <= 0;
					else 
						ctr <= ctr + 1;
					end if;
				end if;
			else
				div <= div + 1;
			end if;
		end if;
	end process p_div;
	value <= std_ulogic_vector(to_unsigned(ctr,value'length));
end architecture rtl;
