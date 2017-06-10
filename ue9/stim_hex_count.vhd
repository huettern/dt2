library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
library std;
use std.textio.all;

entity stim_hex_count is
	port (
		rst_n : out std_ulogic;
		clk : out std_ulogic;
		btn_n : out std_ulogic;
		hex_n : in std_ulogic_vector(6 downto 0)	
	);
end entity stim_hex_count;

architecture rtl of stim_hex_count is
	signal enable : boolean := true;
	
begin
	
  	-- System reset:
  	rst_n <= transport '0', '1' after 10 ns;
  
	
	p_clock_50MHz : PROCESS
	BEGIN
		while enable loop
			clk <= '0';
			WAIT FOR 5 ns;
			clk <= '1';
			WAIT FOR 10 ns;
			clk <= '0';
			WAIT FOR 5 ns;
		end loop;
		wait;
	END PROCESS p_clock_50MHz;
	
	
	btn : process
	begin
	    btn_n <= '1';  -- initial value
	    wait for 5*20 ns;
	    btn_n <= '0';
	    wait for 16*200 ms;  -- see specification : max frequency is 10 Hz, so we use 5 Hz
	    btn_n <= '1';
	    wait for 10*20 ns;
	    wait;
	end process btn;
	
	
  p_monitor_results : process
	  begin
	    wait until rst_n = '1';  -- not reset anymore
	    assert hex_n = "1000000" report "representation of 0 wrong: " & to_string(hex_n) & " instead of 1000000" severity error;
	    wait on hex_n;
	    assert hex_n = "1111001" report "representation of 1 wrong: " & to_string(hex_n) & " instead of 1111001" severity error;  
	    wait on hex_n;
	    assert hex_n = "0100100" report "representation of 2 wrong: " & to_string(hex_n) & " instead of 0100100" severity error;
	    wait on hex_n;
	    assert hex_n = "0110000" report "representation of 3 wrong: " & to_string(hex_n) & " instead of 0110000" severity error; 
	    wait on hex_n;
	    assert hex_n = "0011001" report "representation of 4 wrong: " & to_string(hex_n) & " instead of 0011001" severity error; 
	    wait on hex_n;
	    assert hex_n = "0010010" report "representation of 5 wrong: " & to_string(hex_n) & " instead of 0010010" severity error; 
	    wait on hex_n;
	    assert hex_n = "0000010" report "representation of 6 wrong: " & to_string(hex_n) & " instead of 0000010" severity error; 
	    wait on hex_n;
	    assert hex_n = "1111000" report "representation of 7 wrong: " & to_string(hex_n) & " instead of 1111000" severity error; 
	    wait on hex_n;
	    assert hex_n = "0000000" report "representation of 8 wrong: " & to_string(hex_n) & " instead of 0000000" severity error; 
	    wait on hex_n;
	    assert hex_n = "0010000" report "representation of 9 wrong: " & to_string(hex_n) & " instead of 0010000" severity error; 
	    wait on hex_n;
	    assert hex_n = "0001000" report "representation of a wrong: " & to_string(hex_n) & " instead of 0001000" severity error; 
	    wait on hex_n; 
	    assert hex_n = "0000011" report "representation of b wrong: " & to_string(hex_n) & " instead of 0000011" severity error; 
	    wait on hex_n;
	    assert hex_n = "1000110" report "representation of c wrong: " & to_string(hex_n) & " instead of 1000110" severity error; 
	    wait on hex_n;
	    assert hex_n = "0100001" report "representation of d wrong: " & to_string(hex_n) & " instead of 0100001" severity error; 
	    wait on hex_n;
	    assert hex_n = "0000110" report "representation of e wrong: " & to_string(hex_n) & " instead of 0000110" severity error; 
	    wait on hex_n;
	    assert hex_n = "0001110" report "representation of f wrong: " & to_string(hex_n) & " instead of 0001110" severity error; 
	
	    --report "All tested" severity note;
	    write(output, "all tested" & lf);
	    wait for 100 ns;
	    enable <= false;
	    
	    wait;   -- process "p_monitor_results" only once
  end process p_monitor_results;

	p_info : process(rst_n, hex_n)
    	variable v_nr : integer := 0;
  	begin
    	-- Don't check at simulation start (0 ns)
    	if now /= 0 ns then
      		if rising_edge(rst_n) then
        		write(output, "verification of number 0..." & lf);
        		v_nr := v_nr+1;
      		else 
        		write(output, "verification of number "& to_string(v_nr) & "..." & lf);
        		v_nr := v_nr+1;
     		end if;
    	end if;
	end process p_info;	
	
	p_speed_up : process
		alias a_slow_down_cnt is <<signal .tb_hex_count.comp1_hex_count.i0_ctrl.slow_down_cnt : unsigned(22 downto 0)>>;
    -- alias a_slow_down_cnt is <<signal .tb_hex_count_u09.duv.i0_ctrl.slow_down_cnt : unsigned(22 downto 0)>>;
	  begin
	    for i in 0 to 15 loop 
	      wait until a_slow_down_cnt = 23X"F";
	      wait for 20 ns;
	      a_slow_down_cnt <= force 23X"7FFFFF";
	      wait for 20 ns;
	      a_slow_down_cnt <= release;
	    end loop;
	    wait for 20 ns;
	   -- enable <= false;
  end process p_speed_up;


end architecture rtl;
