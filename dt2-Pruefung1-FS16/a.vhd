library ieee;
use ieee.std_logic_1164.all;

entity a is
  port( 
    x : in  std_ulogic;
    y : out std_ulogic_vector(7 downto 0);
    z : out std_ulogic
  );
end entity a;


architecture rtl of a is
begin
  -- some rtl-code...
end architecture rtl;
