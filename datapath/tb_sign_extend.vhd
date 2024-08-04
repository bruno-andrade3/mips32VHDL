library ieee;
use ieee.std_logic_1164.all;

entity tb_sign_extend is
end tb_sign_extend;

architecture behavior of tb_sign_extend is

    -- Component Declaration for the Unit Under Test (UUT)
    component sign_extend is
        port(
            a: in  std_logic_vector(15 downto 0);
            result: out std_logic_vector(31 downto 0)
        );
    end component;

    -- Signals to connect to UUT
    signal a: std_logic_vector(15 downto 0) := (others => '0');
    signal result: std_logic_vector(31 downto 0);

    constant clk_period : time := 10 ns;

begin

    -- Instantiate the Unit Under Test (UUT)
    uut: sign_extend
        port map (
            a => a,
            result => result
        );

    -- Process to apply stimulus and check results
    stim_proc: process
    begin
        -- Test case 1: Sign extend a positive number
        a <= x"1234";
        wait for clk_period;
        assert (result = x"00001234") report "Error: result should be 00001234 when a is 1234" severity error;

        -- Test case 2: Sign extend a negative number
        a <= x"F234";
        wait for clk_period;
        assert (result = x"FFFFF234") report "Error: result should be FFFFF234 when a is F234" severity error;

        -- Test case 3: Sign extend zero
        a <= x"0000";
        wait for clk_period;
        assert (result = x"00000000") report "Error: result should be 00000000 when a is 0000" severity error;

        -- Test case 4: Sign extend the maximum positive 16-bit number
        a <= x"7FFF";
        wait for clk_period;
        assert (result = x"00007FFF") report "Error: result should be 00007FFF when a is 7FFF" severity error;

        -- Test case 5: Sign extend the maximum negative 16-bit number
        a <= x"8000";
        wait for clk_period;
        assert (result = x"FFFF8000") report "Error: result should be FFFF8000 when a is 8000" severity error;

        -- End of simulation
        report "Simulation finished successfully";
        wait;
    end process;

end behavior;
