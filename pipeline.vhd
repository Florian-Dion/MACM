LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.NUMERIC_STD.ALL;

entity pipeline is
    port (
        Bpris_EX, Gel_LI, RAZ_DI, Clr_EX, Init : in std_logic;
        EA_EX, EB_EX : in std_logic_vector(1 downto 0);
        a1, a2, rs1, rs2, op3_EX_out, op3_ME_out, op3_RE_out : out std_logic_vector(3 downto 0);
        clk : in std_logic,
    )
end pipeline;

architecture pipeline of pipeline is
    signal instr : std_logic_vector(31 downto 0);
    signal PCSrc, RegWr, MemToReg, MemWr, Branch, AluSrc, RegWr_EX, PCSrc_EX, MemWr_EX, Branch_EX, MemToReg_EX, AluSrc_EX : std_logic;
    signal AluCtrl, ImmSrc, RegSrc, AluCtrl_EX : std_logic_vector(1 downto 0);
    signal Cond, CCWr, CCWr_EX : std_logic_vector(3 downto 0);
begin

    proc: entity work.proc
        port map (
            clk,  ALUSrc, MemWr, PCSrc, Bpris_EX, Gel_LI, Gel_DI, RAZ_DI, RegWR, Clr_EX, MemToReg, Init, RegSrc, EA_EX, EB_EX, ImmSrc, ALUCtrl
            instr, a1, a2, rs1, rs2, CCWr, op3_EX_out, op3_ME_out, op3_RE_out
        );

    decodeur: entity work.decodeur
        port map (
            instr, PCSrc, RegWr, MemToReg, MemWr, Branch, CCWr, AluSrc, AluCtrl, ImmSrc, RegSrc, Cond
        )

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

    re5: entity work.Reg1
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

    condition: entity work.condition
        port map (
            CCWr_EX : in std_logic;
        CCp : out std_logic_vector(3 downto 0);
        CondEx : buffer std_logic
        );