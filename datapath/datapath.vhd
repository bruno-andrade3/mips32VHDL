library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity datapath is
    port (
        clock, reset : in std_logic;
        memtoreg, pcsrc : in std_logic;
        alusrc, regdst : in std_logic;
        regwrite, jump : in std_logic;
        alu_control : in std_logic_vector(2 downto 0);
        zero : out std_logic;
        pc : buffer std_logic_vector(31 downto 0);
        instruction: in std_logic_vector(31 downto 0);
        alu_out, write_data: buffer std_logic_vector(31 downto 0);
        read_data : in std_logic_vector(31 downto 0);
    );
end datapath;

architecture struct of datapath is
    component alu
        port (
            a, b : in std_logic_vector(31 downto 0);
            alu_control : in std_logic_vector(2 downto 0);
            alu_result : out std_logic_vector(31 downto 0);
            zero : out std_logic
        );
    end component;
    component reg_file
        port (
            clock: in std_logic;
            we3: in std_logic;
            ra1, ra2, wa3: in std_logic_vector(4 downto 0);
            wd3: in std_logic_vector(31 downto 0);
            rd1, rd2: out std_logic_vector(31 downto 0)
        );
    end component;
    component adder
        port (
            a, b : in std_logic_vector(31 downto 0);
            y : out std_logic_vector(31 downto 0)
        );
    end component;
    component shift_left2
        port (
            a : in std_logic_vector(31 downto 0);
            result : out std_logic_vector(31 downto 0)
        );
    end component;
    component sign_extend
        port (
            a : in std_logic_vector(15 downto 0);
            result : out std_logic_vector(31 downto 0)
        );
    end component;
    component flopr generic(width : integer);
        port (
            clk,reset : in std_logic;
            d : in std_logic_vector(width-1 downto 0);
            q : out std_logic_vector(width-1 downto 0)
        );
    end component;
    component mux2 generic(width : integer);
        port (
            d0, d1 : in std_logic_vector(width-1 downto 0);
            s : in std_logic;
            y : out std_logic_vector(width-1 downto 0)
        );
    end component;
    signal writereg: std_logic_vector(4 downto 0);
    signal pcjump, pcnext, pcnextbr, pcplus4, pcbranch: std_logic_vector(31 downto 0);
    signal signimm, signimmsh: std_logic_vector(31 downto 0);
    signal srca, srcb, result: std_logic_vector(31 downto 0);
begin
    --next PC logic
    pcjump <= pcplus4(31 downto 28) & instruction(25 downto 0) & "00";
    pcreg: flopr generic map(32) port map(clock, reset, pcnext, pc);
    pcadd1: adder port map(pc, X"00000004", pcplus4);
    immsh: shift_left2 port map(signimm, signimmsh);
    pcadd2: adder port map(pcplus4, signimmsh, pcbranch);
    pcbrmux: mux2 generic map(32) port map(pcplus4, pcbranch, pcsrc, pcnextbr);
    pcmux: mux2 generic map(32) port map(pcnextbr, pcjump, jump, pcnext);
    --register file logic
    rf: reg_file port map(clock, regwrite, instruction(25 downto 21), instruction(20 downto 16), writereg, result, srca, write_data);
    wrmux: mux2 generic map(5) port map(instruction(20 downto 16), instruction(15 downto 11), regdst, writereg);
    resmux: mux2 generic map(32) port map(alu_out, read_data, memtoreg, result);
    se: sign_extend port map(instruction(15 downto 0), signimm);
    --ALU logic
    srcbmux: mux2 generic map(32) port map(write_data, signimm, alusrc, srcb);
    mainalu: alu port map(srca, srcb, alu_control, alu_out, zero);
end architecture;