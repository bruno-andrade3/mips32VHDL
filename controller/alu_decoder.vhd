library ieee;
use ieee.std_logic_1164.all;

entity alu_decoder is
    port (
        funct: in std_logic_vector(5 downto 0);
        aluop: in std_logic_vector(1 downto 0);
        alu_control: out std_logic_vector(2 downto 0));
end alu_decoder;

architecture behavioral of alu_decoder is
begin
    process(aluop, funct)
    begin
        case aluop is 
            --TODO
        end case;
    end process;
end behavioral;