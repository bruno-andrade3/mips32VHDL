library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity tb_shift_left2 is
end tb_shift_left2;

architecture behavior of tb_shift_left2 is

    -- Component Declaration for the Unit Under Test (UUT)
    component shift_left2 is
        port(
            a: in  std_logic_vector(31 downto 0);
            y: out std_logic_vector(31 downto 0)
        );
    end component;

    -- Signals to connect to UUT
    signal a: std_logic_vector(31 downto 0) := (others => '0');
    signal y: std_logic_vector(31 downto 0);

    constant clk_period : time := 10 ns;

begin

    -- Instantiate the Unit Under Test (UUT)
    uut: shift_left2
        port map (
            a => a,
            y => y
        );

    -- Process to apply stimulus and check results
    stim_proc: process
    begin
        -- Test case 1: Shift left a value of 0
        a <= x"00000000";
        wait for clk_period;
        assert (y = x"00000000") report "Error: y should be 00000000 when a is 00000000" severity error;

        -- Test case 2: Shift left a value of 1
        a <= x"00000001";
        wait for clk_period;
        assert (y = x"00000004") report "Error: y should be 00000004 when a is 00000001" severity error;

        -- Test case 3: Shift left a value of 0xFFFFFFFF
        a <= x"FFFFFFFF";
        wait for clk_period;
        assert (y = x"FFFFFFFC") report "Error: y should be FFFFFC when a is FFFFFFFF" severity error;

        -- Test case 4: Shift left a value of 0x80000000
        a <= x"80000000";
        wait for clk_period;
        assert (y = x"00000000") report "Error: y should be 00000000 when a is 80000000" severity error;

        -- Test case 5: Shift left a value of 0x12345678
        a <= x"12345678";
        wait for clk_period;
        assert (y = x"48D159E0") report "Error: y should be 48D159E0 when a is 12345678" severity error;

        -- End of simulation
        report "Simulation finished successfully";
        wait;
    end process;

end behavior;
