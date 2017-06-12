-- Name: huetter
-- Vorname: noah

library ieee;
use ieee.std_logic_1164.all;

package tb_uart_pkg is

  type t_uart_states is (idle, startbit, databits, stopbit);

  procedure uart_tx_byte(constant c_tx_data : in  std_ulogic_vector(7 downto 0);
                         signal   txd       : out std_ulogic;
                         signal   txd_state : out t_uart_states);

  procedure uart_tx_word(constant c_addr    : in  std_ulogic_vector(31 downto 0);
                         constant c_data    : in  std_ulogic_vector(31 downto 0);
                         signal   txd       : out std_ulogic;
                         signal   txd_state : out t_uart_states);                         
	
end package tb_uart_pkg;

package body tb_uart_pkg is

  procedure uart_tx_byte(constant c_tx_data : in  std_ulogic_vector(7 downto 0);
                         signal   txd       : out std_ulogic;
                         signal   txd_state : out t_uart_states) is 

    constant c_tx_bitrate : natural := 115200;
    constant c_baud_cycle : time := 1 sec/c_tx_bitrate;
  begin
    -- start bit
    txd       <= '0';
    txd_state <= startbit;
    wait for c_baud_cycle;
    -- data bits
    for i in 0 to c_tx_data'high loop  -- data bits (lsb first)
      txd       <= c_tx_data(i);
      txd_state <= databits;
      wait for c_baud_cycle;
    end loop;
    -- stop bits
    txd_state <= stopbit;
    txd <= '1';
    wait for c_baud_cycle;
    -- tx done
    txd       <= '1';
    txd_state <= idle;
    wait for c_baud_cycle;
  end procedure uart_tx_byte;

  procedure uart_tx_word(constant c_addr    : in  std_ulogic_vector(31 downto 0);
                         constant c_data    : in  std_ulogic_vector(31 downto 0);
                         signal   txd       : out std_ulogic;
                         signal   txd_state : out t_uart_states) is
  begin
  	
    for i in 0 to 3 loop
      uart_tx_byte(c_addr(((3-i)*8)+7 downto (3-i)*8), txd, txd_state);
  	end loop;
    for i in 0 to 3 loop
      uart_tx_byte(c_data(((3-i)*8)+7 downto (3-i)*8), txd, txd_state);
  	end loop;
  end procedure uart_tx_word;                      
	
end package body tb_uart_pkg;
