library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity top is
	port (
		rst_n : in std_ulogic;
		btn_n : in std_ulogic;
		clk : in std_ulogic;
		hex_n : out std_ulogic_vector (6 downto 0)
	);
end entity top;

architecture structural of top is
	component control
		port(
			rst_n : in  std_ulogic;
			btn_n : in  std_ulogic;
			clk   : in  std_ulogic;
			value : out std_ulogic_vector
		);
	end component control;
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
	
	signal counter : std_ulogic_vector(3 downto 0);
begin
	ctl_inst_1 : control
		port map(
			rst_n => rst_n,
			btn_n => btn_n,
			clk   => clk,
			value => counter
		);
	bin2hex_inst_1 : bin2hex
		port map(
			data => counter,
			a    => hex_n(0),
			b    => hex_n(1),
			c    => hex_n(2),
			d    => hex_n(3),
			e    => hex_n(4),
			f    => hex_n(5),
			g    => hex_n(6)
		);
end architecture structural;
