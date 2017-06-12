-----------------------------------------------------
-- Project DICE
-----------------------------------------------------
-- File    : dice_top.vhd
-- Library : work
-- Author  : stefan.brantschen@fhnw.ch
-- Created : 28.03.2012
-- Company : Institute of Microelectronics (IME) FHNW
-- Copyright(C) IME
-----------------------------------------------------
library ieee;
use ieee.std_logic_1164.all;

entity dice_top is
  port( 
    clock   : in  std_ulogic;
    reset_n : in  std_ulogic;
    start_n : in  std_ulogic;
    hex_n   : out std_ulogic_vector(6 downto 0)
  );
end entity dice_top ;

architecture struct of dice_top is

  signal ani_en      : std_ulogic;
  signal ani_pattern : std_ulogic_vector(6 downto 0);
  signal ani_stop    : std_ulogic;
  signal rnd_pattern : std_ulogic_vector(6 downto 0);
  signal state       : std_ulogic_vector(1 downto 0);

  -- component declarations
  component control_game
  port (
    ani_stop : in  std_ulogic ;
    clock    : in  std_ulogic ;
    reset_n  : in  std_ulogic ;
    start_n  : in  std_ulogic ;
    state    : out std_ulogic_vector (1 downto 0)
  );
  end component;
  component randomize
  port (
    clock       : in  std_ulogic ;
    reset_n     : in  std_ulogic ;
    state       : in  std_ulogic_vector (1 downto 0);
    rnd_pattern : out std_ulogic_vector (6 downto 0)
  );
  end component;
  component rotate
  port (
    ani_en      : in  std_ulogic ;
    clock       : in  std_ulogic ;
    reset_n     : in  std_ulogic ;
    state       : in  std_ulogic_vector (1 downto 0);
    ani_pattern : out std_ulogic_vector (6 downto 0)
  );
  end component;
  component decelerate
  generic (
    g_test : boolean := false
  );
  port (
    clock    : in  std_ulogic ;
    reset_n  : in  std_ulogic ;
    state    : in  std_ulogic_vector (1 downto 0);
    ani_en   : out std_ulogic ;
    ani_stop : out std_ulogic 
  );
  end component;

  -- optional embedded configurations
  for all : control_game use entity work.control_game(fsm);
  for all : decelerate use entity work.decelerate(rtl);
  for all : randomize use entity work.randomize(rtl);
  for all : rotate use entity work.rotate(rtl);

begin
  -- concurrent statement: mux                                 
  hex_n <= rnd_pattern when state = "00" else ani_pattern;

  -- instance port mappings.
  control_game_inst : control_game
    port map (
      ani_stop => ani_stop,
      clock    => clock,
      reset_n  => reset_n,
      start_n  => start_n,
      state    => state
    );
  randomize_inst : randomize
    port map (
      clock       => clock,
      reset_n     => reset_n,
      state       => state,
      rnd_pattern => rnd_pattern
    );
  rotate_inst : rotate
    port map (
      ani_en      => ani_en,
      clock       => clock,
      reset_n     => reset_n,
      state       => state,
      ani_pattern => ani_pattern
    );
  decelerate_inst : decelerate
    generic map (
      g_test => false
    )
    port map (
      clock    => clock,
      reset_n  => reset_n,
      state    => state,
      ani_en   => ani_en,
      ani_stop => ani_stop
    );

end architecture struct;
