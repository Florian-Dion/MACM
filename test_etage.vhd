LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.NUMERIC_STD.ALL;


entity test_etage is
end entity test_etage;

architecture archi_test_etage of test_etage is
    constant clkpulse : time := 5 ns;
    constant TIMEOUT : time := 1000 ns;

    signal clk, ALUSrc_EX, MemWr_Mem, MemWr_RE, PCSrc_ER, Bpris_EX, Gel_LI, Gel_DI, RAZ_DI, RegWR, Clr_EX, MemToReg_RE, Init : std_logic;
    signal RegSrc, EA_EX, EB_EX, immSrc, ALUCtrl_EX : std_logic_vector(1 downto 0);
    signal instr_DE: std_logic_vector(31 downto 0);
    signal a1, a2, rs1, rs2, CC, op3_EX_out, op3_ME_out, op3_RE_out: std_logic_vector(3 downto 0)
);   
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
etage: entity work.etage
    port map(
        clk => clk,
        ALUSrc_EX => ALUSrc_EX,
        MemWr_Mem => MemWr_Mem,
        MemWr_RE => MemWr_RE,
        PCSrc_ER => PCSrc_ER,
        Bpris_EX => Bpris_EX,
        Gel_LI => Gel_LI,
        Gel_DI => Gel_DI,
        RAZ_DI => RAZ_DI,
        RegWR => RegWR,
        Clr_EX => Clr_EX,
        MemToReg_RE => MemToReg_RE,
        RegSrc => RegSrc,
        EA_EX => EA_EX,
        EB_EX => EB_EX,
        immSrc => immSrc,
        ALUCtrl_EX => ALUCtrl_EX,
        instr_DE => instr_DE,
        a1 => a1,
        a2 => a2,
        rs1 => rs1,
        rs2 => rs2,
        CC => CC,
        op3_EX_out => op3_EX_out,
        op3_ME_out => op3_ME_out,
        op3_RE_out => op3_RE_out
    );


P_TEST: process
begin

PCSrc_ER <= '1';
Bpris_EX <= '1';
GEL_LI <= '1';

end architecture archi_test_etage;