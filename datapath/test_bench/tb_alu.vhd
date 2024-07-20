library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

-- Testbench entity (no ports)
entity tb_alu is
end tb_alu;

architecture behavior of tb_alu is
    -- Component declaration for the ALU
    component alu
        port (
            a, b:          in  std_logic_vector(31 downto 0);
            alu_control:   in  std_logic_vector(2 downto 0);
            alu_result:    out std_logic_vector(31 downto 0);
            zero:          out std_logic
        );
    end component;

    -- Signals for connecting to the ALU
    signal a, b:          std_logic_vector(31 downto 0);
    signal alu_control:   std_logic_vector(2 downto 0);
    signal alu_result:    std_logic_vector(31 downto 0);
    signal zero:          std_logic;

begin
    -- Instantiate the ALU
    uut: alu
        port map (
            a => a,
            b => b,
            alu_control => alu_control,
            alu_result => alu_result,
            zero => zero
        );

    -- Process for stimulus generation
    stim_proc: process
    begin
        -- Test case 1: bitwise AND
        a <= x"0000000F"; -- 15
        b <= x"00000003"; -- 3
        alu_control <= "000"; -- AND
        wait for 10 ns;
        assert (alu_result = x"00000003") report "Error in AND operation" severity error;

        -- Test case 2: bitwise OR
        a <= x"0000000F"; -- 15
        b <= x"00000003"; -- 3
        alu_control <= "001"; -- OR
        wait for 10 ns;
        assert (alu_result = x"0000000F") report "Error in OR operation" severity error;

        -- Test case 3: addition
        a <= x"00000005"; -- 5
        b <= x"00000003"; -- 3
        alu_control <= "010"; -- ADD
        wait for 10 ns;
        assert (alu_result = x"00000008") report "Error in ADD operation" severity error;

        -- Test case 4: subtraction
        a <= x"00000005"; -- 5
        b <= x"00000003"; -- 3
        alu_control <= "110"; -- SUB
        wait for 10 ns;
        assert (alu_result = x"00000002") report "Error in SUB operation" severity error;

        -- Test case 5: set less than
        a <= x"00000005"; -- 5
        b <= x"00000010"; -- 16
        alu_control <= "111"; -- SLT
        wait for 10 ns;
        assert (alu_result = x"00000001") report "Error in SLT operation" severity error;

        -- End simulation
        wait;
    end process;

end behavior;