-- Name:
-- Vorname:

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity signal_gen is
  port( 
    clk    : in  std_ulogic;
    rst    : in  std_ulogic;
    output : out std_ulogic
  );
end entity signal_gen ;

architecture rtl of signal_gen is
  type t_state is (idle, s_low, s_high);
  signal c_state : t_state;
  signal n_state : t_state;
  signal cnt : unsigned(2 downto 0);
begin

  process(rst, clk)
  begin
    if rst = '1' then
      c_state <= idle;
    elsif rising_edge(clk) then
      c_state <= n_state;
    end if;
  end process;
  
  
  process(all)
  begin 
    case c_state is
      when idle   => n_state <= s_low;
      when s_low  => if cnt = 1 then
                       n_state <= s_high;
                     else
                       n_state <= s_low;
                     end if;
      when s_high => if cnt = 5 then
                       n_state <= s_low;
                     else
                       n_state <= s_high;
                     end if;
    end case;  
  end process;
  
  
  process(all)
  begin 
    case c_state is
      when idle | s_high => output <= '1';
      when s_low         => output <= '0';
    end case;  
  end process;
  
  
end architecture rtl;
