library ieee;
use ieee.std_logic_1164.all;

entity tb_controller is
end tb_controller;

architecture test of tb_controller is
    signal opcode      : std_ulogic_vector(5 downto 0);
    signal funct       : std_ulogic_vector(5 downto 0);
    signal zero        : std_ulogic;
    signal memtoreg    : std_ulogic;
    signal memwrite    : std_ulogic;
    signal pcsrc       : std_ulogic;
    signal alusrc      : std_ulogic;
    signal regdst      : std_ulogic;
    signal regwrite    : std_ulogic;
    signal jump        : std_ulogic;
    signal alu_control : std_ulogic_vector(2 downto 0);

    -- Instantiate the controller
    component controller
        port (
            opcode      : in  std_ulogic_vector(5 downto 0);
            funct       : in  std_ulogic_vector(5 downto 0);
            zero        : in  std_ulogic;
            memtoreg    : out std_ulogic;
            memwrite    : out std_ulogic;
            pcsrc       : out std_ulogic;
            alusrc      : out std_ulogic;
            regdst      : out std_ulogic;
            regwrite    : out std_ulogic;
            jump        : out std_ulogic;
            alu_control : out std_ulogic_vector(2 downto 0)
        );
    end component;

begin
    uut: controller
        port map (
            opcode      => opcode,
            funct       => funct,
            zero        => zero,
            memtoreg    => memtoreg,
            memwrite    => memwrite,
            pcsrc       => pcsrc,
            alusrc      => alusrc,
            regdst      => regdst,
            regwrite    => regwrite,
            jump        => jump,
            alu_control => alu_control
        );

    -- Test procedure
    process
    begin
        -- Test ADD (opcode = 000000, funct = 100000)
        opcode <= "000000";
        funct <= "100000";
        zero <= '0';
        wait for 100 ns;

        -- Test SUB (opcode = 000000, funct = 100010)
        funct <= "100010";
        wait for 100 ns;

        -- Test AND (opcode = 000000, funct = 100100)
        funct <= "100100";
        wait for 100 ns;

        -- Test OR (opcode = 000000, funct = 100101)
        funct <= "100101";
        wait for 100 ns;

        -- Test SLT (opcode = 000000, funct = 101010)
        funct <= "101010";
        wait for 100 ns;

        -- Test LW (opcode = 100011)
        opcode <= "100011";
        wait for 100 ns;

        -- Test SW (opcode = 101011)
        opcode <= "101011";
        wait for 100 ns;

        -- Test SLL (opcode = 000000, funct = 000000)
        opcode <= "000000";
        funct <= "000000";
        wait for 100 ns;

        -- Test J (opcode = 000010)
        opcode <= "000010";
        wait for 100 ns;

        -- End of simulation
        wait;
    end process;

end architecture;
