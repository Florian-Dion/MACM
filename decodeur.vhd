LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.NUMERIC_STD.ALL;

entity decodeur is
    Port(
        instr : in std_logic_vector(31 downto 0);
        PCSrc, RegWr, MemToReg, MemWr, Branch, CCWr, AluSrc : out std_logic;
        AluCtrl, ImmSrc, RegSrc : out std_logic_vector(1 downto 0);
        Cond : out std_logic_vector(3 downto 0)
    );
end decodeur;

architecture archDecodeur of decodeur is
begin
    AluCtrl <= "00" when instr(27 downto 26) = "10" else
                "00" when instr(27 downto 26) = "00" and instr(24 downto 21) = "0100" else
                "01" when instr(27 downto 26) = "00" and instr(24 downto 21) = "0010" else
                "10" when instr(27 downto 26) = "00" and instr(24 downto 21) = "0000" else
                "11" when instr(27 downto 26) = "00" and instr(24 downto 21) = "1100" else
                "01" when instr(27 downto 26) = "00" and instr(24 downto 21) = "1010" else
                "00" when instr(27 downto 26) = "01" and instr(23) = '0' else
                "01" when instr(27 downto 26) = "01" and instr(23) = '1';

    Branch <= '1' when instr(27 downto 26) = "10" else '0';

    MemToReg <= '1' when instr(27 downto 26) = "01" and instr(20) = '1' else '0';

    MemWr <= '1' when instr(27 downto 26) = "01" else '0';

    AluSrc <= '0' when instr(27 downto 26) = "00" and instr(25) = '0' else '1';

    ImmSrc <= instr(27 downto 26);

    RegWr <=    '0' when instr(27 downto 26) = "00" and instr(25) = '0' and instr(20) = '1' else -- and instr(24 downto 21) = "1010" else
                '1' when instr(27 downto 26) = "00" and instr(25) = '0' else
                '1' when instr(27 downto 26) = "00" and instr(25) = '1' else
                '1' when instr(27 downto 26) = "01" and instr(20) ='1' else
                '0' when instr(27 downto 26) = "01" and instr(20) ='0' else
                '0' when instr(27 downto 26) = "10";

    RegSrc <= "10" when instr(27 downto 26) = "01" and instr(20) = '0' else
                "01" when instr(27 downto 26) = "10" else "00";

    PCSrc <= '0' when instr(27 downto 26) = "01" and instr(20) = '0' else
                '1' when instr(15 downto 12) = "1111" else '0';

                CCWr <= '1' when instr(27 downto 26) = "00" and instr(20) = '1' else '0';

    Cond <= instr(31 downto 28);
end archDecodeur;
