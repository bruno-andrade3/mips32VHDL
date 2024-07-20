library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity mips is
    port (
        clock, reset : in std_logic;
        pc: out std_logic_vector(31 downto 0);
        instruction: in std_logic_vector(31 downto 0);
        mem_write: out std_logic;
        alu_out: out std_logic_vector(31 downto 0);
        read_data: out std_logic_vector(31 downto 0)
    );
end mips;

architecture struct of mips is
    component controller
        port (
            opcode: in std_logic_vector(5 downto 0);
            funct: in std_logic_vector(5 downto 0);
            zero: in std_logic;
            memtoreg, memwrite: out std_logic;
            pcsrc, alusrc: out std_logic;
            regdst, regwrite: out std_logic;
            jump: out std_logic;
            alu_control: out std_logic_vector(2 downto 0)
        );
    end component;
    component datapath
        port (
            clock, reset: in std_logic;
            memtoreg, pcsrc: in std_logic;
            alusrc, regdst: in std_logic;
            regwrite, jump: in std_logic;
            alu_control: in std_logic_vector(2 downto 0);
            zero: out std_logic;
            pc: buffer std_logic_vector(31 downto 0);
            instruction: in std_logic_vector(31 downto 0);
            alu_out, write_data: buffer std_logic_vector(31 downto 0);
            read_data: in std_logic_vector(31 downto 0)
        );
    end component;
    signal memtoreg, alusrc, regdst, regwrite, jump, pcsrc: std_logic;
    signal zero: std_logic;
    signal alu_control: std_logic_vector(2 downto 0);
begin
    cont: controller port map (
        opcode => instruction(31 downto 26),
        funct => instruction(5 downto 0),
        zero => zero,
        memtoreg => memtoreg,
        memwrite => mem_write,
        pcsrc => pcsrc,
        alusrc => alusrc,
        regdst => regdst,
        regwrite => regwrite,
        jump => jump,
        alu_control => alu_control
    );
    dp: datapath port map (
        clock => clock,
        reset => reset,
        memtoreg => memtoreg,
        pcsrc => pcsrc,
        alusrc => alusrc,
        regdst => regdst,
        regwrite => regwrite,
        jump => jump,
        alu_control => alu_control,
        zero => zero,
        pc => pc,
        instruction => instruction,
        alu_out => alu_out,
        write_data => read_data,
        read_data => read_data
    );

end architecture;