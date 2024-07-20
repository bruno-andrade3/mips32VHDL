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
        variable temp_result: std_logic_vector(31 downto 0);
    begin
        -- Default result and zero flag
        temp_result := (others => '0');
        zero <= '0';

        -- Compute ALU result based on control signals
        case alu_control is
            when "000" => -- bitwise AND
                temp_result := a and b;
            when "001" => -- bitwise OR
                temp_result := a or b;
            when "010" => -- addition
                temp_result := std_logic_vector(unsigned(a) + unsigned(b));
            when "110" => -- subtraction
                temp_result := std_logic_vector(unsigned(a) - unsigned(b));
            when "111" => -- set less than
                if signed(a) < signed(b) then
                    temp_result := (others => '0');
                    temp_result(0) := '1';
                else
                    temp_result := (others => '0');
                end if;
            when others =>
                temp_result := (others => '0');
        end case;

        -- Assign result to the output port
        alu_result <= temp_result;

        -- Set zero flag
        if temp_result = x"00000000" then
            zero <= '1';
        else
            zero <= '0';
        end if;
    end process;

end behavioral;