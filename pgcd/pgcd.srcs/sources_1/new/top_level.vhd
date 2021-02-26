----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 02/26/2021 11:26:56 AM
-- Design Name: 
-- Module Name: top_level - Behavioral
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
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity top_level is
    Port ( reset 		 : in  STD_LOGIC;
           clk100M 	     : in  STD_LOGIC;
	 	   AN            : out STD_LOGIC_VECTOR(7 downto 0);
           Sevenseg 	 : out STD_LOGIC_VECTOR (7 downto 0);
           LED 		     : out STD_LOGIC_VECTOR (7 downto 0)
			 );
end top_level;

architecture Behavioral of top_level is

component CPU
    Port ( CLK 					 : in  STD_LOGIC;
	       CE					 : in  STD_LOGIC;
           RST   				 : in  STD_LOGIC;  
		   Adresse				 : out  STD_LOGIC_VECTOR (5 downto 0);
		   Mem_in		     	 : out  STD_LOGIC_VECTOR (7 downto 0);
		   Mem_out		    	 : out  STD_LOGIC_VECTOR (7 downto 0));
end component;

component acces_carte 
    port (clk 		    : in std_logic;
	 	  reset  		: in std_logic;
          AdrLSB 		: in std_logic_vector(3 downto 0);
          AdrMSB 		: in std_logic_vector(1 downto 0);
          DataLSB		: in std_logic_vector(3 downto 0);
          DataMSB		: in std_logic_vector(3 downto 0);
          DataInMem		: in std_logic_vector(7 downto 0);
	 	  ce1s  		: out std_logic;
	      ce25M  		: out std_logic;
	 	  AN            : out std_logic_vector(7 downto 0);
	 	  Sseg 			: out std_logic_vector(7 downto 0);
	 	  LED  			: out std_logic_vector(7 downto 0);
		  LEDg 			: out std_logic);
end component;

signal Data_Mem_Unit    : STD_LOGIC_VECTOR (7 downto 0);
signal Data_Unit_Mem    : STD_LOGIC_VECTOR (7 downto 0);
signal Adr           	: STD_LOGIC_VECTOR (5 downto 0);
signal sig_clk			: STD_LOGIC;
signal ce1s 			: STD_LOGIC;
signal ce25M			: STD_LOGIC;
signal LEDg 			: STD_LOGIC;
signal sig_locked   	: STD_LOGIC;
signal sig_reset        : STD_LOGIC;

constant zero           : STD_LOGIC := '0';

begin

sig_reset <= not (reset);
sig_clk   <= clk100M;

-- Attention pour la simulation mettre  ce de UT et UC ? ce25M sinon ce1s
														  
proc  				 : CPU port map ( CLK => sig_clk,
                                      CE  => ce1s,
									  RST => sig_reset, 
									  Adresse => Adr,
									  Mem_in  => Data_Unit_Mem,
									  Mem_out => Data_Mem_Unit);


Peripheriques 	 : acces_carte  port map (sig_clk,
										  sig_reset, 
										  Adr(3 downto 0), 
										  Adr(5 downto 4),
										  Data_Unit_Mem(3 downto 0), 
										  Data_Unit_Mem(7 downto 4),
										  Data_Mem_Unit,
										  ce1s,  
										  ce25M, 
										  AN,
										  Sevenseg, 
										  LED, 
										  LEDg);		
end Behavioral;
