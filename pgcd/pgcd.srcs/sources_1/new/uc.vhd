----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 02/26/2021 08:23:12 AM
-- Design Name: 
-- Module Name: uc - Behavioral
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

entity uc is
    Port (
        -- Signaux généraux
        CE              : in  std_logic;
        CLK             : in  std_logic;
        RST             : in  std_logic;

        -- Controle Mémoire
        Enable_Mem      : out std_logic;
        Read_write      : out std_logic;

        -- Controle UT
        Sel_UAL         : out std_logic;
        Load_Reg_Accu   : out std_logic;
        Load_Reg_Data   : out std_logic;
        Load_Carry      : out std_logic;
        Init_Carry      : out std_logic;

        -- Data I/O
        carry           : in  std_logic;
        Adress_out      : out std_logic_vector(5 downto 0);
        Data_in         : in  std_logic_vector(7 downto 0)

    );
end uc;

architecture Behavioral of uc is

    signal load_cpt         : std_logic;
    signal enable_cpt       : std_logic;
    signal init_cpt         : std_logic;
    signal sel_Mux          : std_logic;
    signal load_registre    : std_logic;

    signal Code_OP          : std_logic_vector(1 downto 0);
    signal Instruction      : std_logic_vector(5 downto 0);
    signal Compteur         : std_logic_vector(5 downto 0);

    component registre
        Port (
            CE            : in    std_logic;
            Clk           : in    std_logic;
            RST           : in    std_logic;
            Load_registre : in    std_logic;
            data_in       : in    std_logic_vector(7 downto 0);
            data_out      : out   std_logic_vector(7 downto 0)
        );
    end component;

    component mux
        Port (
            sel      : in  std_logic;
            data_reg : in  std_logic_vector(5 downto 0);
            data_cpt : in  std_logic_vector(5 downto 0);
            data_out : out std_logic_vector(5 downto 0)
        );
    end component;

    component compteur
        Port (
            RST      : in  std_logic;
            CLK      : in  std_logic;
            CE       : in  std_logic;
            init_cpt : in  std_logic;
            load_cpt : in  std_logic;
            en_cpt   : in  std_logic;
            data_in  : in  std_logic_vector (5 downto 0);
            data_out : out std_logic_vector (5 downto 0)
        );
    end component;

    component FSM
        Port (
            RST     : in std_logic;
            CLK     : in std_logic;
            CE      : in std_logic;
            carry   : in std_logic;
            code_OP : in std_logic_vector(1 downto 0);
            A, B, C, D, E, F, G, H, I, J, K, L : out std_logic
        );
    end component;

begin

    FSM_comp : FSM port map (
        RST     => RST,
        CLK     => CLK,
        CE      => CE,
        carry   => carry,
        code_OP => Code_OP,
        A       => Sel_UAL,
        B       => Load_Reg_Accu,
        C       => Load_Reg_Data,
        D       => Load_Carry,
        E       => Init_Carry,
        F       => Load_registre,
        G       => sel_Mux,
        H       => load_cpt,
        I       => enable_cpt,
        J       => init_cpt,
        K       => Enable_Mem,
        L       => Read_write   
    );

    Reg_inst : registre port map (
        CE                    => CE,
        CLK                   => CLK,
        RST                   => RST,
        Load_registre         => Load_registre,
        data_out (7 downto 6) => Code_OP,
        data_out (5 downto 0) => Instruction,
        data_in               => Data_in
    );

    Cpt : compteur port map (
        RST      => RST,
        CLK      => CLK,
        CE       => CE,
        init_cpt => init_cpt,        
        load_cpt => load_cpt,
        en_cpt   => enable_cpt,
        data_in  => Instruction,
        data_out => Compteur
    );

    MUX_Comp : MUX port map (
        sel      => sel_mux,
        data_reg => Instruction,
        data_cpt => Compteur,
        data_out => Adress_out
    );

end Behavioral;
