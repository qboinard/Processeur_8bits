----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 02/24/2021 10:30:42 AM
-- Design Name: 
-- Module Name: fsm - Behavioral
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

entity fsm is
  Port (RST     : in std_logic;
        CLK     : in std_logic;
        CE      : in std_logic;
        carry   : in std_logic;
        code_OP : in std_logic_vector(1 downto 0);
        A, B, C, D, E, F, G, H, I, J, K, L : out std_logic);
end fsm;

architecture Behavioral of fsm is
type etat is (init, f_instruction, decode, f_operande, exec_ual, exec_sta, exec_jcc);
  signal etat_present, etat_suivant : etat;
begin
  process (etat_present, RST, carry, code_OP)
  begin
    case etat_present is 
      when init =>
        if (RST = '0') then
          etat_suivant <= f_instruction;
        end if;
      when f_instruction =>
        etat_suivant <= decode;
      when decode =>
        if (code_OP = "11") then
          etat_suivant <= exec_jcc;
        elsif (code_OP = "10") then
          etat_suivant <= exec_sta;
        else
          etat_suivant <= f_operande;
        end if;
      when f_operande =>
        etat_suivant <= exec_ual;
      when exec_ual =>
        etat_suivant <= f_instruction;
      when exec_sta =>
        etat_suivant <= f_instruction;
      when exec_jcc =>
        etat_suivant <= f_instruction;
    end case;
  end process;

  process (RST, CLK)
  begin
    if (RST = '1') then
      etat_present <= init;
    elsif (CLK'event and CLK = '1') then
      etat_present <= etat_suivant;
    end if;
  end process;

  process (etat_present)
  begin
    case etat_present is
      when init =>
        A <= '0';
        B <= '0';
        C <= '0';
        D <= '0';
        E <= '1';
        F <= '0';
        G <= '0';
        H <= '0';
        I <= '0';
        J <= '1';
        K <= '0';
        L <= '0';
      when f_instruction =>
        A <= '0';
        B <= '0';
        C <= '0';
        D <= '0';
        E <= '0';
        F <= '1';
        G <= '0';
        H <= '0';
        I <= '1';
        J <= '0';
        K <= '1';
        L <= '0';
      when decode =>
        A <= '0';
        B <= '0';
        C <= '0';
        D <= '0';
        E <= '0';
        F <= '0';
        G <= '1';
        H <= '0';
        I <= '0';
        J <= '0';
        K <= '0';
        L <= '0';
      when f_operande =>
        A <= '0';
        B <= '0';
        C <= '1';
        D <= '0';
        E <= '0';
        F <= '0';
        G <= '1';
        H <= '0';
        I <= '0';
        J <= '0';
        K <= '1';
        L <= '0';
      when exec_ual =>
        A <= code_OP(0);
        B <= '1';
        C <= '0';
        D <= code_OP(0);
        E <= '0';
        F <= '0';
        G <= '1';
        H <= '0';
        I <= '0';
        J <= '0';
        K <= '0';
        L <= '0';
      when exec_sta =>
        A <= '0';
        B <= '0';
        C <= '1';
        D <= '0';
        E <= '0';
        F <= '0';
        G <= '1';
        H <= '0';
        I <= '0';
        J <= '0';
        K <= '1';
        L <= '0';
      when exec_jcc =>
        A <= '0';
        B <= '0';
        C <= '0';
        D <= '0';
        E <= carry;
        F <= '0';
        G <= '1';
        H <= not carry;
        I <= '0';
        J <= '0';
        K <= '0';
        L <= '0';
    end case;
  end process;
end Behavioral;