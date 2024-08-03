library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity tb_mux2 is
end tb_mux2;

architecture behavior of tb_mux2 is
    constant width : integer := 8; -- Bit width of the multiplexer

    component mux2
        generic (width : integer);
        port (
            d0, d1 : in  std_logic_vector(width-1 downto 0);
            s      : in  std_logic;
            y      : out std_logic_vector(width-1 downto 0)
        );
    end component;

    signal d0, d1 : std_logic_vector(width-1 downto 0);
    signal s : std_logic;
    signal y : std_logic_vector(width-1 downto 0);

    constant clk_period : time := 10 ns;
    constant sim_time : time := 200 ns; -- Total simulation time

begin
    -- Instantiate the multiplexer
    uut: mux2
        generic map (
            width => width
        )
        port map (
            d0 => d0,
            d1 => d1,
            s  => s,
            y  => y
        );

    -- Process to apply stimulus and check results
    stim_proc: process
    begin
        -- Initialize inputs
        d0 <= (others => '0');
        d1 <= (others => '0');
        s  <= '0';

        -- Test case 1: Select d0
        d0 <= x"AA"; -- Input vector d0
        d1 <= x"55"; -- Input vector d1
        s  <= '0';   -- Select d0
        wait for clk_period;
        assert (y = x"AA") report "Erro: y deve ser AA quando s = 0" severity error;

        -- Test case 2: Select d1
        s  <= '1';   -- Select d1
        wait for clk_period;
        assert (y = x"55") report "Erro: y deve ser 55 quando s = 1" severity error;

        -- Test case 3: Change inputs
        d0 <= x"F0"; -- New input vector d0
        d1 <= x"0F"; -- New input vector d1
        s  <= '0';   -- Select d0
        wait for clk_period;
        assert (y = x"F0") report "Erro: y deve ser F0 quando s = 0 e d0 alterado" severity error;

        -- Test case 4: Select d1
        s  <= '1';   -- Select d1
        wait for clk_period;
        assert (y = x"0F") report "Erro: y deve ser 0F quando s = 1 e d1 alterado" severity error;

        -- Test case 5: Edge case with zero vectors
        d0 <= (others => '0');
        d1 <= (others => '0');
        s  <= '0';   -- Select d0
        wait for clk_period;
        assert (y = x"00") report "Erro: y deve ser 0 quando s = 0 e d0 é zero" severity error;

        -- End of simulation
        wait for sim_time;
        assert false report "Simulação terminada devido ao timeout" severity failure;

        wait;
    end process;

end behavior;