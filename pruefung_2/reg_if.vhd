library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity reg_if is
	port (
    rst_n    : in  std_ulogic;
    clk      : in  std_ulogic;
    uart_rxd : in  std_ulogic;
    reg_addr : out std_ulogic_vector (31 downto 0);
    reg_data : out std_ulogic_vector (31 downto 0);
    reg_wr   : out std_ulogic
	);
end entity reg_if;

architecture struct of reg_if is
	component uart_rx
		port(
			clk         : in  std_ulogic;
			rst_n       : in  std_ulogic;
			uart_rxd    : in  std_ulogic;
			rx_data     : out std_ulogic_vector(7 downto 0);
			rx_data_rdy : out std_ulogic
		);
	end component uart_rx;	
	component collect_data
		port(
			clk         : in  std_ulogic;
			rst_n       : in  std_ulogic;
			rx_data     : in  std_ulogic_vector(7 downto 0);
			rx_data_rdy : in  std_ulogic;
			reg_addr    : out std_ulogic_vector(31 downto 0);
			reg_data    : out std_ulogic_vector(31 downto 0);
			reg_wr      : out std_ulogic
		);
	end component collect_data;
	signal rx_data     : std_ulogic_vector(7 downto 0);
  signal rx_data_rdy : std_ulogic;
begin
  i0_collect_data : collect_data
    port map (
      clk         => clk,
      rst_n       => rst_n,
      rx_data     => rx_data,
      rx_data_rdy => rx_data_rdy,
      reg_addr    => reg_addr,
      reg_data    => reg_data,
      reg_wr      => reg_wr
    );
  i0_uart_rx : uart_rx
    port map (
      clk         => clk,
      rst_n       => rst_n,
      uart_rxd    => uart_rxd,
      rx_data     => rx_data,
      rx_data_rdy => rx_data_rdy
    );
end architecture struct;

------------------------------------------
------------------------------------------
------------------------------------------
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity uart_rx is
  port( 
    clk         : in     std_ulogic;
    rst_n       : in     std_ulogic;
    uart_rxd    : in     std_ulogic;
    rx_data     : out    std_ulogic_vector (7 downto 0);
    rx_data_rdy : out    std_ulogic
  );
end entity uart_rx ;

architecture rtl of uart_rx is

  constant c_uart_baudrate       : integer := 115200;  -- 115200 baud
  constant c_uart_data_bits      : integer := 8;       -- 8 data bits
  constant c_uart_parity         : integer := 0;       -- no parity
  constant c_uart_stop_bits      : integer := 1;       -- 1 stop bit
  constant c_uart_int_width      : integer := 11;      -- 11 bit oversampling integer bits
  constant c_uart_frac_width     : integer := 0;       -- 0 bit oversampling fractional bits
  constant c_uart_ovs_factor     : integer := 1085;    -- oversampling factor
  constant c_uart_data_bit_width : integer := 4;       -- log2(9) = 4 bit (cnt 1..8)  
  constant c_add2_in2_zero        : unsigned(c_uart_int_width-2 downto 0) := (others => '0');

  signal ovs_factor           : unsigned (c_uart_int_width+c_uart_frac_width-1 downto 0);
  signal add1_in1             : unsigned(c_uart_frac_width downto 0);
  signal add1_in2             : unsigned(c_uart_frac_width downto 0);
  signal add1_res             : unsigned(c_uart_frac_width downto 0);
  signal add2_in1             : unsigned(c_uart_int_width-1 downto 0);
  signal add2_in2             : unsigned(c_uart_int_width-1 downto 0);
  signal rx_end_val           : unsigned(c_uart_int_width-1 downto 0);
  signal rx_first_val         : std_ulogic;
  signal rx_next_val          : std_ulogic;
  signal rx_counter           : unsigned(c_uart_int_width-1 downto 0);
  signal rx_data_bits_counter : unsigned(c_uart_data_bit_width-1 downto 0);  
  signal rx_parity_calc       : std_ulogic;  

  type t_state is (
    idle,
    start_bit1,
    rx_data_bits1,
    check_parity1,
    stop_bit1_1,
    stop_bit2_1,
    start_bit2,
    rx_data_bits2,
    check_parity2,
    stop_bit1_2,
    stop_bit2_2
  );

  signal current_state     : t_state;
  signal next_state        : t_state;
  signal rx_data_rdy_cld   : std_ulogic ;
  signal frame_error_cld   : std_ulogic ;
  signal parity_error_cld  : std_ulogic ;
  signal received_data_cld : std_ulogic_vector (c_uart_data_bits-1 downto 0);
  signal rxd_en            : std_ulogic;

begin

   ovs_factor <= to_unsigned(c_uart_ovs_factor, ovs_factor'length);
   rxd_en <= '1';

  -----------------------------------------------------------------
  -- receive correction --
  -----------------------------------------------------------------
  no_rx_corr: if c_uart_frac_width = 0 generate
    add1_res <= (others => '0');  -- no correction
  end generate;

  -- second adder
  add2_in1   <= '0' & ovs_factor(ovs_factor'high downto c_uart_frac_width+1) when rx_first_val = '1' else
                      ovs_factor(ovs_factor'high downto c_uart_frac_width);
  add2_in2   <= c_add2_in2_zero & '0' when rx_first_val = '1' else
                c_add2_in2_zero & not(add1_res(add1_res'high));
  rx_end_val <= add2_in1 - add2_in2;      -- sub 1 in case of no correction, sub 0 in case of correction


  -----------------------------------------------------------------
  -- receive bits --
  -----------------------------------------------------------------
  p_clocked : process (rst_n, clk)
  -----------------------------------------------------------------
  begin
    if (rst_n = '0') then
      current_state <= idle;
      rx_data_rdy_cld <= '0';
      frame_error_cld <= '0';
      parity_error_cld <= '0';
      received_data_cld <= (others => '0');
      rx_counter <= (others => '0');
      rx_data_bits_counter <= (others => '0');
      rx_parity_calc <= '0';
    elsif (rising_edge(clk)) then
      current_state <= next_state;
      case next_state is
        when idle => 
          rx_counter <= (others => '0');
          rx_data_bits_counter <= (others => '0');
          rx_data_rdy_cld <= '0';
          rx_parity_calc <= '0';
        when start_bit1 => 
          rx_counter <= rx_counter + 1;
          rx_data_bits_counter <= (others => '0');
          rx_data_rdy_cld <= '0';
          rx_parity_calc <= '0';
        when rx_data_bits1 => 
          rx_counter  <= rx_counter + 1;
        when check_parity1 => 
          rx_counter  <= rx_counter + 1;
        when stop_bit1_1 => 
          rx_counter <= rx_counter + 1;
        when stop_bit2_1 => 
          rx_counter <= rx_counter + 1;
        when start_bit2 => 
          rx_counter   <= (others => '0');
        when rx_data_bits2 => 
          received_data_cld    <= uart_rxd & received_data_cld(received_data_cld'high downto 1);
          rx_counter           <= (others => '0');
          rx_data_bits_counter <= rx_data_bits_counter + 1;
          rx_parity_calc       <= rx_parity_calc xor uart_rxd;
        when check_parity2 => 
          rx_counter <= (others => '0');
          if (c_uart_parity = 1 and uart_rxd = rx_parity_calc) or
             (c_uart_parity = 2 and uart_rxd = not(rx_parity_calc)) or
             (c_uart_parity = 3 and uart_rxd = '1') or
             (c_uart_parity = 4 and uart_rxd = '0') then
            parity_error_cld <= '0';
          else
            parity_error_cld <= '1';
          end if;
        when stop_bit1_2 => 
          rx_counter <= (others => '0');
          if c_uart_stop_bits /= 2 then
            rx_data_rdy_cld <= '1';
          end if;
          if uart_rxd = '1' then
            frame_error_cld <= '0';
          else
            frame_error_cld <= '1';
          end if;
        when stop_bit2_2 => 
          rx_counter <= (others => '0');
          rx_data_rdy_cld <= '1';
          if uart_rxd = '1' then
            frame_error_cld <= '0';
          else
            frame_error_cld <= '1';
          end if;
        when others =>
          null;
      end case;
    end if;
  end process p_clocked;
 
  -----------------------------------------------------------------
  p_nextstate : process (all)
  -----------------------------------------------------------------
  begin
    case current_state is
      when idle => 
        if (rxd_en = '1' and 
            uart_rxd = '0') then 
          next_state <= start_bit1;
        else
          next_state <= idle;
        end if;
      when start_bit1 => 
        if (rx_counter = rx_end_val) then 
          next_state <= start_bit2;
        else
          next_state <= start_bit1;
        end if;
      when rx_data_bits1 => 
        if (rx_counter = rx_end_val) then 
          next_state <= rx_data_bits2;
        else
          next_state <= rx_data_bits1;
        end if;
      when check_parity1 => 
        if (rx_counter = rx_end_val) then 
          next_state <= check_parity2;
        else
          next_state <= check_parity1;
        end if;
      when stop_bit1_1 => 
        if (rx_counter = rx_end_val) then 
          next_state <= stop_bit1_2;
        else
          next_state <= stop_bit1_1;
        end if;
      when stop_bit2_1 => 
        if (rx_counter = rx_end_val) then 
          next_state <= stop_bit2_2;
        else
          next_state <= stop_bit2_1;
        end if;
      when start_bit2 => 
        if (true) then 
          next_state <= rx_data_bits1;
        else
          next_state <= start_bit2;
        end if;
      when rx_data_bits2 => 
        if (rx_data_bits_counter /= c_uart_data_bits) then 
          next_state <= rx_data_bits1;
        elsif (c_uart_parity = 0) then 
          next_state <= stop_bit1_1;
        elsif (true) then 
          next_state <= check_parity1;
        else
          next_state <= rx_data_bits2;
        end if;
      when check_parity2 => 
        if (true) then 
          next_state <= stop_bit1_1;
        else
          next_state <= check_parity2;
        end if;
      when stop_bit1_2 => 
        if (c_uart_stop_bits = 2) then 
          next_state <= stop_bit2_1;
        elsif (uart_rxd = '0') then 
          next_state <= start_bit1;
        elsif (true) then 
          next_state <= idle;
        else
          next_state <= stop_bit1_2;
        end if;
      when stop_bit2_2 => 
        if (uart_rxd = '0') then 
          next_state <= start_bit1;
        elsif (true) then 
          next_state <= idle;
        else
          next_state <= stop_bit2_2;
        end if;
      when others =>
        next_state <= idle;
    end case;
  end process p_nextstate;
 
  -----------------------------------------------------------------
  p_output : process (all)
  ----------------------- ------------------------------------------
  begin
    rx_first_val <= '0';
    rx_next_val <= '0';
    case current_state is
      when idle => 
        rx_first_val <= '1';
        rx_next_val <= '0';
      when start_bit1 => 
        rx_first_val <= '1';
        rx_next_val <= '0';
      when rx_data_bits1 => 
        rx_next_val <= '0';
      when check_parity1 => 
        rx_next_val <= '0';
      when stop_bit1_1 => 
        rx_next_val <= '0';
      when stop_bit2_1 => 
        rx_next_val <= '0';
      when start_bit2 => 
        rx_first_val <= '0';
      when rx_data_bits2 => 
        rx_next_val          <= '1';
      when check_parity2 => 
        rx_next_val <= '1';
      when stop_bit1_2 => 
        rx_next_val <= '1';
      when others =>
        null;
    end case;
  end process p_output;

  rx_data_rdy <= rx_data_rdy_cld;
  rx_data <= received_data_cld;

end architecture rtl;

------------------------------------------
------------------------------------------
------------------------------------------

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity collect_data is
  port( 
    clk         : in     std_ulogic;
    rst_n       : in     std_ulogic;
    rx_data     : in     std_ulogic_vector (7 downto 0);
    rx_data_rdy : in     std_ulogic;
    reg_addr    : out    std_ulogic_vector (31 downto 0);
    reg_data    : out    std_ulogic_vector (31 downto 0);
    reg_wr      : out    std_ulogic
  );
end entity collect_data ;

architecture rtl of collect_data is
  signal uart_rx_cnt       : unsigned(2 downto 0);  -- count 0 to 7 (4 x addr + 4 x data)
  signal addr              : std_ulogic_vector (31 downto 0);
  signal data              : std_ulogic_vector (31 downto 0);
  signal valid             : std_ulogic;
  signal reg_wr_valid      : std_ulogic;
begin

  p_rx_cnt : process(rst_n, clk)
  begin
    if rst_n = '0' then
      uart_rx_cnt <= (others => '0');
    elsif rising_edge(clk) then
      if rx_data_rdy = '1' then 
        uart_rx_cnt <= uart_rx_cnt + 1;
      end if;
    end if;
  end process p_rx_cnt;
  
  
  p_collect_data : process(rst_n, clk)
  begin
    if rst_n = '0' then
      addr <= (others => '0');
      data <= (others => '0');
    elsif rising_edge(clk) then
      if rx_data_rdy = '1' then 
        case uart_rx_cnt is
          when "000" => addr(31 downto 24) <= rx_data;
          when "001" => addr(23 downto 16) <= rx_data;
          when "010" => addr(15 downto  8) <= rx_data;
          when "011" => addr( 7 downto  0) <= rx_data;
          --------------------------------------------
          when "100" => data(31 downto 24) <= rx_data;
          when "101" => data(23 downto 16) <= rx_data;
          when "110" => data(15 downto  8) <= rx_data;
          when "111" => data( 7 downto  0) <= rx_data;
          when others => null;         
        end case;
      end if;
    end if;
  end process p_collect_data;

  
  p_valid : process(rst_n, clk)
  begin
    if rst_n = '0' then
      valid <= '0';
    elsif rising_edge(clk) then
      if rx_data_rdy = '1' and uart_rx_cnt = 7 then  -- addr and data are valid
        valid <= '1';
      else
        valid <= '0';
      end if;
    end if;
  end process p_valid;


  -------------------------------------------------------------
  -- register-interface 
  -------------------------------------------------------------
  p_reg_wr_valid : process(rst_n, clk)
  begin
    if rst_n = '0' then
      reg_wr_valid <= '0';
    elsif rising_edge(clk) then
      if valid = '1' then 
        reg_wr_valid <= '1';
      else
        reg_wr_valid <= '0';
      end if;
    end if;
  end process p_reg_wr_valid;

  
  p_reg_addr : process(rst_n, clk)
  begin
    if rst_n = '0' then
      reg_addr <= (others => '0');
    elsif rising_edge(clk) then
      if valid = '1' then 
        reg_addr <= transport addr after 2 ns;
      end if;
    end if;
  end process p_reg_addr;


  p_reg_data : process(rst_n, clk)
  begin
    if rst_n = '0' then
      reg_data <= (others => '0');
    elsif rising_edge(clk) then
      if valid = '1' then
        reg_data <= transport data after 2 ns;
      end if;
    end if;
  end process p_reg_data;

  reg_wr <= transport reg_wr_valid after 2 ns;   

end architecture rtl;
