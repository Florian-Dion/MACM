LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.NUMERIC_STD.ALL;

entity UGA is
    port (
        Gel_LI, Gel_DI, RAZ_DI, Clr_EX, Init : in std_logic;
        EA_EX, EB_EX : in std_logic_vector(1 downto 0);
        a1, a2, op3_EX_out, op3_ME_out, op3_RE_out : out std_logic_vector(3 downto 0);
        clk : in std_logic
    );
end UGA;

architecture UGA of UGA is
    
begin