-- Name:
-- Vorname:

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity verify is
	port (
    reg_addr : in  std_ulogic_vector (31 downto 0);
    reg_data : in  std_ulogic_vector (31 downto 0);
    reg_wr   : in  std_ulogic;
    rst_n    : out std_ulogic;
    clk      : out std_ulogic;
    uart_txd : out std_ulogic
	);
end entity verify;

architecture stim_and_mon of verify is

begin

end architecture stim_and_mon;
