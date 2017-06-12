-- Name: huetter
-- Vorname: noah

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity tb_reg_if is
	
end entity tb_reg_if;

architecture struct of tb_reg_if is
	component reg_if
		port(
			rst_n    : in  std_ulogic;
			clk      : in  std_ulogic;
			uart_rxd : in  std_ulogic;
			reg_addr : out std_ulogic_vector(31 downto 0);
			reg_data : out std_ulogic_vector(31 downto 0);
			reg_wr   : out std_ulogic
		);
	end component reg_if;
	
	component verify
		port(
			reg_addr : in  std_ulogic_vector(31 downto 0);
			reg_data : in  std_ulogic_vector(31 downto 0);
			reg_wr   : in  std_ulogic;
			rst_n    : out std_ulogic;
			clk      : out std_ulogic;
			uart_txd : out std_ulogic
		);
	end component verify;
	
	signal rst_n    :   std_ulogic;
	signal clk      :   std_ulogic;
	signal uart_data :   std_ulogic;
	signal reg_addr :  std_ulogic_vector(31 downto 0);
	signal reg_data :  std_ulogic_vector(31 downto 0);
	signal reg_wr   :  std_ulogic;
	
begin
	comp_verify : component verify
		port map(
			reg_addr => reg_addr,
			reg_data => reg_data,
			reg_wr   => reg_wr,
			rst_n    => rst_n,
			clk      => clk,
			uart_txd => uart_data
		);
	
	comp_duv : component reg_if
		port map(
			rst_n    => rst_n,
			clk      => clk,
			uart_rxd => uart_data,
			reg_addr => reg_addr,
			reg_data => reg_data,
			reg_wr   => reg_wr
		);
end architecture struct;
