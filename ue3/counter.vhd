library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity counter is
	port (
		rst_n : in std_ulogic;
		clk : in std_ulogic;
		cnt : out std_ulogic_vector (3 downto 0);
		ctrl : out std_ulogic
	);
end entity counter;

architecture rtl of counter is
	signal count : integer RANGE 0 to 15;
begin

	p_ctr : process (rst_n, clk)
	begin
		if rst_n = '0' then
			count <= 0;
			
		elsif rising_edge(clk) then
			if count = 15 then
				count <= 0;
			else
				count <= count + 1;
			end if; 
		end if;
		
	end process p_ctr;
	
	ctrl <= '1' when count >= 10 and count <= 13  else '0';

	cnt <= std_ulogic_vector( to_unsigned(count,4) );

end architecture rtl;
