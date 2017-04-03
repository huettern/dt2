library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity counter is
	generic (
		g_start : natural := 5;
		g_end : natural := 10
	);
	port (
		clk : in std_ulogic;
		reset : in std_ulogic;
		enable : in std_ulogic;
		carry : out std_ulogic;
		value : out natural
	);
end entity counter;

architecture rtl of counter is
	signal ctr_value : natural;
begin	
	p_ctr : process (clk, reset) is
	begin
		if reset = '1' then
			ctr_value <= g_start;
		elsif rising_edge(clk) then
			if enable = '1' then
				if ctr_value = g_end-1 then
					ctr_value <= ctr_value + 1;
					carry <= '1';
				elsif ctr_value = g_end then
					ctr_value <= g_start;
					carry <= '0';
				else
					ctr_value <= ctr_value + 1;
				end if;
			end if;
		end if;
	end process p_ctr;
	
	value <= ctr_value;
	
end architecture rtl;
