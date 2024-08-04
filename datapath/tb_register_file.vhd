library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity tb_register_file is
end tb_register_file;

architecture behavior of tb_register_file is

    -- Component Declaration for the Unit Under Test (UUT)
    component register_file is
        port(
            clk: in std_logic;
            we3: in std_logic;
            ra1, ra2, wa3: in std_logic_vector(4 downto 0);
            wd3: in std_logic_vector(31 downto 0);
            rd1, rd2: out std_logic_vector(31 downto 0)
        );
    end component;

    -- Signals to connect to UUT
    signal clk : std_logic := '0';
    signal we3 : std_logic := '0';
    signal ra1, ra2, wa3 : std_logic_vector(4 downto 0) := (others => '0');
    signal wd3 : std_logic_vector(31 downto 0) := (others => '0');
    signal rd1, rd2 : std_logic_vector(31 downto 0);

    constant clk_period : time := 10 ns;

begin

    -- Instantiate the Unit Under Test (UUT)
    uut: register_file
        port map (
            clk => clk,
            we3 => we3,
            ra1 => ra1,
            ra2 => ra2,
            wa3 => wa3,
            wd3 => wd3,
            rd1 => rd1,
            rd2 => rd2
        );

    -- Clock process definitions
    clk_process : process
    begin
        while true loop
            clk <= '0';
            wait for clk_period / 2;
            clk <= '1';
            wait for clk_period / 2;
        end loop;
    end process;

    -- Process to apply stimulus and check results
    stim_proc: process
    begin
        -- Initialize Inputs
        wait for clk_period;

        -- Test case 1: Write to register 1 and read
        we3 <= '1';
        wa3 <= "00001";
        wd3 <= x"00000001";
        wait for clk_period;
        
        -- Read from register 1
        we3 <= '0';
        ra1 <= "00001";
        wait for clk_period * 2; -- Wait for 2 clock cycles to ensure data is stable
        assert (rd1 = x"00000001") report "Error: rd1 should be 00000001 when reading from register 1" severity error;

        -- Test case 2: Write to register 2 and read
        we3 <= '1';
        wa3 <= "00010";
        wd3 <= x"00000002";
        wait for clk_period;

        -- Read from register 2
        we3 <= '0';
        ra2 <= "00010";
        wait for clk_period * 2; -- Wait for 2 clock cycles to ensure data is stable
        assert (rd2 = x"00000002") report "Error: rd2 should be 00000002 when reading from register 2" severity error;

        -- Test case 3: Read from register 0
        ra1 <= "00000";
        wait for clk_period * 2; -- Wait for 2 clock cycles to ensure data is stable
        assert (rd1 = x"00000000") report "Error: rd1 should be 00000000 when reading from register 0" severity error;

        -- Test case 4: Overwrite register 1
        we3 <= '1';
        wa3 <= "00001";
        wd3 <= x"00000003";
        wait for clk_period;

        -- Read from register 1 again
        we3 <= '0';
        ra1 <= "00001";
        wait for clk_period * 2; -- Wait for 2 clock cycles to ensure data is stable
        assert (rd1 = x"00000003") report "Error: rd1 should be 00000003 when reading from register 1 after overwrite" severity error;

        -- End of simulation
        report "Simulation finished successfully";
        wait for 10 * clk_period;  -- Wait for a few more cycles to ensure all signals are stable
        std.env.stop;  -- Stop the simulation
    end process;

end behavior;