library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use std.textio.all;

entity instruction_memory is
    port (
        clk : in std_logic;                     -- Clock input
        a   : in std_logic_vector(5 downto 0); -- Address input
        rd  : out std_logic_vector(31 downto 0) -- Data output
    );
end instruction_memory;

architecture behave of instruction_memory is
    type ram_type is array(0 to 63) of std_logic_vector(31 downto 0);
    signal mem : ram_type;
    signal mem_init_done : boolean := false; -- Signal to indicate initialization completion
begin
    -- Process to initialize memory from file
    process (clk)
        file mem_file : text open read_mode is "instructions.txt";
        variable file_line : line;
        variable hex_str : string(1 to 8);
        variable result : integer;
        variable index : integer := 0;
        variable char : character;
    begin
        if rising_edge(clk) then
            if not mem_init_done then
                -- Initialize memory with zeros
                for mem_index in 0 to 63 loop
                    mem(mem_index) <= (others => '0');
                end loop;

                -- Read lines from the file and initialize memory
                while not endfile(mem_file) loop
                    readline(mem_file, file_line);
                    hex_str := (others => ' ');

                    -- Read characters into hex_str
                    for i in 1 to 8 loop
                        if not endfile(mem_file) then
                            read(file_line, char);
                            hex_str(i) := char;
                        else
                            exit;
                        end if;
                    end loop;

                    -- Convert hex_str to integer
                    result := 0;
                    for hex_index in 1 to 8 loop
                        case hex_str(hex_index) is
                            when '0' to '9' =>
                                result := result * 16 + (character'pos(hex_str(hex_index)) - character'pos('0'));
                            when 'A' to 'F' =>
                                result := result * 16 + (character'pos(hex_str(hex_index)) - character'pos('A') + 10);
                            when 'a' to 'f' =>
                                result := result * 16 + (character'pos(hex_str(hex_index)) - character'pos('a') + 10);
                            when others =>
                                report "Invalid character in hex string" severity error;
                        end case;
                    end loop;

                    -- Store result in memory
                    if index <= 63 then
                        mem(index) <= std_logic_vector(to_unsigned(result, 32));
                        index := index + 1;
                    else
                        report "Address out of range" severity error;
                    end if;
                end loop;
                file_close(mem_file);

                mem_init_done <= true; -- Set initialization flag
            end if;
        end if;
    end process;

    -- Process for reading memory based on address 'a'
    process (clk)
    begin
        if rising_edge(clk) then
            if mem_init_done then
                rd <= mem(to_integer(unsigned(a)));
            else
                rd <= (others => '0'); -- Default output if memory not initialized
            end if;
        end if;
    end process;

end behave;