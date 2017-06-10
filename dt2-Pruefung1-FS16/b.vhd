library ieee;
use ieee.std_logic_1164.all;

entity b is
  port( 
    i0 : in  std_ulogic_vector(7 downto 0);
    i1 : in  std_ulogic;
    i2 : in  std_ulogic_vector(7 downto 0);
    o0 : out std_ulogic;
    o1 : out std_ulogic_vector(1 downto 0)
  );
end entity b;


architecture rtl of b is
begin
  -- some rtl-code...
end architecture rtl;
