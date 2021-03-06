----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 02/24/2021 10:30:42 AM
-- Design Name: 
-- Module Name: mux - Behavioral
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
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity mux is
  Port ( sel : in  std_logic;
         data_reg : in  std_logic_vector(5 downto 0);
         data_cpt : in  std_logic_vector(5 downto 0);
         data_out : out std_logic_vector(5 downto 0));
end mux;

architecture Behavioral of mux is
begin
    process (sel, data_reg, data_cpt)
    begin
        if (sel = '0') then
            data_out <= data_cpt;
        else
            data_out <= data_reg;
        end if;
    end process;
end Behavioral;
