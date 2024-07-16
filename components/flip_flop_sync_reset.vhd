library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity flopr is -- flip-flop with synchronous reset
    generic (width : integer);
    port (
        clk, reset : in  std_logic;
        d :          in  std_logic_vector(width-1 downto 0);
        q :          out std_logic_vector(width-1 downto 0));
end flopr;

architecture behavioral of flopr is
begin
    process (clk, reset) 
    begin
        if reset = '1' then
            q <= (others => '0'); -- Reset the output to all zeros
        elsif rising_edge(clk) then
            q <= d;
        end if;
    end process;
end behavioral;