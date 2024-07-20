library ieee;
use ieee.std_logic_1164.all;

entity controller is -- controller for the single cycle processor
    port (
        opcode            : in  std_logic_vector(5 downto 0);
        funct             : in  std_logic_vector(5 downto 0);
        zero              : in  std_logic;
        memtoreg, memwrite : out std_logic;
        pcsrc, alusrc     : out std_logic;
        regdst, regwrite  : out std_logic;
        jump              : out std_logic;
        alu_control       : out std_logic_vector(2 downto 0));
end controller;

architecture struct of controller is
    component main_decoder
        port (
            opcode            : in std_logic_vector(5 downto 0);
            memtoreg, memwrite : out std_logic;
            branch, alusrc    : out std_logic;
            regdst, regwrite  : out std_logic;
            jump              : out std_logic;
            aluop             : out std_logic_vector(1 downto 0));
    end component;

    component alu_decoder
        port (
            funct: in std_logic_vector(5 downto 0);
            aluop: in std_logic_vector(1 downto 0);
            alu_control: out std_logic_vector(2 downto 0));
    end component;

    signal aluop: std_logic_vector(1 downto 0);
    signal branch: std_logic;

begin
    md: main_decoder port map ( opcode, memtoreg, memwrite, branch, alusrc, regdst, regwrite, jump, aluop );
    ad: alu_decoder port map ( funct, aluop, alu_control );

    pcsrc <= branch and zero;

end architecture;