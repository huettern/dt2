library ieee;
use ieee.std_logic_1164.all;

entity bin2hex is
  port(
    data : in std_ulogic_vector(3 downto 0);
    a : out std_ulogic;
    b : out std_ulogic;
    c : out std_ulogic;
    d : out std_ulogic;
    e : out std_ulogic;
    f : out std_ulogic;
    g : out std_ulogic
  );
end entity bin2hex;



architecture logic of bin2hex is
begin
	a <= '1' when 	data = "0001" or
					data = "0100" or
					data = "1011" or
					data = "1101" else
					'0';
	b <= '1' when 	data = "0101" or
					data = "0110" or
					data = "1011" or
					data = "1100" or
					data = "1110" or
					data = "1111" else
					'0';
	c <= '1' when 	data = "0010" or
					data = "1100" or
					data = "1110" or
					data = "1111" else
					'0';
	d <= '1' when 	data = "0001" or
					data = "0100" or
					data = "1001" or
					data = "1010" or
					data = "1111" else
					'0';
	e <= '1' when 	data = "0001" or
					data = "0011" or
					data = "0100" or
					data = "0101" or
					data = "1001" else
					'0';
	f <= '1' when 	data = "0001" or
					data = "0010" or
					data = "0011" or
					data = "1001" or
					data = "1101" else
					'0';
	g <= '1' when 	data = "0000" or
					data = "0001" or
					data = "1100" else
					'0';
end architecture logic;
