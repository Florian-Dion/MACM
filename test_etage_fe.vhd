LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.NUMERIC_STD.ALL;


entity test_etage_fe is
end entity test_etage_fe;

architecture archi_test_etage_fe of test_etage_fe is
    constant clkpulse : time := 5 ns;
    constant TIMEOUT : time := 1000 ns;

    signal E_npc, E_npc_fw_br : std_logic_vector(31 downto 0);
    signal E_PCSrc_ER, E_Bpris_EX, E_GEL_LI, E_clk : std_logic;
    signal E_pc_plus_4, E_i_FE : std_logic_vector(31 downto 0);
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

fetch : entity work.etageFE
			port map (
                npc => E_npc, npc_fw_br => E_npc_fw_br,
                PCSrc_ER => E_PCSrc_ER, Bpris_EX => E_Bpris_EX,
                GEL_LI => E_GEL_LI, clk => E_clk,
                pc_plus_4 => E_pc_plus_4, i_FE => E_i_FE
            );

P_TEST: process
begin
    
    E_npc <= (others => '0');
    E_npc_fw_br <= (others => '0');
    E_PCSrc_ER <= '1';
    E_Bpris_EX <= '0';
    E_GEL_LI <= '1';

    wait for clkpulse*3;

    E_npc <= (2=>'1', others => '0');

    wait for clkpulse*3;

    E_npc <= (3=>'1', others => '0');

    wait for clkpulse*3;


-- LATEST COMMAND (NE PAS ENLEVER !!!)
    wait until E_CLK='1'; wait for clkpulse/2;
    assert FALSE report "FIN DE SIMULATION" severity FAILURE;
-- assert (NOW < TIMEOUT) report "FIN DE SIMULATION" severity FAILURE;

end process;

end architecture;
