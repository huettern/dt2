library ieee;
use ieee.std_logic_1164.all;

entity d is
  port( 
    l : in  std_ulogic_vector(7 downto 0);
    m : in  std_ulogic_vector(1 downto 0);
    n : out std_ulogic
  );
end entity d;


architecture rtl of d is
begin
  -- some rtl-code...
end architecture rtl;
