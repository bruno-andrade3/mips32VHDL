library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use std.textio.all;

entity instruction_memory is
    port (
        a  : in std_logic_vector(5 downto 0);
        rd : out std_logic_vector(31 downto 0)
    );
end instruction_memory;

architecture behave of instruction_memory is
begin
    process is
        file mem_file : TEXT;
        variable line : line;
        variable char : character;
        variable index, result : integer;
        type ram_type is array(0 to 63) of std_logic_vector(31 downto 0);
        variable mem : ram_type;
    begin
        --initialize memory from file
        for i in 0 to 63 loop --set al contents low
            mem(to_integer(unsigned(i))) := (others => '0');
        end loop;
        index := 0;
        file_open(mem_file, "instructions.txt", read_mode);
        while not endfile(mem_file) loop
            readline(mem_file, line);
            result := 0;
            for i in 1 to 8 loop
                read(line, char);
                if '0' <= char and char <= '9' then
                    result := result * 16 + (character'pos(char) - character'pos('0'));
                elsif 'A' <= char and char <= 'F' then
                    result := result * 16 + (character'pos(char) - character'pos('A') + 10);
                else --error
                    report "Format error on line" & integer'image(index) severity error;
                end if;
            end loop;
            mem(index) := std_logic_vector(to_unsigned(result, 32));
            index := index + 1;
        end loop;
        --read memory
        loop
            rd <= mem(to_integer(unsigned(a)));
            wait on a;
        end loop;
    end process;
end behave;