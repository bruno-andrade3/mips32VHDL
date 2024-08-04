library ieee;
use ieee.std_logic_1164.all;


entity sign_extend is -- sign extension
    port (
        a: in  std_logic_vector(15 downto 0);
        result: out std_logic_vector(31 downto 0));

end sign_extend;

architecture dataflow of sign_extend is
begin
    result <= X"0000" & a when a(15) = '0' else X"FFFF" & a;
end dataflow;