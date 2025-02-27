library ieee;
use ieee.std_logic_1164.all;

entity tb_alu_decoder is
end tb_alu_decoder;

architecture testbench of tb_alu_decoder is
    -- Component declaration
    component alu_decoder
        port (
            funct: in std_logic_vector(5 downto 0);
            aluop: in std_logic_vector(1 downto 0);
            alu_control: out std_logic_vector(2 downto 0)
        );
    end component;

    -- Signals for connecting to the Unit Under Test (UUT)
    signal funct: std_logic_vector(5 downto 0);
    signal aluop: std_logic_vector(1 downto 0);
    signal alu_control: std_logic_vector(2 downto 0);

begin
    -- Instantiate the Unit Under Test (UUT)
    uut: alu_decoder
        port map (
            funct => funct,
            aluop => aluop,
            alu_control => alu_control
        );

    -- Test Process
    process
    begin
        -- Test Case 1: aluop = "00" (Addition)
        aluop <= "00";
        funct <= "000000"; -- funct doesn't matter
        wait for 10 ns;

        -- Test Case 2: aluop = "01" (Subtraction)
        aluop <= "01";
        funct <= "000000"; -- funct doesn't matter
        wait for 10 ns;

        -- Test Case 3: aluop = "10", funct = "100000" (Addition)
        aluop <= "10";
        funct <= "100000";
        wait for 10 ns;

        -- Test Case 4: aluop = "10", funct = "100010" (Subtraction)
        aluop <= "10";
        funct <= "100010";
        wait for 10 ns;

        -- Test Case 5: aluop = "10", funct = "100100" (AND)
        aluop <= "10";
        funct <= "100100";
        wait for 10 ns;

        -- Test Case 6: aluop = "10", funct = "100101" (OR)
        aluop <= "10";
        funct <= "100101";
        wait for 10 ns;

        -- Test Case 7: aluop = "10", funct = "101010" (SLT)
        aluop <= "10";
        funct <= "101010";
        wait for 10 ns;

        -- Test Case 8: aluop = "10", funct = "101011" (MULT)
        aluop <= "10";
        funct <= "101011";
        wait for 10 ns;
        
        wait;
    end process;
end testbench;
