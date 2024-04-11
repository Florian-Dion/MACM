LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.NUMERIC_STD.ALL;

entity UGA is
    port (
        Gel_LI, Gel_DI, RAZ_DI, Clr_EX : out std_logic;
        RegWr_mem, RegWr_RE, PCSrc, PCSrc_mem, PCSrc_EX, PCSrc_ER, MemToReg_EX, Bpris_EX : in std_logic;
        EA_EX, EB_EX : out std_logic_vector(1 downto 0);
        a1, a2, op3_EX_out, op3_ME_out, op3_RE_out, reg1, reg2 : in std_logic_vector(3 downto 0);
        clk : in std_logic
    );
end UGA;

architecture UGA of UGA is
   signal LDRStall : std_logic; 
begin
    EA_EX <= "10" when a1 = op3_ME_out and RegWr_mem = '1' else
              "01" when a1 /= op3_ME_out and a1 = op3_RE_out and RegWr_RE = '1' else
              "00";
    
    EB_EX <= "10" when a2 = op3_ME_out and RegWr_mem = '1' else
              "01" when a2 /= op3_ME_out and a2 = op3_RE_out and RegWr_RE = '1' else
              "00";

    Gel_LI <= '1';
    Gel_DI <= '1';
    Clr_EX <= '1';
    RAZ_DI <= '1';

    --LDRStall <= '1' when (reg1 = op3_EX_out or reg2 = op3_EX_out) and MemToReg_EX = '1' else '0';

    --Gel_LI <= not (LDRStall or PCSrc or PCSrc_EX or PCSrc_mem);
    --Gel_DI <= not LDRStall;
   -- Clr_EX <= not (LDRStall or Bpris_EX);
    --RAZ_DI <= not ( PCSrc or PCSrc_EX or PCSrc_mem or PCSrc_ER or Bpris_EX);

end UGA;