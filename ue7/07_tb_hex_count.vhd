library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity tb is
end entity tb;

architecture struct of tb is
	component ctrl
		port(
			rst_n : in  std_ulogic;
			clk   : in  std_ulogic;
			btn_n : in  std_ulogic;
			value : out std_ulogic_vector(3 downto 0)
		);
	end component ctrl;
	component verify_u07
		port(
			rst_n : out std_ulogic;
			clk   : out std_ulogic;
			btn_n : out std_ulogic
		);
	end component verify_u07;
	signal rst_n : std_ulogic;
	signal clk : std_ulogic;
	signal btn_n : std_ulogic;
	signal value : std_ulogic_vector(3 downto 0);
begin
	c_ctrl : component ctrl
		port map(
			rst_n => rst_n,
			clk   => clk,
			btn_n => btn_n,
			value => value
		);
	c_ver : component verify_u07
		port map(
			rst_n => rst_n,
			clk   => clk,
			btn_n => btn_n
		);
end architecture struct;
