library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity shift_left2 is
    port (
        a: in  std_logic_vector(31 downto 0);
        y: out std_logic_vector(31 downto 0));
end shift_left2;

architecture dataflow of shift_left2 is
begin
    y <= a(29 downto 0) & "00";
end dataflow;