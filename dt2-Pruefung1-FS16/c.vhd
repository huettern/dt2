library ieee;
use ieee.std_logic_1164.all;

entity c is
  port( 
    x : in  std_ulogic;
    y : in  std_ulogic;
    z : in  std_ulogic;
    o : out std_ulogic_vector (7 downto 0)
  );
end entity c;


architecture rtl of c is
begin
  -- some rtl-code...
end architecture rtl;
