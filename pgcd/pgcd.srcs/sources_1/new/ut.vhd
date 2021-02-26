----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 02/26/2021 08:23:12 AM
-- Design Name: 
-- Module Name: ut - Behavioral
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

entity ut is
    port
    (
        CE              : in    std_logic;
        Clk             : in    std_logic;
        RST             : in    std_logic;

        SEL_UAL         : in    std_logic;
        Load_Reg_Accu   : in    std_logic;
        Load_Reg_Data   : in    std_logic;
        Load_Carry      : in    std_logic;
        Init_Carry      : in    std_logic;

        carry           : out   std_logic;
        
        data_in         : in    std_logic_vector(7 downto 0);
        data_out        : out   std_logic_vector(7 downto 0)
        );
end ut;

architecture Behavioral of ut is

    signal Sig_Reg_Data_out : std_logic_vector(7 downto 0);
    signal Sig_Reg_Accu_out : std_logic_vector(7 downto 0);
    signal Sig_UAL_out      : std_logic_vector(7 downto 0);

    signal Sig_carry        : std_logic;


    component registre
        Port (
            CE              : in    std_logic;
            CLK             : in    std_logic;
            RST             : in    std_logic;
            Load_registre   : in    std_logic;
            data_in         : in    std_logic_vector(7 downto 0);
            data_out        : out   std_logic_vector(7 downto 0)
        );
    end component;

    component ual
        Port (
            sel_UAL  : in  std_logic;
            data_reg : in  std_logic_vector(7 downto 0);
            accu_reg : in  std_logic_vector(7 downto 0);
            carry    : out std_logic;
            data_out : out std_logic_vector(7 downto 0)
        );
    end component;

    component bascule
        Port(
            CE              : in    std_logic;
            Clk               : in    std_logic;
            RST             : in    std_logic;
            Load_carry      : in    std_logic;
            Init_carry      : in    std_logic;
            data_in         : in    std_logic;
            data_out        : out   std_logic
        );
    end component;

begin
    ual_comp : ual port map (
        sel_UAL  => Sel_UAL,
        data_reg => Sig_Reg_Data_out,
        accu_reg => Sig_Reg_Accu_out,
        carry    => Sig_carry,
        data_out => Sig_UAL_out
    );

    bascule_comp : bascule port map (
        CE         => CE,
        Clk        => Clk,
        RST        => RST,
        Load_carry => Load_carry,
        Init_carry => Init_carry,
        data_in    => sig_carry,
        data_out   => carry
    );

    Registre_data : registre port map (
        CE            => CE,
        Clk           => Clk,
        RST           => RST,
        Load_registre => Load_Reg_Data,
        data_in       => data_in,
        data_out      => Sig_Reg_Data_out
    );

    Registre_Accu : registre port map (
        CE            => CE,
        Clk           => Clk,
        RST           => RST,
        Load_registre => Load_Reg_Accu,
        data_in       => Sig_UAL_out,
        data_out      => Sig_Reg_Accu_out
    );
    
    data_out <= Sig_Reg_Accu_out;
end Behavioral;
