library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity mux2 is -- 2:1 mux n of bits defined by width
    generic (width : integer); -- Define the bit width of the multiplexer
    port (
        d0, d1: in  std_logic_vector(width-1 downto 0); -- Input vectors
        s:      in  std_logic; -- Select signal
        y:      out std_logic_vector(width-1 downto 0) -- Output vector
    );
end mux2;

architecture dataflow of mux2 is
begin
    -- Concurrent signal assignment for dataflow modeling
    y <= d0 when s = '0' else d1;
end dataflow;
