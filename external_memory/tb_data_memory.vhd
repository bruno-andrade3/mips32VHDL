library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity tb_data_memory is
end tb_data_memory;

architecture behavior of tb_data_memory is

    -- Testbench signals
    signal clock        : std_logic := '0';          -- Clock signal
    signal write_enable : std_logic := '0';          -- Write enable signal
    signal alu_out      : std_logic_vector(31 downto 0) := (others => '0'); -- Address
    signal write_data   : std_logic_vector(31 downto 0) := (others => '0'); -- Data to write
    signal read_data    : std_logic_vector(31 downto 0); -- Data read from memory

    -- Component under test: data_memory
    component data_memory
        port (
            clock        : in  std_logic;
            write_enable : in  std_logic;
            alu_out      : in  std_logic_vector(31 downto 0);
            write_data   : in  std_logic_vector(31 downto 0);
            read_data    : out std_logic_vector(31 downto 0)
        );
    end component;

    constant clk_period : time := 20 ns; -- Clock period
    constant num_cycles : integer := 10; -- Number of cycles to run the test

begin

    -- Clock generation process
    clk_process : process
        variable cycle_count : integer := 0;
    begin
        while cycle_count < num_cycles loop
            clock <= '0';
            wait for clk_period / 2;
            clock <= '1';
            wait for clk_period / 2;
            cycle_count := cycle_count + 1;
        end loop;
        -- End simulation
        report "Simulation finished successfully";
        std.env.stop; -- Stop the simulation
    end process;

    -- Testbench stimulus process
    stim_proc : process
    begin
        -- Initialize signals
        write_enable <= '0';  -- Start with no write operation
        alu_out <= X"00000000"; -- Start address 0
        write_data <= X"00000000"; -- Write data 0

        -- Wait for a few clock cycles
        wait for 2 * clk_period;

        -- Test write operation
        write_enable <= '1'; -- Enable write
        alu_out <= X"00000001"; -- Address 1
        write_data <= X"DEADBEEF"; -- Data to write

        -- Wait for the write operation to complete
        wait for clk_period;

        -- Disable write and check read data
        write_enable <= '0'; -- Disable write
        alu_out <= X"00000001"; -- Read from address 1

        -- Wait to observe the read operation
        wait for clk_period;

        -- Check read data
        assert (read_data = X"DEADBEEF")
            report "Error: Data read from address 1 is not correct"
            severity error;

        -- Test writing to a different address
        write_enable <= '1'; -- Enable write
        alu_out <= X"00000002"; -- Address 2
        write_data <= X"12345678"; -- Data to write

        -- Wait for the write operation to complete
        wait for clk_period;

        -- Disable write and check read data at address 2
        write_enable <= '0'; -- Disable write
        alu_out <= X"00000002"; -- Read from address 2

        -- Wait to observe the read operation
        wait for clk_period;

        -- Check read data
        assert (read_data = X"12345678")
            report "Error: Data read from address 2 is not correct"
            severity error;

        -- End of simulation
        report "Simulation finished successfully";
        wait; -- Wait to end the simulation
    end process;

    -- Instantiate the data_memory component
    uut: data_memory
        port map (
            clock        => clock,
            write_enable => write_enable,
            alu_out      => alu_out,
            write_data   => write_data,
            read_data    => read_data
        );

end behavior;