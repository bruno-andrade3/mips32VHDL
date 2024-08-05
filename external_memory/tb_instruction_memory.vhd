library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity tb_instruction_memory is
end tb_instruction_memory;

architecture behavior of tb_instruction_memory is

    -- Signals for the testbench
    signal clk : std_logic := '0';
    signal a   : std_logic_vector(5 downto 0) := (others => '0');
    signal rd  : std_logic_vector(31 downto 0);

    -- Clock period
    constant clk_period : time := 10 ns;

    -- Component under test
    component instruction_memory
        port (
            clk : in std_logic;
            a   : in std_logic_vector(5 downto 0);
            rd  : out std_logic_vector(31 downto 0)
        );
    end component;

begin

    -- Instantiate the instruction_memory
    uut: instruction_memory
        port map (
            clk => clk,
            a   => a,
            rd  => rd
        );

    -- Clock generation process
    clk_gen: process
    begin
        while True loop
            clk <= '0';
            wait for clk_period / 2;
            clk <= '1';
            wait for clk_period / 2;
        end loop;
    end process;

    -- Testbench process
    stim_proc: process
    begin
        -- Initial wait to ensure memory initialization
        wait for 100 ns; -- Wait for initialization to complete

        -- Test case 1: Read from address 0
        a <= "000000"; -- Address 0
        wait for clk_period;
        assert (rd = X"00000000") -- Expected value from instructions.txt
            report "Error: Data read from address 0 is not correct"
            severity error;

        -- Test case 2: Read from address 1
        a <= "000001"; -- Address 1
        wait for clk_period;
        assert (rd = X"00000001") -- Expected value from instructions.txt
            report "Error: Data read from address 1 is not correct"
            severity error;

        -- Test case 3: Read from address 2
        a <= "000010"; -- Address 2
        wait for clk_period;
        assert (rd = X"00000002") -- Expected value from instructions.txt
            report "Error: Data read from address 2 is not correct"
            severity error;

        -- Add more test cases if necessary

        -- End of simulation
        report "Simulation finished successfully";
        wait;
    end process;

end behavior;