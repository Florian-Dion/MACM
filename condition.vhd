LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.NUMERIC_STD.ALL;

entity condition is
    port (
        Cond, CC_EX, CC : in std_logic_vector(3 downto 0);
        CCWr_EX : in std_logic;
        CCp : out std_logic_vector(3 downto 0);
        CondEx : buffer std_logic
    );
end condition;

architecture condition of condition is
begin

    CondEx <= '1' when Cond = "0000" and CC_EX(2) = '1' else
                '1' when Cond = "0001" and CC_EX(2) = '0' else
                '1' when Cond = "0010" and CC_EX(1) = '1' else
                '1' when Cond = "0011" and CC_EX(1) = '0' else
                '1' when Cond = "0100" and CC_EX(3) = '1' else
                '1' when Cond = "0101" and CC_EX(3) = '0' else
                '1' when Cond = "0110" and CC_EX(0) = '1' else
                '1' when Cond = "0111" and CC_EX(0) = '0' else
                '1' when Cond = "1000" and CC_EX(1) = '1' and CC_EX(2) = '0' else
                '1' when Cond = "1001" and (CC_EX(1) = '0' or CC_EX(2) = '1') else
                '1' when Cond = "1010" and CC_EX(3) = CC_EX(0) else
                '1' when Cond = "1011" and CC_EX(3) /= CC_EX(0) else
                '1' when Cond = "1100" and CC_EX(2) = '0' and CC_EX(3) = CC_EX(0) else
                '1' when Cond = "1101" and (CC_EX(2) = '1' or CC_EX(3) /= CC_EX(0)) else
                '1' when Cond = "1110" else '0';

    CCp <= CC when CCWr_EX = '1' and CondEx = '1' else CC_EX;

end condition;