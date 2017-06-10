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
	
  	signal hex_char       : character;
	procedure vec2char 
		( signal vec : in std_ulogic_vector(6 downto 0);
		  signal char : out character )
	is	
	begin
		case vec is
			when "1000000" => char <= '0';
			when "1111001" => char <= '1';
			when "0100100" => char <= '2';
			when "0110000" => char <= '3';
			when "0011001" => char <= '4';
			when "0010010" => char <= '5';
			when "0000010" => char <= '6';
			when "1111000" => char <= '7';
			when "0000000" => char <= '8';
			when "0010000" => char <= '9';
			when "0001000" => char <= 'a';
			when "0000011" => char <= 'b';
			when "1000110" => char <= 'c';
			when "0100001" => char <= 'd';
			when "0000110" => char <= 'e';
			when "0001110" => char <= 'f';
			when others => char  <= '?';
		end case;
		
	end procedure vec2char;
	
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
	
	
  p_convert_results : process(hex_n)
  begin
    vec2char(hex_n, hex_char);  -- call of procedure "vec2char"
end process p_convert_results;

  p_monitor_results : process
	  begin
	    wait until rst_n = '1';  -- not reset anymore
		assert hex_char = '0' report "representation of 0 wrong, shown is " & hex_char severity error;
    wait on hex_char;
		assert hex_char = '1' report "representation of 1 wrong, shown is " & hex_char severity error;
    wait on hex_char;  
		assert hex_char = '2' report "representation of 2 wrong, shown is " & hex_char severity error;
    wait on hex_char;
		assert hex_char = '3' report "representation of 3 wrong, shown is " & hex_char severity error;
    wait on hex_char; 
		assert hex_char = '4' report "representation of 4 wrong, shown is " & hex_char severity error;
    wait on hex_char; 
		assert hex_char = '5' report "representation of 5 wrong, shown is " & hex_char severity error;
    wait on hex_char; 
		assert hex_char = '6' report "representation of 6 wrong, shown is " & hex_char severity error;
    wait on hex_char; 
		assert hex_char = '7' report "representation of 7 wrong, shown is " & hex_char severity error;
    wait on hex_char; 
		assert hex_char = '8' report "representation of 8 wrong, shown is " & hex_char severity error;
    wait on hex_char; 
		assert hex_char = '9' report "representation of 9 wrong, shown is " & hex_char severity error;
    wait on hex_char; 
		assert hex_char = 'a' report "representation of a wrong, shown is " & hex_char severity error;
    wait on hex_char;  
		assert hex_char = 'b' report "representation of b wrong, shown is " & hex_char severity error;
    wait on hex_char; 
		assert hex_char = 'c' report "representation of c wrong, shown is " & hex_char severity error;
    wait on hex_char; 
		assert hex_char = 'd' report "representation of d wrong, shown is " & hex_char severity error;
    wait on hex_char; 
		assert hex_char = 'e' report "representation of e wrong, shown is " & hex_char severity error;
    wait on hex_char; 
		assert hex_char = 'f' report "representation of f wrong, shown is " & hex_char severity error;

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
