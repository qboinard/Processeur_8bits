----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 02/26/2021 11:38:56 AM
-- Design Name: 
-- Module Name: top_level_tb - Behavioral
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

LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
 
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--USE ieee.numeric_std.ALL;
 
ENTITY top_level_tb IS
END top_level_tb;
 
ARCHITECTURE behavior OF top_level_tb IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT top_level
    PORT(
           reset      : in  STD_LOGIC;
           clk100M 	  : in  STD_LOGIC;
           AN         : out std_logic_vector(7 downto 0);
           Sevenseg   : out  STD_LOGIC_VECTOR (7 downto 0);
           LED 		  : out  STD_LOGIC_VECTOR (7 downto 0)
        );
    END COMPONENT;
    

   --Inputs
   signal reset      : std_logic := '0';
   signal clk100M    : std_logic := '0';
   signal clk_switch : std_logic := '1';

 	--Outputs
   signal AN       : std_logic_vector(7 downto 0);
   signal Sevenseg : std_logic_vector(7 downto 0);
   signal LED      : std_logic_vector(7 downto 0);

   -- Clock period definitions
   constant clk100M_period : time := 10 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: top_level PORT MAP (
          reset => reset,
          clk100M => clk100M,
		  AN => AN,
          Sevenseg => Sevenseg,
          LED => LED
        );

   -- Clock process definitions
   clk100M_process :process
   begin
		clk100M <= '0';
		wait for clk100M_period/2;
		clk100M <= '1';
		wait for clk100M_period/2;
   end process;
 

   -- Stimulus process
   stim_proc: process
   begin		
      reset <= '0';
      wait for 1000 ns;	
      reset <= '1';
      wait for clk100M_period*10000;
      reset <= '1';
      wait for 100 ns;	
      reset <= '1';
      wait for clk100M_period*1000;
      -- insert stimulus here 

      wait;
   end process;

END;