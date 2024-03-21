LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.NUMERIC_STD.ALL;

entity test_etage_de is
end entity test_etage_de;


architecture arch_test_etage_de of test_etage_de is
    constant clkpulse : time := 5 ns;
    constant TIMEOUT : time := 1000 ns;

    signal i_DE, WD_ER, pc_plus_4 : std_logic_vector(31 downto 0);
    signal Op3_ER : std_logic_vector(3 downto 0);
    signal RegSrc, immSrc : std_logic_vector(1 downto 0);
    signal RegWr, E_CLK, Init : std_logic;
    signal Reg1, Reg2 : std_logic_vector(3 downto 0);
    signal Op1, Op2, extlmm : std_logic_vector(31 downto 0);
    signal Op3_DE : std_logic_vector(3 downto 0);
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

deco: entity work.etageDE
    port map (
        i_DE => i_DE,
        WD_ER => WD_ER,
        pc_plus_4 => pc_plus_4,
        Op3_ER => Op3_ER,
        RegSrc => RegSrc,
        immSrc => immSrc,
        RegWr => RegWr,
        clk => E_CLK,
        Init => Init,
        Reg1 => Reg1,
        Reg2 => Reg2,
        Op1 => Op1,
        Op2 => Op2,
        extlmm => extlmm,
        Op3_DE => Op3_DE
    );

    P_TEST: process
    begin

        i_DE <= "11110000100100100011000000001000";
        WD_ER <= "11111111111111111111111111111111";
        pc_plus_4 <= "00000000000000000000000000000000";
        Op3_ER <= "0010";
        RegSrc <= "00";
        immSrc <= "00";
        RegWr <= '0';
        Init <= '1';
    
        wait for clkpulse*3;

        Init <= '0';

        RegWr <= '1';

        wait for 30 ns;
    
    
    -- LATEST COMMAND (NE PAS ENLEVER !!!)
        wait until E_CLK='1'; wait for clkpulse/2;
        assert FALSE report "FIN DE SIMULATION" severity FAILURE;
    -- assert (NOW < TIMEOUT) report "FIN DE SIMULATION" severity FAILURE;
    
    end process;

end architecture arch_test_etage_de;