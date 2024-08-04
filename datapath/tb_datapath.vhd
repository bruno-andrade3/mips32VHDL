library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity tb_datapath is
    -- Testbench entity does not have ports
end tb_datapath;

architecture behavior of tb_datapath is

    -- Signal declarations for testbench
    signal clock : std_logic := '0';  -- Clock signal initialized to '0'
    signal reset : std_logic := '1';  -- Reset signal initialized to '1'
    signal memtoreg, pcsrc : std_logic := '0';  -- Control signals, initially '0'
    signal alusrc, regdst : std_logic := '0';   -- Control signals, initially '0'
    signal regwrite, jump : std_logic := '0';   -- Control signals, initially '0'
    signal alu_control : std_logic_vector(2 downto 0) := (others => '0'); -- ALU control signal, initialized to '000'
    signal zero : std_logic;  -- ALU zero flag output
    signal pc : std_logic_vector(31 downto 0); -- Program Counter (PC) output
    signal instruction : std_logic_vector(31 downto 0) := (others => '0'); -- Instruction input, initialized to '0'
    signal alu_out, write_data : std_logic_vector(31 downto 0); -- ALU output and write data
    signal read_data : std_logic_vector(31 downto 0) := (others => '0'); -- Read data input, initialized to '0'

    constant clk_period : time := 20 ns; -- Clock period

    -- Component under test: datapath
    component datapath
        port (
            clock, reset : in std_logic;
            memtoreg, pcsrc : in std_logic;
            alusrc, regdst : in std_logic;
            regwrite, jump : in std_logic;
            alu_control : in std_logic_vector(2 downto 0);
            zero : out std_logic;
            pc : out std_logic_vector(31 downto 0);
            instruction : in std_logic_vector(31 downto 0);
            alu_out, write_data : out std_logic_vector(31 downto 0);
            read_data : in std_logic_vector(31 downto 0)
        );
    end component;

begin

    -- Clock generation process
    clk_process : process
    begin
        -- Generate a clock signal with a period of 20 ns (50 MHz)
        while true loop
            clock <= '0';  -- Toggle clock
            wait for clk_period / 2;  -- Wait for half the clock period
            clock <= '1';  -- Toggle clock
            wait for clk_period / 2;  -- Wait for the other half of the clock period
        end loop;
    end process;

    -- Testbench process
    stim_proc : process
    begin
        -- Initialize signals
        reset <= '1';  -- Assert reset
        wait for clk_period; -- Wait for reset to propagate
        reset <= '0';  -- De-assert reset

        -- Test vector 1: Basic Arithmetic Operation
        instruction <= X"2002000A";  -- Example instruction: addi $2, $0, 10 (add immediate)
        read_data <= X"00000010";    -- Example read data: 16
        regwrite <= '1';  -- Enable register write
        memtoreg <= '0';  -- Use ALU result, not memory
        pcsrc <= '0';     -- No branch
        alusrc <= '1';    -- ALU source is the immediate value
        regdst <= '0';    -- Write to the register specified by instruction(20 downto 16)
        jump <= '0';      -- No jump
        alu_control <= "010"; -- ALU control for ADD operation
        
        -- Wait to observe results
        wait for 5 * clk_period;
        
        -- Test vector 2: Memory to Register
        instruction <= X"8C220000";  -- Example instruction: lw $2, 0($1) (load word)
        read_data <= X"00000020";    -- Example read data: 32
        regwrite <= '1';  -- Enable register write
        memtoreg <= '1';  -- Use memory data
        pcsrc <= '0';     -- No branch
        alusrc <= '0';    -- ALU source is from registers
        regdst <= '1';    -- Write to the register specified by instruction(15 downto 11)
        jump <= '0';      -- No jump
        alu_control <= "000"; -- ALU control for ADD operation (to calculate address)
        
        -- Wait to observe results
        wait for 5 * clk_period;
        
        -- Test vector 3: Branch Instruction
        instruction <= X"10010002";  -- Example instruction: beq $1, $2, 2 (branch if equal)
        read_data <= X"00000000";    -- Example read data: not used
        regwrite <= '0';  -- Disable register write
        memtoreg <= '0';  -- Use ALU result
        pcsrc <= '1';     -- Branch taken
        alusrc <= '0';    -- ALU source is from registers
        regdst <= '0';    -- Not writing to a register
        jump <= '0';      -- No jump
        alu_control <= "110"; -- ALU control for SUB operation to compare registers
        
        -- Wait to observe results
        wait for 5 * clk_period;
        
        -- Test vector 4: Jump Instruction
        instruction <= X"0800000A";  -- Example instruction: j 10 (jump to address 10)
        read_data <= X"00000000";    -- Example read data: not used
        regwrite <= '0';  -- Disable register write
        memtoreg <= '0';  -- Use ALU result
        pcsrc <= '0';     -- No branch
        alusrc <= '0';    -- ALU source is from registers
        regdst <= '0';    -- Not writing to a register
        jump <= '1';      -- Perform jump
        alu_control <= "000"; -- ALU control for ADD operation (not used here)
        
        -- Wait to observe results
        wait for 5 * clk_period;

        -- Test vector 5: Edge Case - Zero Input
        instruction <= X"00000000";  -- NOP (No Operation) instruction
        read_data <= X"00000000";    -- Read data is zero
        regwrite <= '0';  -- Disable register write
        memtoreg <= '0';  -- Use ALU result
        pcsrc <= '0';     -- No branch
        alusrc <= '0';    -- ALU source is from registers
        regdst <= '0';    -- Not writing to a register
        jump <= '0';      -- No jump
        alu_control <= "000"; -- ALU control for ADD operation (not used here)
        
        -- Wait to observe results
        wait for 5 * clk_period;

        -- End of simulation
        report "Simulation finished successfully";
        wait for 10 * clk_period;  -- Wait for a few more cycles
        std.env.stop;  -- Stop the simulation
    end process;

    -- Instantiate the datapath component
    uut: datapath
        port map (
            clock => clock,          -- Connect clock signal
            reset => reset,          -- Connect reset signal
            memtoreg => memtoreg,    -- Connect memtoreg control signal
            pcsrc => pcsrc,          -- Connect pcsrc control signal
            alusrc => alusrc,        -- Connect alusrc control signal
            regdst => regdst,        -- Connect regdst control signal
            regwrite => regwrite,    -- Connect regwrite control signal
            jump => jump,            -- Connect jump control signal
            alu_control => alu_control, -- Connect ALU control signal
            zero => zero,            -- Connect zero output from ALU
            pc => pc,                -- Connect PC output
            instruction => instruction, -- Connect instruction input
            alu_out => alu_out,      -- Connect ALU output
            write_data => write_data, -- Connect write data
            read_data => read_data   -- Connect read data input
        );

end behavior;