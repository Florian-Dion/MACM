LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.NUMERIC_STD.ALL;

entity test_etage_mem is
end entity test_etage_mem;

architecture arch_test_etage_mem of test_etage_mem is
    constant clkpulse : time := 5 ns;
    constant TIMEOUT : time := 1000 ns;

    signal Res_ME, WD_ME : std_logic_vector(31 downto 0);
    signal Op3_ME : std_logic_vector(3 downto 0);
    signal E_CLK : std_logic;
    signal MemWR_Mem : std_logic;
    signal Res_Mem_ME : std_logic_vector(31 downto 0);
    signal Res_ALU_ME : std_logic_vector(31 downto 0);
    signal Op3_ME_out : std_logic_vector(3 downto 0);
    signal Res_fwd_ME : std_logic_vector(31 downto 0);
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

mem: entity work.etageME
    port map (
        Res_ME => Res_ME,
        WD_ME => WD_ME,
        Op3_ME => Op3_ME,
        clk => E_CLK,
        MemWR_Mem => MemWR_Mem,
        Res_Mem_ME => Res_Mem_ME,
        Res_ALU_ME => Res_ALU_ME,
        Op3_ME_out => Op3_ME_out,
        Res_fwd_ME => Res_fwd_ME
    );

P_TEST: process
begin

    Res_ME <= "00000000000000000000000000000011";
    WD_ME <= (others => '0');
    Op3_ME <= "0000";
    MemWR_Mem <= '0';

    wait for 10 ns;

-- LATEST COMMAND (NE PAS ENLEVER !!!)
wait until E_CLK='1'; wait for clkpulse/2;
assert FALSE report "FIN DE SIMULATION" severity FAILURE;
-- assert (NOW < TIMEOUT) report "FIN DE SIMULATION" severity FAILURE;

end process;

end architecture;
