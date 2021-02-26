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
        CE         : in  std_logic;
        CLK        : in  std_logic;

        Enable_mem : in  std_logic;
        Read_write : in  std_logic;
        -- Read_write = 1 => write
        -- .......... = 0 => read

        Adresse    : in  std_logic_vector(5 downto 0);
        data_write : in  std_logic_vector(7 downto 0);
        data_read  : out std_logic_vector(7 downto 0)
    ); 

end memoire;

architecture Behavioral of memoire is

    Type memory is array (0 to 63) of std_logic_vector (7 downto 0);
    signal mem : memory := (X"08",
                            X"47",
                            X"86",
                            X"C4",
                            X"C4",
                            X"00",
                            X"00",
                            X"7E",
                            X"FE",
                            others => "00000000");
                            
--    signal mem : memory := (X"11",
--                            X"15",
--                            X"52",
--                            X"54",
--                            X"C9",
--                            X"94",
--                            X"51",
--                            X"CD",
--                            X"C0",
--                            X"13",
--                            X"52",
--                            X"95",
--                            X"C0",
--                            X"CD",
--                            X"00",
--                            X"00",
--                            X"00",
--                            X"FF",
--                            X"01",
--                            X"00",
--                            X"28",
--                            X"18",
--                            others => "00000000");  

begin

    Process (CLK)
    Begin
        if (CLK'event and CLK = '1') then
            if (Enable_Mem = '1') then
                if (Read_write = '1') then
                    -- Ecriture
                    mem(to_integer(unsigned(Adresse))) <= data_write;
                else
                    data_read <= mem(to_integer(unsigned(Adresse)));
                end if;
            end if;
        end if;
    end process;

end Behavioral;