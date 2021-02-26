----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 02/24/2021 09:15:40 AM
-- Design Name: 
-- Module Name: registre - Behavioral
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

entity registre is
    port
    (
        CE              : in    std_logic;
        CLK             : in    std_logic;
        RST             : in    std_logic;
        Load_registre   : in    std_logic;
        data_in         : in    std_logic_vector(7 downto 0);
        data_out        : out   std_logic_vector(7 downto 0)
    );
end registre;

architecture Behavioral of registre is
begin
    Process (CLK, RST)
    Begin
        if (RST = '1') then
            data_out <= (others=>'0');
        elsif (CLK'event and CLK = '1') then
            if (CE = '1') then
                if (Load_registre = '1') then
                    data_out <= data_in;
                end if;
            end if;
        end if;
    end Process;
end Behavioral;