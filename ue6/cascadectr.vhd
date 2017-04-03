library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

library work;
use work.count_pkg.all;

entity cascadectr is
	port (
		reset : in std_ulogic;
		clk : in std_ulogic;
		values : out nat_ar
	);
end entity cascadectr;

architecture rtl of cascadectr is
	component counter
		generic(
			g_start : natural := 5;
			g_end   : natural := 10
		);
		port(
			clk    : in  std_ulogic;
			reset  : in  std_ulogic;
			enable : in  std_ulogic;
			carry  : out std_ulogic;
			value  : out natural
		);
	end component counter;
	signal carry1 : std_ulogic;
begin
	sec_ctr : counter
		generic map(
			g_start => c_start_values(0),
			g_end   => c_end_values(0)
		)
		port map(
			clk    => clk,
			reset  => reset,
			enable => '1',
			carry  => carry1,
			value  => values(0)
		);
	
	min_ctr : counter
		generic map(
			g_start => c_start_values(1),
			g_end   => c_end_values(1)
		)
		port map(
			clk    => clk,
			reset  => reset,
			enable => carry1,
			carry  => OPEN,
			value  => values(1)
		);
end architecture rtl;