LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.NUMERIC_STD.ALL;


entity test_decodeur is
end entity test_decodeur;

architecture archi_test_decodeur of test_decodeur is
    constant clkpulse : time := 5 ns;
    constant TIMEOUT : time := 1000 ns;

    signal E_CLK : std_logic;
    signal instr : std_logic_vector(31 downto 0);
    signal PCSrc, RegWr, MemToReg, MemWr, Branch, CCWr, AluSrc : std_logic;
    signal AluCtrl, ImmSrc, RegSrc : std_logic_vector(1 downto 0);
    signal Cond : std_logic_vector(3 downto 0);
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

------------------------------------------------------------------
decodeur: entity work.decodeur
    port map(
        instr => instr,
        PCSrc => PCSrc,
        RegWr => RegWr,
        MemToReg => MemToReg,
        MemWr => MemWr,
        Branch => Branch,
        CCWr => CCWr,
        AluSrc => AluSrc,
        AluCtrl => AluCtrl,
        ImmSrc => ImmSrc,
        RegSrc => RegSrc,
        Cond => Cond
    );


P_TEST: process
begin

instr <= "11110000100100100011000000001000";

wait for 2*clkpulse;

instr <= "11111010000000000000000000000000";

wait for 10 ns;

-- LATEST COMMAND (NE PAS ENLEVER !!!)
wait until E_CLK='1'; wait for clkpulse/2;
assert FALSE report "FIN DE SIMULATION" severity FAILURE;
-- assert (NOW < TIMEOUT) report "FIN DE SIMULATION" severity FAILURE;

end process P_TEST;

end architecture archi_test_decodeur;
