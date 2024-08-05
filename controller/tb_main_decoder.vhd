library ieee;
use ieee.std_logic_1164.all;

entity tb_main_decoder is
end tb_main_decoder;

architecture behavior of tb_main_decoder is
    -- Component Declaration
    component main_decoder
        port (
            opcode            : in  std_logic_vector(5 downto 0);
            memtoreg, memwrite : out std_logic;
            branch, alusrc    : out std_logic;
            regdst, regwrite  : out std_logic;
            jump              : out std_logic;
            aluop             : out std_logic_vector(1 downto 0)
        );
    end component;

    -- Signals
    signal opcode            : std_logic_vector(5 downto 0);
    signal memtoreg, memwrite : std_logic;
    signal branch, alusrc    : std_logic;
    signal regdst, regwrite  : std_logic;
    signal jump              : std_logic;
    signal aluop             : std_logic_vector(1 downto 0);

begin
    -- Instantiate the Unit Under Test (UUT)
    uut: main_decoder
        port map (
            opcode            => opcode,
            memtoreg          => memtoreg,
            memwrite          => memwrite,
            branch            => branch,
            alusrc            => alusrc,
            regdst            => regdst,
            regwrite          => regwrite,
            jump              => jump,
            aluop             => aluop
        );

    -- Test process
    process
    begin
        -- Test R-type instruction (opcode = "000000")
        opcode <= "000000";
        wait for 100 ns;

        -- Test lw instruction (opcode = "100011")
        opcode <= "100011";
        wait for 100 ns;

        -- Test sw instruction (opcode = "101011")
        opcode <= "101011";
        wait for 100 ns;

        -- Test beq instruction (opcode = "000100")
        opcode <= "000100";
        wait for 100 ns;

        -- Test addi instruction (opcode = "001000")
        opcode <= "001000";
        wait for 100 ns;

        -- Test jump instruction (opcode = "000010")
        opcode <= "000010";
        wait for 100 ns;

        -- End of test
        wait;
    end process;

end behavior;
