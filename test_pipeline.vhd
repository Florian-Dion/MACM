LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.NUMERIC_STD.ALL;

entity test_pipeline is
end entity test_pipeline;


architecture arch_test_pipeline of test_pipeline is
    constant clkpulse : time := 5 ns;
    constant TIMEOUT : time := 1000 ns;

    signal Gel_LI, Gel_DI, RAZ_DI, Clr_EX, Init : std_logic;
    signal EA_EX, EB_EX : std_logic_vector(1 downto 0);
    signal a1, a2, rs1, rs2, op3_EX_out, op3_ME_out, op3_RE_out : std_logic_vector(3 downto 0);
    signal E_CLK : std_logic;
begin

-- definition de l'horloge
P_E_CLK: process
begin
	E_CLK <= '1';
	wait for clkpulse;
	E_CLK <= '0';
	wait for clkpulse;
end process P_E_CLK;

------------------------------------------------------------------
-- definition du timeout de la simulation
P_TIMEOUT: process
begin
	wait for TIMEOUT;
	assert FALSE report "SIMULATION TIMEOUT!!!" severity FAILURE;
end process P_TIMEOUT;

pipe: entity work.pipeline
    port map(
        Gel_LI, Gel_DI, RAZ_DI, Clr_EX, Init, EA_EX, EB_EX, a1, a2, rs1, rs2, op3_EX_out, op3_ME_out, op3_RE_out, E_CLK
    );

    P_TEST: process
    begin
        Init <= '1';
        Gel_LI <= '1';
        Gel_DI <= '1';
        RAZ_DI <= '1';
        Clr_EX <= '1';
        EA_EX <= "00";
        EB_EX <= "00";



        wait for 1 ns;

        Init <= '0';

        wait for 200 ns;
        
    
    
    -- LATEST COMMAND (NE PAS ENLEVER !!!)
        wait until E_CLK='1'; wait for clkpulse/2;
        assert FALSE report "FIN DE SIMULATION" severity FAILURE;
    -- assert (NOW < TIMEOUT) report "FIN DE SIMULATION" severity FAILURE;
    
    end process;

end architecture arch_test_pipeline;