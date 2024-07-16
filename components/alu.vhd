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
            when "010" => -- addition
                alu_result <= a + b;
            when "110" => -- subtraction
                alu_result <= a - b;
            when "000" => -- bitwise and
                alu_result <= a and b;
            when "001" => -- bitwise or
                alu_result <= a or b;
            when "111" => -- set less than
                alu_result <= '1' when signed(a) < signed(b) else '0';
            when "011" => -- multiply
                alu_result <= a * b;
            when others => -- undefined
                alu_result <= (others => 'X');
        end case;
        zero <= '1' when alu_result = (others => '0') else '0';
    end process;
end behavioral;