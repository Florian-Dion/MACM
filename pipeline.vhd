LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.NUMERIC_STD.ALL;

entity pipeline is
    port (
        clk : in std_logic,
    )
end pipeline;

architecture pipeline of pipeline is
    signal 
begin

    proc: entity work.proc
        port map (
            clk,  ALUSrc_EX, MemWr_Mem, MemWr_RE, PCSrc_ER, Bpris_EX, Gel_LI, Gel_DI, RAZ_DI, RegWR, Clr_EX, MemToReg_RE, Init, RegSrc, EA_EX, EB_EX, immSrc, ALUCtrl_EX
            instr_DE, a1, a2, rs1, rs2, CC, op3_EX_out, op3_ME_out, op3_RE_out
        );

    decodeur entity work.decodeur
        port map ()