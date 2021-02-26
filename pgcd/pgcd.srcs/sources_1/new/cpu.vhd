----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 02/26/2021 08:23:12 AM
-- Design Name: 
-- Module Name: cpu - Behavioral
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

entity cpu is
    Port (
        CE : in std_logic;
        RST : in std_logic;
        CLK : in std_logic;

        Adresse : out std_logic_vector(5 downto 0);
        Mem_in : out std_logic_vector(7 downto 0);
        Mem_out : out std_logic_vector(7 downto 0)
    );
end cpu;

architecture Behavioral of cpu is

    component UT
        Port (
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
    end component;

    component memoire
        Port (
            CE         : in  std_logic;
            CLK        : in  std_logic;
    
            Enable_mem : in  std_logic;
            Read_write : in  std_logic;
    
            Adresse    : in  std_logic_vector(5 downto 0);
            data_write : in  std_logic_vector(7 downto 0);
            data_read  : out std_logic_vector(7 downto 0)
        );
    end component;

    component UC
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
    end component;

    -- Controle Memoire
    signal Enable_mem : std_logic;
    signal Read_write : std_logic;

    -- Controle UT
    signal SEL_UAL       : std_logic;
    signal Load_Reg_Accu : std_logic;
    signal Load_Reg_Data : std_logic;
    signal Load_Carry    : std_logic;
    signal Init_Carry    : std_logic;

    -- Inter connexions
    signal Adresse      : std_logic_vector(5 downto 0);
    signal data_write   : std_logic_vector(7 downto 0);
    signal data_read    : std_logic_vector(7 downto 0);
    signal carry        : std_logic; 

begin

    UC_comp : UC port map (
        CE              => CE,
        CLK             => CLK,
        RST             => RST,
        Enable_Mem      => Enable_mem,
        Read_write      => Read_write,
        Sel_UAL         => SEL_UAL,
        Load_Reg_Accu   => Load_Reg_Accu,
        Load_Reg_Data   => Load_Reg_Data,
        Load_Carry      => Load_Carry,
        Init_Carry      => Init_Carry,
        carry           => carry,
        Adress_out      => Adresse,
        Data_in         => data_read
    );

    UT_comp : UT port map (
        CE              => CE,
        CLK             => CLK,
        RST             => RST,
        SEL_UAL         => SEL_UAL,
        Load_Reg_Accu   => Load_Reg_Accu,
        Load_Reg_Data   => Load_Reg_Data,
        Load_Carry      => Load_Carry,
        Init_Carry      => Init_Carry,
        carry           => Carry,
        data_in         => data_read,
        data_out        => data_write
    );

    Mem     : Memoire port map (
        CE         => CE,
        CLK        => CLK,
        Enable_mem => Enable_mem,
        Read_write => Read_write,
        Adresse    => Adresse,
        data_write => data_write,
        data_read  => data_read
    ); 

end Behavioral;
