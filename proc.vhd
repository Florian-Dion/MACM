-------------------------------------------------------

-- Chemin de données

LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.NUMERIC_STD.ALL;


entity dataPath is
  port(
    clk,  ALUSrc_EX, MemWr_Mem, MemWr_RE, PCSrc_ER, Bpris_EX, Gel_LI, Gel_DI, RAZ_DI, RegWR, Clr_EX, MemToReg_RE, Init : in std_logic;
    RegSrc, EA_EX, EB_EX, immSrc, ALUCtrl_EX : in std_logic_vector(1 downto 0);
    instr_DE: out std_logic_vector(31 downto 0);
    a1, a2, rs1, rs2, CC, op3_EX_out, op3_ME_out, op3_RE_out: out std_logic_vector(3 downto 0)
);      
end entity;

architecture dataPath_arch of dataPath is
  signal Res_RE, npc_fwd_br, pc_plus_4, i_FE, i_DE, Op1_DE, Op2_DE, Op1_EX, Op2_EX, extImm_DE, extImm_EX, Res_EX, Res_ME, WD_EX, WD_ME, Res_Mem_ME, Res_Mem_RE, Res_ALU_ME, Res_ALU_RE, Res_fwd_ME : std_logic_vector(31 downto 0);
  signal Op3_DE, Op3_EX, a1_DE, a1_EX, a2_DE, a2_EX, Op3_EX_out_t, Op3_ME, Op3_ME_out_t, Op3_RE, Op3_RE_out_t : std_logic_vector(3 downto 0);
begin

  -- FE

  npc <=Res_RE;
  
  fe: entity work.etageFE
    port map(
      npc=>npc,
      npc_fw_br=>npc_fwd_br,
      PCSrc_ER=>PCSrc_ER,
      Bpris_EX=>Bpris_EX,
      GEL_LI=>GEL_LI,
      clk=>clk,
      pc_plus_4=>pc_plus_4,
      i_FE=>i_FE
    );

    reg1: entity work.Reg32sync
    port map(
      source=>i_FE,
      output=>i_DE,
      wr=>GEL_DI,
      raz=>RAZ_DI,
      clk=>clk
    );

    instr_DE <= i_DE;

 
  -- DE

  Op3_ER <= Op3_RE_out;
  WD_ER <= Res_RE;

  de: entity work.etageDE
    port map(
      i_DE, WD_ER, pc_plus_4, Op3_ER, RegSrc, immSrc, RegWr, clk, Init, Reg1, Reg2,
      Op1_DE, Op2_DE, extImm_DE, Op3_DE
    );

    reg2: entity work.Reg32sync
    port map(
      source=>Op1_DE,
      output=>Op1_EX,
      wr=>'1',
      raz=>Clr_EX,
      clk=>clk
    );

    reg3: entity work.Reg32sync
    port map(
      source=>Reg2,
      output=>a2,
      wr=>'1',
      raz=>Clr_EX,
      clk=>clk
    );

    reg4: entity work.Reg32sync
    port map(
      source=>Reg1,
      output=>a1,
      wr=>'1',
      raz=>Clr_EX,
      clk=>clk
    );

    reg5: entity work.Reg32sync
    port map(
      source=>Op2_DE,
      output=>Op2_EX,
      wr=>'1',
      raz=>Clr_EX,
      clk=>clk
    );

    reg6: entity work.Reg32sync
    port map(
      source=>extImm_DE,
      output=>extImm_EX,
      wr=>'1',
      raz=>Clr_EX,
      clk=>clk
    );

    reg7: entity work.Reg32sync
    port map(
      source=>Op3_DE,
      output=>Op3_EX,
      wr=>'1',
      raz=>Clr_EX,
      clk=>clk
    );

  -- EX

  Res_fwd_ER <= Res_RE;

  ex: entity work.etageEX
    port map(
    Op1_EX, Op2_EX, extImm_EX, Res_fwd_ME, Res_RE, Op3_EX, EA_EX,
    EB_EX, ALUCtrl_EX, ALUSrc_EX, CC, Op3_EX_out, Res_EX, WD_EX, npc_fwd_br
    );

    reg8: entity work.Reg32sync
    port map(
      source=>Res_EX,
      output=>Res_ME,
      wr=>'1',
      raz=>'1',
      clk=>clk
    );

    reg9: entity work.Reg32sync
    port map(
      source=>WD_EX,
      output=>WD_ME,
      wr=>'1',
      raz=>'1',
      clk=>clk
    );

    reg10: entity work.Reg32sync
    port map(
      source=>Op3_EX_out,
      output=>Op3_ME,
      wr=>'1',
      raz=>'1',
      clk=>clk
    );
 
  -- ME
  me: entity work.etageME
    port map(
    Res_ME, WD_ME, Op3_ME, clk, MemWR_Mem, Res_Mem_ME, Res_ALU_ME, Op3_ME_out,
    Res_fwd_ME
    );

    reg11: entity work.Reg32sync
    port map(
      source=>Res_Mem_ME,
      output=>Res_Mem_RE,
      wr=>'1',
      raz=>'1',
      clk=>clk
    );

    reg12: entity work.Reg32sync
    port map(
      source=>Res_ALU_ME,
      output=>Res_ALU_RE,
      wr=>'1',
      raz=>'1',
      clk=>clk
    );

    reg13: entity work.Reg32sync
    port map(
      source=>Op3_ME_out,
      output=>Op3_RE,
      wr=>'1',
      raz=>'1',
      clk=>clk
    );
 
  -- RE

  re: entity work.etageER
    port map(
    Res_Mem_RE, Res_ALU_RE, Op3_RE, MemToReg_RE, Res_RE, Op3_RE_out
    );

 
  
end architecture;
