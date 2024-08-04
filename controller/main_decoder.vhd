library ieee;
use ieee.std_logic_1164.all;

entity main_decoder is
    port (
        opcode            : in std_ulogic_vector(5 downto 0);
        memtoreg, memwrite : out std_ulogic;
        branch, alusrc    : out std_ulogic;
        regdst, regwrite  : out std_ulogic;
        jump              : out std_ulogic;
        aluop             : out std_ulogic_vector(1 downto 0)

    );
end main_decoder;

architecture behavioral of main_decoder is
    signal controls: std_ulogic_vector(8 downto 0);
begin
    process(opcode)
    begin
        controls <= (others => '0'); -- valor padrão

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
                controls <= "101000000";
            when "000010" => -- jump
                controls <= "000000001";
            when "000011" => -- jal
                controls <= "101000001";
            when others => -- undefined
                controls <= "000000000";
        end case;
    end process;

    regwrite <= controls(8);
    regdst <= controls(7);
    alusrc <= controls(6);
    branch <= controls(5);
    memwrite <= controls(4);
    memtoreg <= controls(3);
    aluop (1 downto 0) <= controls(2 downto 1);
    jump <= controls(0);
end behavioral;