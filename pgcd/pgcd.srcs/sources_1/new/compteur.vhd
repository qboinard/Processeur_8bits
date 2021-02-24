----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 02/24/2021 09:15:40 AM
-- Design Name: 
-- Module Name: compteur - Behavioral
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

entity compteur is
  Port (RST      : in  std_logic;
        H        : in  std_logic;
        CE       : in  std_logic;
        init_cpt : in  std_logic;
        load_cpt : in  std_logic;
        en_cpt   : in  std_logic;
        data_in  : in  std_logic_vector (5 downto 0);
        data_out : out std_logic_vector (5 downto 0))
end compteur;

architecture Behavioral of compteur is
    signal cpt : unsigned (5 downto 0);
begin
    process (H, RST)
    begin
        if (RST = '1') then
            cpt = 0;
        elsif (H'event and H = '1') then
            if(CE = '1') then
                if (init_cpt = '1') then
                    cpt <= 0;
                elsif (load_cpt = '1') then
                    cpt <= unsigned(data_in);
                elsif (en_cpt = '1') then
                    cpt <= cpt+1;
                end if;
            end if;
        end if;
    end process;
    data_out <= std_logic_vector(cpt);
end Behavioral;
