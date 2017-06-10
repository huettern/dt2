library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity tb_hex_count is

end entity tb_hex_count;

architecture struct of tb_hex_count is
	
	component hex_count
		port(
			rst_n : in  std_ulogic;
			clk   : in  std_ulogic;
			btn_n : in  std_ulogic;
			hex_n : out std_ulogic_vector(6 downto 0)
		);
	end component hex_count;
	
	component stim_hex_count
		port(
			rst_n : out std_ulogic;
			clk   : out std_ulogic;
			btn_n : out std_ulogic;
			hex_n : in std_ulogic_vector(6 downto 0)
		);
	end component stim_hex_count;
	
	signal rst_n : std_ulogic;
	signal clk : std_ulogic;
	signal btn_n : std_ulogic;
	signal hex_n : std_ulogic_vector(6 downto 0);
	
	--for comp1_hex_count : hex_count use entity work.hex_count;
	--for comp1_stim_hex_count : stim_hex_count use entity work.stim_hex_count;
	
begin
	
	comp1_hex_count : component hex_count
		port map(
			rst_n => rst_n,
			clk   => clk,
			btn_n => btn_n,
			hex_n => hex_n
		);
		
	comp1_stim_hex_count : component stim_hex_count
		port map(
			rst_n => rst_n,
			clk   => clk,
			btn_n => btn_n,
			hex_n => hex_n
		);
		
end architecture struct;
