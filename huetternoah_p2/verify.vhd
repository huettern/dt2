-- Name: huetter
-- Vorname: noah

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

library std;
use std.textio.all;

use work.tb_uart_pkg.all;

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
	signal enable : boolean := true;
	signal uart_state : t_uart_states := idle;
begin
	-----------------------------------------------------------------
	-- System reset:
	-----------------------------------------------------------------
  	rst_n <= transport '0', '1' after 10 ns;

	-----------------------------------------------------------------
	-- stimuli process for clock
	-----------------------------------------------------------------
	p_clock_125MHz : process
	-----------------------------------------------------------------
	begin
		while enable loop
			clk <= '0';
			wait for 4 ns;
			clk <= '1';
			wait for 4 ns;
		end loop;
		wait;
	end process p_clock_125MHz;

	-----------------------------------------------------------------
	-- stimuli process for data line
	-----------------------------------------------------------------
	p_stim_data : process
	-----------------------------------------------------------------
		file input_file : text open read_mode is "./stim_files/stim.txt";
		variable v_input_line : line;
		variable v_write_data : std_ulogic_vector(31 downto 0);
		variable v_write_adr : std_ulogic_vector(31 downto 0);
	begin
		wait for 200 ns;
		-- first data
		readline(input_file, v_input_line);
		hread(v_input_line, v_write_adr);
		readline(input_file, v_input_line);
		hread(v_input_line, v_write_data);
		uart_tx_word(v_write_adr, v_write_data, uart_txd, uart_state);
		-- wait for 10 clock cycles
		for i in 0 to 9 loop 
	      wait until rising_edge(clk);
	  	end loop;
		-- second data
		readline(input_file, v_input_line);
		hread(v_input_line, v_write_adr);
		readline(input_file, v_input_line);
		hread(v_input_line, v_write_data);
		uart_tx_word(v_write_adr, v_write_data, uart_txd, uart_state);
		-- wait for 10 clock cycles
		for i in 0 to 9 loop 
	      wait until rising_edge(clk);
	  	end loop;
		-- third data
		readline(input_file, v_input_line);
		hread(v_input_line, v_write_adr);
		readline(input_file, v_input_line);
		hread(v_input_line, v_write_data);
		uart_tx_word(v_write_adr, v_write_data, uart_txd, uart_state);
		-- wait for 10 clock cycles
		for i in 0 to 9 loop 
	      wait until rising_edge(clk);
	  	end loop;
        write(output, "End of stim" & lf);
        enable  <= false;
		wait;
	end process p_stim_data;
	
	-----------------------------------------------------------------
	-- monitoring process
	-----------------------------------------------------------------
	p_mon : process
	-----------------------------------------------------------------
	begin
		wait until (reg_wr = '1' and rising_edge(clk));
		-- assert first address word
		assert reg_addr = 32X"00000000" 
			report "Failed first address word. Was: " & to_hex_string(reg_addr) & " should be: " & to_hex_string(32X"00000000") 
			severity error;
		-- assert first data word
		assert reg_data = 32X"11112222" 
			report "Failed first data word. Was: " & to_hex_string(reg_data) & " should be: " & to_hex_string(32X"11112222") 
			severity error;
		wait;
	end process p_mon;

end architecture stim_and_mon;
