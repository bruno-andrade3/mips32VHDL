library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity instruction_memory is
    port (
        a  : in std_logic_vector(31 downto 0);
        rd : out std_logic_vector(31 downto 0)
    );
end instruction_memory;

architecture undef of instruction_memory is

begin
--TODO
end architecture;