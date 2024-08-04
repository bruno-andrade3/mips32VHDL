library ieee;
use ieee.std_logic_1164.all;

entity alu_decoder is
    port (
        funct: in std_ulogic_vector(5 downto 0);
        aluop: in std_ulogic_vector(1 downto 0);
        alu_control: out std_ulogic_vector(2 downto 0));
end alu_decoder;

architecture behavioral of alu_decoder is
begin
    process(aluop, funct)
    begin
        case aluop is 
            when "00" => alu_control <= "010"; -- addition
            when "01" => alu_control <= "110"; -- subtraction
            when others => -- look at funct
                case funct is
                    when "100000" => -- add
                        alu_control <= "010";
                    when "100010" => -- subtract
                        alu_control <= "110";
                    when "100100" => -- and
                        alu_control <= "000";
                    when "100101" => -- or
                        alu_control <= "001";
                    when "101010" => -- set less than
                        alu_control <= "111";
                    when others => -- undefined
                        alu_control <= (others => '0');
                end case;
        end case;
    end process;
end behavioral;