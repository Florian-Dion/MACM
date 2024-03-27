LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.NUMERIC_STD.ALL;

entity test_etage_er is
end entity test_etage_er;

architecture arch_test_etage_er of test_etage_er is
    constant clkpulse : time := 5 ns;
    constant TIMEOUT : time := 1000 ns;
    signal E_CLK : std_logic;
    signal Res_Mem_RE, Res_ALU_RE : std_logic_vector(31 downto 0);
    signal Op3_RE : std_logic_vector(3 downto 0);
    signal MemToReg_RE : std_logic;
    signal Res_RE : std_logic_vector(31 downto 0);
    signal Op3_RE_out : std_logic_vector(3 downto 0);
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

er : entity work.etageER
    port map(
        Res_Mem_RE => Res_Mem_RE,
        Res_ALU_RE => Res_ALU_RE,
        Op3_RE => Op3_RE,
        MemToReg_RE => MemToReg_RE,
        Res_RE => Res_RE,
        Op3_RE_out => Op3_RE_out
    );

P_TEST: process
begin

    Res_Mem_RE <= "11110000100100100011000000001000";
    Res_ALU_RE <= "00000000000000000000000000000000";
    MemToReg_RE <= '1';

    Op3_RE <= "0000";

    wait for 30 ns;

    wait until E_CLK='1'; wait for clkpulse/2;
    assert FALSE report "FIN DE SIMULATION" severity FAILURE;
end process;

end architecture arch_test_etage_er;