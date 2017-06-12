-----------------------------------------------------
-- Project DICE
-----------------------------------------------------
-- File    : control_game_fsm.vhd
-- Library : work
-- Author  : stefan.brantschen@fhnw.ch
-- Created : 28.03.2012
-- Company : Institute of Microelectronics (IME) FHNW
-- Copyright(C) IME
-----------------------------------------------------
-- Three different states:
-- 1.	show_animation
--   Segments rotate clockwise as soon as start_n is
--   pressed. If start_n released, move on to 
--   slow_down_animation state
-- 2.	slow_down_animation
--   Segments rotate anti-clockwise and slow down.
--   After 10 steps (ani_stop = '1') move on to 
--   show_number
-- 3.	show_number
--   Segments show random-number. As soon as start_n
--   is pressed again, go to show_animation
-----------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;

entity control_game is
  port( 
    ani_stop : in  std_ulogic;
    clock    : in  std_ulogic;
    reset_n  : in  std_ulogic;
    start_n  : in  std_ulogic;
    state    : out std_ulogic_vector (1 downto 0)
  );
end entity control_game ;

architecture fsm of control_game is
  type state_type is (show_number, show_animation, slow_down_animation);
  signal current_state : state_type ;
  signal next_state    : state_type ;
begin

  -- sequential process
  p_clocked: process(reset_n, clock)
  begin
    if (reset_n = '0') then
      current_state <= show_number;
    elsif rising_edge(clock) then
      current_state <= next_state;
    end if;
  end process p_clocked;
  
  -- combinational process
	p_comb : process (ani_stop, current_state, start_n)
  begin
   -- calculation of next_state (represents the state-diagram)
  case current_state is
    when show_number =>
      if (start_n = '0') then
         next_state <= show_animation;
      else
         next_state <= show_number;
      end if;
    when show_animation =>
      if (start_n = '1') then
         next_state <= slow_down_animation;
      else
         next_state <= show_animation;
      end if;
    when slow_down_animation =>
      if (ani_stop = '1') then
         next_state <= show_number;
      else
         next_state <= slow_down_animation;
      end if;
    when others => 
		  next_state <= show_number;
	end case;

  -- calculation of the outputs (depends only on the actual state(moore))
  case current_state is
    when show_number         => state <= "00";
    when show_animation      => state <= "01";
    when slow_down_animation => state <= "10";
    when others              => state <= "00";
  end case;

 end process p_comb;
 
end architecture fsm;
