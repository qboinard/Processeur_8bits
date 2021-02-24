----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 02/24/2021 09:15:40 AM
-- Design Name: 
-- Module Name: memoire - Behavioral
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
use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity memoire is

    Port
    (
        CE              : in    std_logic;
        H               : in    std_logic;

        Enable_memoire  : in    std_logic;
        Read_write      : in    std_logic;
        -- Read_write = 1 => write
        -- .......... = 0 => read

        Adresse         : in    std_logic_vector(5 downto 0);
        data_write      : in    std_logic_vector(7 downto 0);
        data_read       : out    std_logic_vector(7 downto 0)
    ); 

end memoire;

architecture Behavioral of memoire is

    Type memory is array (64 donwto 0) of std_logic_vector (7 downto 0);
    signal mem : memory;

begin

    Process (H)
    Begin
        if (clk'event and clk = '1') then
            if (Read_write = '1') then
                -- Ecriture
                mem(to_integer(unsigned(Adresse))) <= data_write;
            else
                data_read <= mem(to_integer(unsigned(Adresse)));
            end if;
        end if;
    end process;

end Behavioral;