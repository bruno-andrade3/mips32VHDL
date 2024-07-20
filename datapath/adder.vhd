library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity adder is
    port (
        a, b: in  std_logic_vector(31 downto 0);
        y:    out std_logic_vector(31 downto 0));
end adder;

architecture dataflow of adder is
begin
    -- Convert std_logic_vector to unsigned for addition, then convert the result back to std_logic_vector
    y <= std_logic_vector(unsigned(a) + unsigned(b));
end dataflow;
