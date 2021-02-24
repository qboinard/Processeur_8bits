----------------------------------------------------------------------------------
-- Company:
-- Engineer: 
-- 
-- Create Date: 02/24/2021 09:15:40 AM
-- Design Name: 
-- Module Name: bascule - Behavioral
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

entity bascule is
   
    port
    (
        CE              : in    std_logic;
        H               : in    std_logic;
        RST             : in    std_logic;

        Load_carry      : in    std_logic;
        Init_carry      : in    std_logic;

        data_in         : in    std_logic;
        data_out        : out   std_logic
    );

end bascule;

architecture Behavioral of bascule is

    Process (H, RST)
    Begin
        if (RST = '1') then
            data_out <= '0';

        elsif (H'event and H = '1') then
            if (CE = '1') then
                if (Init_carry = '1') then
                    data_out <= '0';
                elsif (Load_carry = '1') then
                    data_out <= data_in;
                end if;
            end if;
        end if;

    end Process;

begin


end Behavioral;