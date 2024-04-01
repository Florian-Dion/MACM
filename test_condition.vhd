LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.NUMERIC_STD.ALL;


entity test_condition is
end entity test_condition;

architecture archi_test_condition of test_condition is
    constant clkpulse : time := 5 ns;
    constant TIMEOUT : time := 1000 ns;

    signal E_CLK : std_logic;
    signal Cond, CC_EX, CC : std_logic_vector(3 downto 0);
    signal CCWr_EX : std_logic;
    signal CCp : std_logic_vector(3 downto 0);
    signal CondEx : std_logic;
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

condition: entity work.condition
    port map(
        Cond, CC_EX, CC, CCWr_EX, CCp, CondEx
    );

P_TEST: process
begin
    Cond <= "0000";
    CC_EX <= "0100";
    CC <= "0100";
    CCWr_EX <= '0';

    wait for 10 ns;

    Cond <= "0001";
    CC_EX <= "0100";
    wait for 10 ns;

    -- LATEST COMMAND (NE PAS ENLEVER !!!)
wait until E_CLK='1'; wait for clkpulse/2;
assert FALSE report "FIN DE SIMULATION" severity FAILURE;
-- assert (NOW < TIMEOUT) report "FIN DE SIMULATION" severity FAILURE;

end process P_TEST;

end architecture archi_test_condition;
