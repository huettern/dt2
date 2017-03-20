library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity cola is
	port(
		clk : in std_ulogic;
		rst_n : in std_ulogic;
		e10rp, e20rp, e50rp : in boolean;
		cola, r10rp, r20rp : out std_ulogic
	);
end entity cola;

architecture rtl of cola is
	type state_type is (SNull, S10Rp, S20Rp, S30Rp, S40Rp, S50Rp, SCola, SColaR10, SColaR20, SColaR30, ScolaR40);
	signal current_state : state_type;
	signal next_state : state_type;
begin

	p_in_logic : process (e10rp, e20rp, e50rp, current_state) is
	begin
		case current_state is
		when SNull =>
			if e10rp then next_state <= S10Rp;
			elsif e20rp then next_state <= S20Rp;
			end if;
		when S10Rp =>
			if e10rp then next_state <= S20Rp;
			elsif e20rp then next_state <= S30Rp;
			elsif e50rp then next_state <= SCola;
			end if;
		when S20Rp =>
			if e10rp then next_state <= S30Rp;
			elsif e20rp then next_state <= S40Rp;
			elsif e50rp then next_state <= SColaR10;
			end if;
		when S30Rp =>
			if e10rp then next_state <= S40Rp;
			elsif e20rp then next_state <= S50Rp;
			elsif e50rp then next_state <= SColaR20;
			end if;
		when S40Rp =>
			if e10rp then next_state <= S50Rp;
			elsif e50rp then next_state <= SColaR30;
			end if;
		when S50Rp =>
			if e10rp then next_state <= SCola;
			elsif e20rp then next_state <= SColaR10;
			elsif e50rp then next_state <= ScolaR40;
			end if;
		when SCola =>
			next_state <= SNull;
		when SColaR10 =>
			next_state <= SNull;
		when SColaR20 =>
			next_state <= SNull;
		when SColaR30 =>
			next_state <= SNull;
		when ScolaR40 =>
			next_state <= SColaR20;
		end case;
	end process;
	
	
	p_clk : process(rst_n, clk)
	begin
		if rst_n = '0' then
			current_state <= SNull;
		elsif rising_edge(clk) then
			current_state <= next_state;
		end if;
	end process p_clk;
	
	p_out_logic : process (current_state)
	begin
		case current_state is
		when SNull =>
			cola <= '0';
			r10rp <= '0';
			r20rp <= '0';
		when S10Rp =>
			null;
		when S20Rp =>
			null;
		when S30Rp =>
			null;
		when S40Rp =>
			null;
		when S50Rp =>
			null;
		when SCola =>
			cola <= '1';
		when SColaR10 =>
			cola <= '1';
			r10rp <= '1';
		when SColaR20 =>
			cola <= '1';
			r20rp <= '1';
		when SColaR30 =>
			cola <= '1';
			r20rp <= '1';
			r10rp <= '1';
		when ScolaR40 =>
			cola <= '1';
			r20rp <= '1';
		end case;
	end process p_out_logic;
		

end architecture rtl;
