LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.NUMERIC_STD.ALL;

entity pipeline is
    port (
        --Gel_LI, Gel_DI, RAZ_DI, Clr_EX, Init : in std_logic;
        Init : in std_logic;
        --EA_EX, EB_EX : in std_logic_vector(1 downto 0);
        --a1, a2, rs1, rs2, op3_EX_out, op3_ME_out, op3_RE_out : out std_logic_vector(3 downto 0);
        clk : in std_logic
    );
end pipeline;

architecture pipeline of pipeline is
    signal instr : std_logic_vector(31 downto 0);
    signal PCSrc, RegWr, MemToReg, MemWr, Branch, AluSrc, RegWr_EX, PCSrc_EX, MemWr_EX, Branch_EX, MemToReg_EX, MemToReg_RE, MemToReg_mem, AluSrc_EX, CondEx, and1, and2, and3, and4, and1_mem, and2_mem, and3_mem, and1_ER, and2_ER, CCWr, CCWr_EX, Bpris_EX : std_logic;
    signal AluCtrl, ImmSrc, RegSrc, AluCtrl_EX : std_logic_vector(1 downto 0);
    signal Cond, Cond_out, CC, CCp, CC_EX : std_logic_vector(3 downto 0);
    signal Gel_LI, Gel_DI, RAZ_DI, Clr_EX : std_logic;
    signal EA_EX, EB_EX : std_logic_vector(1 downto 0);
    signal a1, a2, rs1, rs2, op3_EX_out, op3_ME_out, op3_RE_out : std_logic_vector(3 downto 0);
begin

    proc: entity work.dataPath
        port map (
            clk,  ALUSrc_EX, and3_mem, and2_ER, Bpris_EX, Gel_LI, Gel_DI, RAZ_DI, and1_ER, Clr_EX, MemToReg_RE, Init, RegSrc, EA_EX, EB_EX, ImmSrc, AluCtrl_EX,
            instr, a1, a2, rs1, rs2, CC, op3_EX_out, op3_ME_out, op3_RE_out
        );

    decodeur: entity work.decodeur
        port map (
            instr, PCSrc, RegWr, MemToReg, MemWr, Branch, CCWr, AluSrc, AluCtrl, ImmSrc, RegSrc, Cond
        );

    UGA: entity work.UGA
        port map (
            Gel_LI, Gel_DI, RAZ_DI, Clr_EX, and1_mem, and1_ER, PCSrc, and2_mem, PCSrc_EX, and2_ER, MemToReg_EX, Bpris_EX, 
            EA_EX, EB_EX, a1, a2, op3_EX_out, op3_ME_out, op3_RE_out, rs1, rs2, clk
        );


    re1: entity work.Reg1
        port map (
            PCSrc, PCSrc_EX, '1', '1', clk
        );
    
    re2: entity work.Reg1
        port map (
            RegWr, RegWr_EX, '1', '1', clk
        );

    re3: entity work.Reg1
        port map (
            CCWr, CCWr_EX, '1', '1', clk
        );

    re4: entity work.Reg1
        port map (
            MemWr, MemWr_EX, '1', '1', clk
        );

    re5: entity work.Reg2
    port map (
        AluCtrl, AluCtrl_EX, '1', '1', clk
    );

    re6: entity work.Reg1
    port map (
        Branch, Branch_EX, '1', '1', clk
    );

    re7: entity work.Reg1
    port map (
        MemToReg, MemToReg_EX, '1', '1', clk
    );

    re8: entity work.Reg1
    port map (
        AluSrc, AluSrc_EX, '1', '1', clk
    );

    re9: entity work.Reg4
    port map (
        Cond, Cond_out, '1', '1', clk
    );

    re10: entity work.Reg4
    port map (
        CCp, CC_EX, '1', '1', clk
    );

    condition: entity work.condition
        port map (
        Cond_out, CC_EX, CC, CCWr_EX, CCp, CondEx
        );

    and1 <= RegWr_EX and CondEx;
    and2 <= PCSrc_EX and CondEx;
    and3 <= MemWr_EX and CondEx;
    and4 <= Branch_EX and CondEx;

    Bpris_EX <= and4;

    re11: entity work.Reg1
    port map (
        and1, and1_mem, '1', '1', clk
    );

    re12: entity work.Reg1
    port map (
        and2, and2_mem, '1', '1', clk
    );

    re13: entity work.Reg1
    port map (
        and3, and3_mem, '1', '1', clk
    );

    re14: entity work.Reg1
    port map (
        MemToReg_EX, MemToReg_mem, '1', '1', clk
    );

    re15: entity work.Reg1
    port map (
        and1_mem, and1_ER, '1', '1', clk
    );


    re16: entity work.Reg1
    port map (
        and2_mem, and2_ER, '1', '1', clk
    );

    re17: entity work.Reg1
    port map (
        MemToReg_mem, MemToReg_RE, '1', '1', clk
    );


end architecture;