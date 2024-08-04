library ieee;
use ieee.std_logic_1164.all;

entity tb_main_decoder is
end tb_main_decoder;

architecture behavior of tb_main_decoder is
    -- Component Declaration
    component main_decoder
        port (
            opcode            : in  std_ulogic_vector(5 downto 0);
            memtoreg, memwrite : out std_ulogic;
            branch, alusrc    : out std_ulogic;
            regdst, regwrite  : out std_ulogic;
            jump              : out std_ulogic;
            aluop             : out std_ulogic_vector(1 downto 0)
        );
    end component;

    -- Signals
    signal opcode            : std_ulogic_vector(5 downto 0);
    signal memtoreg, memwrite : std_ulogic;
    signal branch, alusrc    : std_ulogic;
    signal regdst, regwrite  : std_ulogic;
    signal jump              : std_ulogic;
    signal aluop             : std_ulogic_vector(1 downto 0);

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
        assert (memtoreg = '0') report "Failed R-type memtoreg" severity error;
        assert (memwrite = '0') report "Failed R-type memwrite" severity error;
        assert (branch = '0') report "Failed R-type branch" severity error;
        assert (alusrc = '0') report "Failed R-type alusrc" severity error;
        assert (regdst = '1') report "Failed R-type regdst" severity error;
        assert (regwrite = '1') report "Failed R-type regwrite" severity error;
        assert (aluop = "11") report "Failed R-type aluop" severity error;
        assert (jump = '0') report "Failed R-type jump" severity error;

        -- Test lw instruction (opcode = "100011")
        opcode <= "100011";
        wait for 100 ns;
        assert (memtoreg = '1') report "Failed lw memtoreg" severity error;
        assert (memwrite = '0') report "Failed lw memwrite" severity error;
        assert (branch = '0') report "Failed lw branch" severity error;
        assert (alusrc = '1') report "Failed lw alusrc" severity error;
        assert (regdst = '0') report "Failed lw regdst" severity error;
        assert (regwrite = '1') report "Failed lw regwrite" severity error;
        assert (aluop = "00") report "Failed lw aluop" severity error;
        assert (jump = '0') report "Failed lw jump" severity error;

        -- Test sw instruction (opcode = "101011")
        opcode <= "101011";
        wait for 100 ns;
        assert (memtoreg = '0') report "Failed sw memtoreg" severity error;
        assert (memwrite = '1') report "Failed sw memwrite" severity error;
        assert (branch = '0') report "Failed sw branch" severity error;
        assert (alusrc = '1') report "Failed sw alusrc" severity error;
        assert (regdst = '0') report "Failed sw regdst" severity error;
        assert (regwrite = '0') report "Failed sw regwrite" severity error;
        assert (aluop = "00") report "Failed sw aluop" severity error;
        assert (jump = '0') report "Failed sw jump" severity error;

        -- Test beq instruction (opcode = "000100")
        opcode <= "000100";
        wait for 100 ns;
        assert (memtoreg = '0') report "Failed beq memtoreg" severity error;
        assert (memwrite = '0') report "Failed beq memwrite" severity error;
        assert (branch = '1') report "Failed beq branch" severity error;
        assert (alusrc = '0') report "Failed beq alusrc" severity error;
        assert (regdst = '0') report "Failed beq regdst" severity error;
        assert (regwrite = '0') report "Failed beq regwrite" severity error;
        assert (aluop = "01") report "Failed beq aluop" severity error;
        assert (jump = '0') report "Failed beq jump" severity error;

        -- Test addi instruction (opcode = "001000")
        opcode <= "001000";
        wait for 100 ns;
        assert (memtoreg = '0') report "Failed addi memtoreg" severity error;
        assert (memwrite = '0') report "Failed addi memwrite" severity error;
        assert (branch = '0') report "Failed addi branch" severity error;
        assert (alusrc = '1') report "Failed addi alusrc" severity error;
        assert (regdst = '0') report "Failed addi regdst" severity error;
        assert (regwrite = '1') report "Failed addi regwrite" severity error;
        assert (aluop = "00") report "Failed addi aluop" severity error;
        assert (jump = '0') report "Failed addi jump" severity error;

        -- Test jump instruction (opcode = "000010")
        opcode <= "000010";
        wait for 100 ns;
        assert (memtoreg = '0') report "Failed jump memtoreg" severity error;
        assert (memwrite = '0') report "Failed jump memwrite" severity error;
        assert (branch = '0') report "Failed jump branch" severity error;
        assert (alusrc = '0') report "Failed jump alusrc" severity error;
        assert (regdst = '0') report "Failed jump regdst" severity error;
        assert (regwrite = '0') report "Failed jump regwrite" severity error;
        assert (aluop = "00") report "Failed jump aluop" severity error;
        assert (jump = '1') report "Failed jump jump" severity error;

        -- End of test
        wait;
    end process;

end behavior;
