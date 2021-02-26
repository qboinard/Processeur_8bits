----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 02/24/2021 10:34:09 AM
-- Design Name: 
-- Module Name: compteur_tb - Behavioral
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

-- Testbench automatically generated online
-- at https://vhdl.lapinoo.net
-- Generation date : 26.2.2021 09:40:09 UTC

library ieee;
use ieee.std_logic_1164.all;

entity compteur_tb is
end compteur_tb;

architecture tb of compteur_tb is

    component compteur
        port (RST      : in std_logic;
              CLK      : in std_logic;
              CE       : in std_logic;
              init_cpt : in std_logic;
              load_cpt : in std_logic;
              en_cpt   : in std_logic;
              data_in  : in std_logic_vector (5 downto 0);
              data_out : out std_logic_vector (5 downto 0));
    end component;

    signal RST      : std_logic;
    signal CLK      : std_logic;
    signal CE       : std_logic;
    signal init_cpt : std_logic;
    signal load_cpt : std_logic;
    signal en_cpt   : std_logic;
    signal data_in  : std_logic_vector (5 downto 0);
    signal data_out : std_logic_vector (5 downto 0);

    constant TbPeriod : time := 10 ns; -- EDIT Put right period here
    signal TbClock : std_logic := '0';
    signal TbSimEnded : std_logic := '0';

begin

    dut : compteur
    port map (RST      => RST,
              CLK      => CLK,
              CE       => CE,
              init_cpt => init_cpt,
              load_cpt => load_cpt,
              en_cpt   => en_cpt,
              data_in  => data_in,
              data_out => data_out);

    -- Clock generation
    TbClock <= not TbClock after TbPeriod/2 when TbSimEnded /= '1' else '0';
    

    -- EDIT: Check that CLK is really your main clock signal
    CLK <= TbClock;

    stimuli : process
    begin
        -- EDIT Adapt initialization as needed
        CE <= '1';
        init_cpt <= '0';
        load_cpt <= '0';
        en_cpt <= '1';
        data_in <= (others => '0');

        -- Reset generation
        -- EDIT: Check that RST is really your reset signal
        RST <= '1';
        wait for 100 ns;
        RST <= '0';
        wait for 100 ns;

        -- EDIT Add stimuli here
        wait for 100 * TbPeriod;

        -- Stop the clock and hence terminate the simulation
        TbSimEnded <= '1';
        wait;
    end process;

end tb;