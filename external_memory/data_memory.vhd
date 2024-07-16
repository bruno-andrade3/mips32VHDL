library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use std.textio.all;

use ieee.numeric_std.all;

entity data_memory is
    port (
        clock        : in  std_logic;
        write_enable : in  std_logic;
        alu_out      : in  std_logic_vector(31 downto 0);
        write_data   : in  std_logic_vector(31 downto 0);
        read_data    : out std_logic_vector(31 downto 0)
    );
end data_memory;

architecture behavioral of data_memory is
begin
    process (clock) is 
        type ramtype is array (0 to 1023) of std_logic_vector(31 downto 0);
        variable mem : ramtype;
    begin
        loop
            if rising_edge(clock) then
                if write_enable = '1' then
                    mem(to_integer(unsigned(alu_out))) := write_data;
                end if;
            end if;
            read_data <= mem(to_integer(unsigned(alu_out)));
            wait on clock, alu_out;
        end loop;
    end process;
end behavioral;