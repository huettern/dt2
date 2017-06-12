-----------------------------------------------------
-- Project DICE
-----------------------------------------------------
-- File    : decelerate_rtl.vhd
-- Library : work
-- Author  : stefan.brantschen@fhnw.ch
-- Created : 28.03.2012
-- Company : Institute of Microelectronics (IME) FHNW
-- Copyright(C) IME
-----------------------------------------------------
-- Acts as clock-divider. To make human beings able 
-- to see the rotation, the rotation-speed should be
-- 24 Hz in maximum.
-- To make the simulation faster, the generic g_test
-- may be set to true, so the rotation-speed is 
-- 10 MHz.
-- The slow-down-rotation (anti-clockwise) needs
-- 10 steps to come to an end.
-----------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;

entity decelerate is
  generic( 
    g_test : boolean := false
  );
  port( 
    clock    : in  std_ulogic;
    reset_n  : in  std_ulogic;
    state    : in  std_ulogic_vector (1 downto 0);
    ani_en   : out std_ulogic;
    ani_stop : out std_ulogic
  );
end entity decelerate ;

architecture rtl of decelerate is
  constant c_max1_syn  : natural := 2**21;  -- 50 MHz/2**21 + 1 = 24 Hz
  constant c_max1_sim  : natural := 2**2;   -- 50 MHz/2**2 + 1  = 10 MHz
  constant c_max2      : natural := 10;  -- number of slow-down-steps
  signal max1          : natural range 0 to c_max1_syn-1;
	signal scale_cnt     : natural range 0 to c_max1_syn-1;  -- acts as prescaler 
	signal slow_down_cnt : natural range 0 to c_max2-1;  -- number of slow-down-steps
	signal step_cnt      : natural range 0 to c_max2-1; 
begin

  max1 <= c_max1_sim-1 when g_test = true else c_max1_syn-1;

	p_scale_cnt : process(reset_n, clock)
	begin
		if reset_n = '0' then
			scale_cnt <= 0;
		elsif rising_edge(clock) then
			if state /= "00" then  -- start_n pressed causes state 01, release causes state 10
				if scale_cnt = max1 then  -- once every 24 Hz (10 MHz)
					scale_cnt <= 0;
				else
					scale_cnt <= (scale_cnt+1);
				end if; 
			else
				scale_cnt <= 0;			
			end if;
		end if;
	end process p_scale_cnt;
	
	p_slow_down : process(reset_n, clock)
	begin
		if reset_n = '0' then
			slow_down_cnt <= 0;
      step_cnt <= 0;
		elsif rising_edge(clock) then
			if state = "10" then  -- release of start_n causes state 10
				if scale_cnt = max1 then
					if slow_down_cnt = step_cnt and step_cnt < c_max2-1 then
						slow_down_cnt <= 0;
						step_cnt <= step_cnt+1;
					else
						if slow_down_cnt /= c_max2-1 then 
							slow_down_cnt <= slow_down_cnt+1;
						end if;
					end if;
				end if; 
			else
				slow_down_cnt <= 0;
				step_cnt <= 0;
			end if;
		end if;
	end process p_slow_down;
	
	ani_en <= '1' when (state = "01" and scale_cnt = max1) or
	                   (state = "10" and scale_cnt = max1 and slow_down_cnt = 0) else '0';

	ani_stop <= '1' when slow_down_cnt = c_max2-1 else '0';
	

end architecture rtl;
