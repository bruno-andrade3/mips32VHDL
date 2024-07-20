library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

-- Testbench entity (no ports)
entity tb_flopr is
end tb_flopr;

architecture behavior of tb_flopr is
    -- Generic width for the flip-flop
    constant width : integer := 8;

    -- Component declaration for the flip-flop
    component flopr
        generic (width : integer);
        port (
            clk, reset : in  std_logic;
            d :          in  std_logic_vector(width-1 downto 0);
            q :          out std_logic_vector(width-1 downto 0)
        );
    end component;

    -- Signals for connecting to the flip-flop
    signal clk, reset : std_logic;
    signal d :          std_logic_vector(width-1 downto 0);
    signal q :          std_logic_vector(width-1 downto 0);

    -- Constant for all-zeros vector
    constant all_zeros : std_logic_vector(width-1 downto 0) := (others => '0');

begin
    -- Instantiate the flip-flop
    uut: flopr
        generic map (
            width => width
        )
        port map (
            clk => clk,
            reset => reset,
            d => d,
            q => q
        );

    -- Clock generation process
    clk_process : process
    begin
        clk <= '0';
        wait for 10 ns;
        clk <= '1';
        wait for 10 ns;
    end process clk_process;

    -- Process for stimulus generation
    stim_proc: process
    begin
        -- Test case 1: Apply reset
        reset <= '1';
        d <= (others => '0');
        wait for 20 ns; -- Wait for two clock cycles
        assert (q = all_zeros) report "Error: q should be all zeros after reset" severity error;

        -- Test case 2: Remove reset and apply data
        reset <= '0';
        d <= x"AA"; -- Apply data (binary: 10101010)
        wait for 20 ns; -- Wait for two clock cycles
        assert (q = x"AA") report "Error: q should be AA" severity error;

        -- Test case 3: Change data
        d <= x"55"; -- Apply data (binary: 01010101)
        wait for 20 ns; -- Wait for two clock cycles
        assert (q = x"55") report "Error: q should be 55" severity error;

        -- Test case 4: Apply reset again
        reset <= '1';
        wait for 20 ns; -- Wait for two clock cycles
        assert (q = all_zeros) report "Error: q should be all zeros after reset" severity error;

        -- End simulation
        wait;
    end process;

end behavior;