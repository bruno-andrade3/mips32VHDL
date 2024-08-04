library ieee;
use ieee.std_logic_1164.all;

entity controller is
    port (
        opcode      : in  std_ulogic_vector(5 downto 0);
        funct       : in  std_ulogic_vector(5 downto 0);
        zero        : in  std_ulogic;
        memtoreg, memwrite    : out std_ulogic;
        pcsrc, alusrc       : out std_ulogic;
        regdst, regwrite      : out std_ulogic;
        jump        : out std_ulogic;
        alu_control : out std_ulogic_vector(2 downto 0)
    );
end controller;

architecture struct of controller is
    component main_decoder
        port (
            opcode      : in std_ulogic_vector(5 downto 0);
            memtoreg,memwrite    : out std_ulogic;
            branch, alusrc      : out std_ulogic;
            regdst, regwrite      : out std_ulogic;
            jump        : out std_ulogic;
            aluop       : out std_ulogic_vector(1 downto 0)
        );
    end component;

    component alu_decoder
        port (
            funct       : in std_ulogic_vector(5 downto 0);
            aluop       : in std_ulogic_vector(1 downto 0);
            alu_control : out std_ulogic_vector(2 downto 0)
        );
    end component;

    signal aluop   : std_ulogic_vector(1 downto 0);
    signal branch  : std_ulogic;

begin
    md: main_decoder port map ( opcode, memtoreg, memwrite, branch, alusrc, 
    regdst, regwrite, jump, aluop );

    ad: alu_decoder port map ( funct, aluop, alu_control );

    pcsrc <= branch and zero;

end architecture;
