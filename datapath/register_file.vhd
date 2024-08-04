library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity register_file is --three-port register file
    port(
        clk:           in  std_logic;
        we3:           in  std_logic;
        ra1, ra2, wa3: in  std_logic_vector(4 downto 0);
        wd3:           in  std_logic_vector(31 downto 0);
        rd1, rd2:      out std_logic_vector(31 downto 0));
end register_file;

architecture behavioral of register_file is
    type ramtype is array (31 downto 0) of std_logic_vector(31 downto 0);
    signal mem: ramtype := (others => (others => '0')); -- Initialize all to zeros
begin
    -- write third port on rising edge of clock
    process(clk)
    begin
        if rising_edge(clk) then
            if we3 = '1' then 
                mem(to_integer(unsigned(wa3))) <= wd3;
            end if;
        end if;
    end process;

    -- read two ports combinationally
    process(clk, ra1, ra2)
    begin
        if (to_integer(unsigned(ra1)) = 0) then 
            rd1 <= (others => '0'); -- zero register
        else 
            rd1 <= mem(to_integer(unsigned(ra1)));
        end if;

        if (to_integer(unsigned(ra2)) = 0) then 
            rd2 <= (others => '0'); -- zero register
        else 
            rd2 <= mem(to_integer(unsigned(ra2)));
        end if;
    end process;
end behavioral;