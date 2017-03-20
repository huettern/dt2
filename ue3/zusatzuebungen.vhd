-- 3.2
--
--library ieee;
--use ieee.std_logic_1164.all;
--use ieee.numeric_std.all;
--
--entity zusatzuebungen is
--	port (
--		rst : in std_ulogic;
--		clk : in std_ulogic;
--		a : in signed (13 downto 0);
--		b : in signed (13 downto 0);
--		c : in signed (13 downto 0);
--		max: out signed (13 downto 0)
--	);
--end entity zusatzuebungen;
--
--architecture rtl of zusatzuebungen is
--	signal tmp : signed (13 downto 0);
--begin
--	pipe : process ( clk )
--	begin
--		if rising_edge( clk ) then
--			tmp <= a when a > b else b;
--		end if;
--	end process pipe;
--	
--	p_out : process ( clk )
--	begin
--		if rising_edge( clk) then
--			max <= tmp when tmp > c else c;	
--		end if;
--	end process p_out;
--end architecture rtl;


-- 3.3
-- 
--library ieee;
--use ieee.std_logic_1164.all;
--use ieee.numeric_std.all;
--
--entity zusatzuebungen is
--	port (
--		data : in std_ulogic_vector (15 downto 0);
--		clk : in std_ulogic;
--		rst: in std_ulogic;
--		stored : out std_ulogic_vector (15 downto 0)
--	);
--end entity zusatzuebungen;
--
--architecture rtl of zusatzuebungen is
--	signal tmp : std_ulogic_vector (15 downto 0);
--begin
--	tmp <= data when rst = '1' else (others=>'0');
--
--	p_out : process ( clk )
--	begin
--		if rising_edge( clk ) then
--			stored <= tmp;	
--		end if;
--	end process p_out;
--	
--end architecture rtl;


-- 3.6
--
--library ieee;
--use ieee.std_logic_1164.all;
--use ieee.numeric_std.all;
--
--entity zusatzuebungen is
--	port (
--		clk : in std_ulogic;
--		rst : in std_ulogic;
--		cnt : out std_ulogic_vector(3 downto 0)
--	);
--end entity zusatzuebungen;
--
--architecture rtl of zusatzuebungen is
--	signal counter : unsigned (3 downto 0);
--begin
--	p_cnt : process ( clk ) is
--	begin
--		if rising_edge( clk ) then
--			if rst = '0' or counter = "1100" then
--				counter <= (others=>'0');
--			else
--				counter <= counter + 1;
--			end if;
--		end if;	
--	end process p_cnt;
--	
--	cnt <= std_ulogic_vector( counter );
--	
--end architecture rtl;


-- 3.7

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity zusatzuebungen is
	port (
		clk, ce, rst, load : in std_ulogic;
		data_in : in std_ulogic_vector (11 downto 0);
		data_out : out std_ulogic_vector (11 downto 0);
		zero : out std_ulogic
	);
end entity zusatzuebungen;

architecture rtl of zusatzuebungen is
	signal counter : unsigned (11 downto 0);
	signal load_val : unsigned (11 downto 0);
begin
	
	p_load : process ( clk, rst ) is
	begin
		if rst = '0' then
			load_val <= (others=>'1');
		elsif rising_edge ( clk ) then
			if load = '1' then
				load_val <= unsigned( data_in);
			end if;
		end if;
			
	end process p_load;
	
	p_cnt : process ( clk, rst ) is
	begin
		if rst = '0' then
			counter <= (others=>'1');
		elsif rising_edge( clk ) then
			if load = '1' then
				counter <= load_val;
			elsif ce = '1' then
				counter <= counter - 1;
			end if;	
		end if;
			
	end process p_cnt;
	
	data_out <= std_ulogic_vector(counter);
	zero <= '1' when counter = 0 else '0';
	
end architecture rtl;




