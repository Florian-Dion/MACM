LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.NUMERIC_STD.ALL;


entity test_etage_ex is
end entity test_etage_ex;

architecture archi_test_etage_ex of test_etage_ex is
    constant clkpulse : time := 5 ns;
    constant TIMEOUT : time := 1000 ns;

    signal Op1_EX, Op2_EX, Extlmm_EX, Res_fwd_ME, Res_fwd_ER : std_logic_vector(31 downto 0);
    signal Op3_EX : std_logic_vector (3 downto 0);
    signal EA_EX, EB_EX, ALUCtrl_EX : std_logic_vector(1 downto 0);
    signal ALUSrc_EX : std_logic;
    signal CC, Op3_EX_out : std_logic_vector(3 downto 0);
    signal Res_EX, WD_EX, npc_fw_br : std_logic_vector (31 downto 0);
begin

-- definition de l'horloge
--P_E_CLK: process
--begin
--	E_CLK <= '1';
--	wait for clkpulse;
--	E_CLK <= '0';
--	wait for clkpulse;
--end process P_E_CLK;

------------------------------------------------------------------
-- definition du timeout de la simulation
P_TIMEOUT: process
begin
	wait for TIMEOUT;
	assert FALSE report "SIMULATION TIMEOUT!!!" severity FAILURE;
end process P_TIMEOUT;

fetch : entity work.etageEX
    port map (
                Op1_EX => Op1_EX, Op2_EX => Op2_EX, Op3_EX => Op3_EX,
                EA_EX => EA_EX, EB_EX => EB_EX, ALUCtrl_EX => ALUCtrl_EX,
                ALUSrc_EX => ALUSrc_EX, CC => CC, Res_EX => Res_EX,
                WD_EX => WD_EX, Extlmm_EX => Extlmm_EX, Op3_EX_out => Op3_EX_out,
                npc_fw_br => npc_fw_br, Res_fwd_ME => Res_fwd_ME, Res_fwd_ER => Res_fwd_ER
            );

P_TEST: process
begin
    
    Op1_EX <= (2=> '1', others => '0');
    Op2_EX <= (1=> '1', others => '0');
    Op3_EX <= "0000";
    Extlmm_EX <= (others => '0');
    Res_fwd_ME <= (others => '0');
    Res_fwd_ER <= (others => '0');
    EA_EX <= "00";
    EB_EX <= "00";
    ALUSrc_EX <= '0';
    ALUCtrl_EX <= "00";

    wait for clkpulse*3;

    Op1_EX <= (others => '0');
    Op2_EX <= (others => '0');

    wait for clkpulse*3;


-- LATEST COMMAND (NE PAS ENLEVER !!!)
    wait for clkpulse/2;
    assert FALSE report "FIN DE SIMULATION" severity FAILURE;
-- assert (NOW < TIMEOUT) report "FIN DE SIMULATION" severity FAILURE;

end process;

end architecture;
