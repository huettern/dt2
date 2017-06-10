-- Name: Huetter
-- Vorname: Noah

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity data_gen is
	generic(g_end_value : integer := 10);
	port (
		rst        : in  std_ulogic;
		clk        : in  std_ulogic;
		data       : out unsigned(7 downto 0);
		data_ready : out std_ulogic;
		peak_reset : out std_ulogic
	);
end entity data_gen;

architecture rtl of data_gen is
  type t_state_type is (idle, inc, up, stop, down); 
  signal c_state : t_state_type;
  signal n_state : t_state_type;
  signal n       : integer range 0 to 3;  
begin

  p_currentstate : process(rst, clk)
  begin
    if rst = '1' then
      c_state <= idle;
    elsif rising_edge(clk) then
      c_state <= n_state;
    end if;
  end process p_currentstate;

  p_gen_data : process (rst, clk)
  begin
    if rst = '1' then
    	n <= 0;
    	data <= (others => '0');
  	elsif rising_edge(clk) then
	  	case c_state is 
	  		when idle => 	n <= 0;
	  						data <= (others => '0');
	  		when inc => 	n <= n + 1;
	  		when up =>		if data /= n * g_end_value then data <= data + 1; end if;
	  		when stop =>
	  			null;
	  		when down =>	if data /= 0 then data <= data - 1; end if;
	  	end case;    	
    end if;
  end process p_gen_data;
  	
  p_nextstate : process (c_state, data, n)
  begin
  	case c_state is 
  		when idle => 	n_state <= 	inc;
  		when inc => 	n_state <= 	up;
  		when up => 		if data = n * g_end_value	then n_state <= 	down; 	end if;
  		when stop =>	n_state <= 	stop;
  		when down => 	if data = 0 and n = 3 		then n_state <= 	stop;
  						elsif data = 0 				then n_state <= 	inc; 	end if;
  	end case;

  end process p_nextstate;

  p_output : process(all)
  begin
    case c_state is
      when idle => data_ready <= '0';
                   peak_reset <= '0';
      when inc  => data_ready <= '0';
                   peak_reset <= '0';
      when up   => data_ready <= '1';
                   peak_reset <= '0';
      when stop => data_ready <= '0';
                   peak_reset <= '1';
      when down => data_ready <= '1';
                   peak_reset <= '0';
    end case;
  end process p_output;

end architecture rtl;