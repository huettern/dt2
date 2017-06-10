library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity tb is
end entity tb;

architecture struct of tb is
	component hex_count
		port(
			rst_n : in  std_ulogic;
			clk   : in  std_ulogic;
			btn_n : in  std_ulogic;
			hex_n : out std_ulogic_vector(6 downto 0)
		);
	end component hex_count;
	
	component verify_u07
		port(
			rst_n : out std_ulogic;
			clk   : out std_ulogic;
			btn_n : out std_ulogic;
			hex_n : in  std_ulogic_vector(6 downto 0)
		);
	end component verify_u07;
	
	signal rst_n : std_ulogic;
	signal clk : std_ulogic;
	signal btn_n : std_ulogic;
	signal hex_n : std_ulogic_vector(6 downto 0);
begin
	c_cnt : component hex_count
		port map(
			rst_n => rst_n,
			clk   => clk,
			btn_n => btn_n,
			hex_n => hex_n
		);
	c_ver : component verify_u07
		port map(
			rst_n => rst_n,
			clk   => clk,
			btn_n => btn_n,
			hex_n => hex_n
		);
end architecture struct;
