library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity tb_adder is
end tb_adder;

architecture behavior of tb_adder is
    -- Component Declaration for the Unit Under Test (UUT)
    component adder
        port (
            a : in  std_logic_vector(31 downto 0);
            b : in  std_logic_vector(31 downto 0);
            y : out std_logic_vector(31 downto 0)
        );
    end component;

    -- Testbench signals
    signal a : std_logic_vector(31 downto 0) := (others => '0');
    signal b : std_logic_vector(31 downto 0) := (others => '0');
    signal y : std_logic_vector(31 downto 0);

begin
    -- Instantiate the Unit Under Test (UUT)
    uut: adder port map (
        a => a,
        b => b,
        y => y
    );

    -- Stimulus process
    stim_proc: process
    begin
        -- Test case 1
        a <= x"00000001";
        b <= x"00000001";
        wait for 10 ns;
        assert (y = x"00000002")
            report "Test case 1 failed" severity error;

        -- Test case 2
        a <= x"FFFFFFFF";
        b <= x"00000001";
        wait for 10 ns;
        assert (y = x"00000000")
            report "Test case 2 failed" severity error;

        -- Test case 3
        a <= x"0000000A";
        b <= x"00000005";
        wait for 10 ns;
        assert (y = x"0000000F")
            report "Test case 3 failed" severity error;

        -- Test case 4
        a <= x"12345678";
        b <= x"87654321";
        wait for 10 ns;
        assert (y = x"99999999")
            report "Test case 4 failed" severity error;

        -- Test case 5
        a <= x"0000FFFF";
        b <= x"00000001";
        wait for 10 ns;
        assert (y = x"00010000")
            report "Test case 5 failed" severity error;

        -- Test case 6
        a <= x"00000000";
        b <= x"00000000";
        wait for 10 ns;
        assert (y = x"00000000")
            report "Test case 6 failed" severity error;

        -- Test case 7
        a <= x"80000000";
        b <= x"80000000";
        wait for 10 ns;
        assert (y = x"00000000")
            report "Test case 7 failed" severity error;

        -- Add more test cases if needed

        -- End simulation
        wait;
    end process;

end behavior;
