library ieee;
use ieee.std_logic_1164.all;

entity tb_flopr is
end tb_flopr;

architecture behavior of tb_flopr is
    constant width : integer := 8; -- Largura do flip-flop

    component flopr
        generic (width : integer);
        port (
            clk, reset : in std_logic;
            d : in std_logic_vector(width-1 downto 0);
            q : out std_logic_vector(width-1 downto 0)
        );
    end component;

    signal clk, reset : std_logic := '0';
    signal d : std_logic_vector(width-1 downto 0) := (others => '0');
    signal q : std_logic_vector(width-1 downto 0);

    constant clk_period : time := 10 ns;
    constant sim_time : time := 200 ns; -- Tempo total de simulação aumentado

begin
    -- Instanciar o flip-flop
    uut: flopr
        generic map (
            width => width
        )
        port map (
            clk => clk,
            reset => reset,
            d => d,
            q => q
        );

    -- Processo de geração do clock
    clk_process : process
    begin
        clk <= '0';
        wait for clk_period / 2;
        clk <= '1';
        wait for clk_period / 2;
    end process clk_process;

    -- Processo de estímulo e verificação
    stim_proc: process
    begin
        -- Teste com reset
        reset <= '1';
        wait for 20 ns;
        reset <= '0';
        d <= x"AA";
        wait for clk_period;
        assert (q = x"AA") report "Erro: q deve ser AA após aplicar dados" severity error;
        
        -- Novo valor de dados
        d <= x"55";
        wait for clk_period;
        assert (q = x"55") report "Erro: q deve ser 55 após atualizar dados" severity error;
        
        -- Teste com reset novamente
        reset <= '1';
        wait for clk_period;
        assert (q = (others => '0')) report "Erro: q deve ser zero após aplicar reset" severity error;

        -- Liberar reset e aplicar novos dados
        reset <= '0';
        d <= x"FF";
        wait for clk_period;
        assert (q = x"FF") report "Erro: q deve ser FF após atualizar dados" severity error;

        -- Testes adicionais
        reset <= '1';
        wait for clk_period;
        reset <= '0';
        d <= x"0F";
        wait for clk_period;
        assert (q = x"0F") report "Erro: q deve ser 0F após atualizar dados" severity error;

        -- Finalizar simulação
        wait for sim_time;
        assert false report "Simulação terminada devido ao timeout" severity failure;
        
        wait;
    end process;

end behavior;