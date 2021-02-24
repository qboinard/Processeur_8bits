----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 02/24/2021 10:30:42 AM
-- Design Name: 
-- Module Name: ual - Behavioral
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
-- Description: 
-- 
-- Dependencies: 
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
-- 
----------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity ual is
  Port (sel_UAL  : in  std_logic;
        data_reg : in  std_logic_vector(7 downto 0);
        accu_reg : in  std_logic_vector(7 downto 0);
        carry    : out std_logic;
        data_out : out std_logic_vector(7 downto 0));
end ual;

architecture Behavioral of ual is
    signal result : std_logic_vector(8 downto 0);
begin
    process(sel_UAL, data_reg, accu_reg)
    begin
        if (sel_UAL = '1') then
            result <= std_logic_vector(resize(unsigned(data_reg), 9)
                                      +resize(unsigned(accu_reg), 9));
        else
            result(7 downto 0) <= data_reg nor accu_reg;
            result(8) <= '0';
        end if;
    end process;
    data_out <= result(7 downto 0);
    carry <= result(8);
end Behavioral;
