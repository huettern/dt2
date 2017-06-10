-- Name:
-- Vorname:

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity integrate is
  port( 
    clk       : in  std_ulogic;
    rst_n     : in  std_ulogic;
    rst_int   : in  std_ulogic;
    tx        : in  std_ulogic_vector (7 downto 0);
    threshold : in  std_ulogic_vector (7 downto 0);
    limit     : in  std_ulogic_vector (11 downto 0);
    int_value : out std_ulogic_vector (15 downto 0);
    int_error : out std_ulogic
  );
end entity integrate ;


architecture rtl of integrate is
	signal integrate_value : std_ulogic_vector (15 downto 0);
begin

  p_integrate : process (rst_n, clk)
  begin
	if rst_n = '0' then
		integrate_value <= (others=>'0');
	elsif rising_edge(clk) then
		if rst_int = '1' then
			integrate_value <= (others=>'0');
		elsif unsigned(integrate_value) < unsigned(limit) then
			if unsigned(tx) > unsigned(threshold) then
				integrate_value <= std_ulogic_vector(unsigned(integrate_value) + unsigned(tx));
			end if;
		else
			--
		end if;
			
	end if;
end process p_integrate;

	int_error <= '1' when unsigned(integrate_value) > unsigned(limit) else '0';
	int_value <= integrate_value;

end architecture rtl;

