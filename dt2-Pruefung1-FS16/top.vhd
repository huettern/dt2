-- Name:
-- Vorname:

library ieee;
use ieee.std_logic_1164.all;

entity top is
  port( 
    in0  : in  std_ulogic;
    in1  : in  std_ulogic_vector (7 downto 0);
    in2  : in  std_ulogic;
    out0 : out std_ulogic_vector (7 downto 0);
    out1 : out std_ulogic_vector (7 downto 0);
    out2 : out std_ulogic
  );
end entity top ;

architecture structural of top is
	component a
		port(
			x : in  std_ulogic;
			y : out std_ulogic_vector(7 downto 0);
			z : out std_ulogic
		);
	end component a;
	component b
		port(
			i0 : in  std_ulogic_vector(7 downto 0);
			i1 : in  std_ulogic;
			i2 : in  std_ulogic_vector(7 downto 0);
			o0 : out std_ulogic;
			o1 : out std_ulogic_vector(1 downto 0)
		);
	end component b;
	component c
		port(
			x : in  std_ulogic;
			y : in  std_ulogic;
			z : in  std_ulogic;
			o : out std_ulogic_vector(7 downto 0)
		);
	end component c;
	component d
		port(
			l : in  std_ulogic_vector(7 downto 0);
			m : in  std_ulogic_vector(1 downto 0);
			n : out std_ulogic
		);
	end component d;
	
	signal a1 : std_ulogic_vector (7 downto 0);
	signal a2 : std_ulogic;
	signal b1 : std_ulogic_vector (1 downto 0);
	signal c1 : std_ulogic_vector (7 downto 0);
	
	
begin
	a_a : component a
		port map(
			x => in0,
			y => a1,
			z => a2
		);
		
		b_b : component b
			port map(
				i0 => in1,
				i1 => in2,
				i2 => c1,
				o0 => b1,
				o1 => 
			);
			c_c : component c
				port map(
					x => x,
					y => y,
					z => z,
					o => o
				);
end architecture structural;
