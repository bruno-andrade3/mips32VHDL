library ieee;
use ieee.std_logic_1164.all;

entity main_decoder is
    port (
        opcode            : in std_logic_vector(5 downto 0);
        memtoreg, memwrite : out std_logic;
        branch, alusrc    : out std_logic;
        regdst, regwrite  : out std_logic;
        jump              : out std_logic;
        aluop             : out std_logic_vector(1 downto 0)

    );
end main_decoder;

architecture behavioral of main_decoder is
    signal controls: std_logic_vector(8 downto 0);
begin
    process(opcode)
    begin
        case opcode is
            when "000000" => -- R-type
                controls <= "110000100";
            when "100011" => -- lw
                controls <= "101001000";
            when "101011" => -- sw
                controls <= "001010000";
            when "000100" => -- beq
                controls <= "000100010";
            when "001000" => -- addi
                controls <= "101000000"
            when "000010" => -- jump
                controls <= "000000001";
            when "000011" => -- jal
                controls <= "101000001"
            when others => -- undefined
                controls <= "000000000";
        end case;
    end process;

    regwrite <= controls(0);
    regdst <= controls(1);
    alusrc <= controls(2);
    branch <= controls(3);
    memwrite <= controls(4);
    memtoreg <= controls(5);
    aluop <= controls(6 downto 7);
    jump <= controls(8);
end behavioral;