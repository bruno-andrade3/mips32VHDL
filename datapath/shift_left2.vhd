library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity sl2 is
    port (
        a: in  std_logic_vector(31 downto 0);
        y: out std_logic_vector(31 downto 0));
end sl2;

architecture dataflow of sl2 is
begin
    y <= a(29 downto 0) & "00";
end dataflow;