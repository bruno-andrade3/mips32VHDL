library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity alu is
    port (
        a, b:          in  std_logic_vector(31 downto 0);
        alu_control:   in  std_logic_vector(2 downto 0);
        alu_result:    out std_logic_vector(31 downto 0);
        zero:          out std_logic
        );
end alu;

architecture behavioral of alu is
begin
    process (a, b, alu_control)
    begin
        case alu_control is
            when "000" => -- addition
                alu_result <= a + b;
            when "001" => -- subtraction
                alu_result <= a - b;
            when "010" => -- bitwise and
                alu_result <= a and b;
            when "011" => -- bitwise or
                alu_result <= a or b;
            when "100" => -- bitwise xor
                alu_result <= a xor b;
            when "101" => -- shift left
                alu_result <= a sll 1;
            when "110" => -- shift right
                alu_result <= a srl 1;
            when "111" => -- shift right arithmetic
                alu_result <= a sra 1;
            when others => -- undefined
                alu_result <= (others => 'X');
        end case;
        zero <= '1' when alu_result = (others => '0') else '0';
    end process;
end behavioral;