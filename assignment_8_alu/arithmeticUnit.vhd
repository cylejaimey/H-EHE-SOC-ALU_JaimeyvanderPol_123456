--------------------------------------------------------------------
--! \file      arithmeticUnit.vhd
--! \date      see top of 'Version History'
--! \brief     n-bit arithmetic unit
--! \author    Remko Welling (WLGRW) remko.welling@han.nl
--! \copyright HAN TF ELT/ESE Arnhem 
--!
--! \todo Students shall replace this file for the result of assignment 3
------------------------------------------------------------------------------
LIBRARY ieee;
USE ieee.std_logic_1164.all;  --! STD_LOGIC
USE ieee.numeric_std.all;     --! SIGNED
USE ieee.std_logic_unsigned.all;
------------------------------------------------------------------------------
ENTITY arithmeticUnit is

   GENERIC (
      N: INTEGER := 4;  --! logic unit is designed for 4-bits
	  CONSTANT OP_CLRR: STD_LOGIC_VECTOR (2   DOWNTO 0) := "000";
	  CONSTANT OP_INCA: STD_LOGIC_VECTOR (2   DOWNTO 0) := "001";
	  CONSTANT OP_DECA: STD_LOGIC_VECTOR (2   DOWNTO 0) := "010";
	  CONSTANT  OP_ADD: STD_LOGIC_VECTOR (2   DOWNTO 0) := "011";
	  CONSTANT  OP_ADC: STD_LOGIC_VECTOR (2   DOWNTO 0) := "100";
	  CONSTANT  OP_ADB: STD_LOGIC_VECTOR (2   DOWNTO 0) := "101";
	  CONSTANT  OP_SUB: STD_LOGIC_VECTOR (2   DOWNTO 0) := "110";
	  CONSTANT  OP_SBC: STD_LOGIC_VECTOR (2   DOWNTO 0) := "111"
   );
   
   PORT (
      A : IN  STD_LOGIC_VECTOR (N-1 DOWNTO 0);
      B : IN  STD_LOGIC_VECTOR (N-1 DOWNTO 0);
      P : IN  STD_LOGIC_VECTOR (3   DOWNTO 0);
      F : IN  STD_LOGIC_VECTOR (2   DOWNTO 0);
      R : OUT STD_LOGIC_VECTOR (N   DOWNTO 0) 
   );
   
END ENTITY arithmeticUnit;
------------------------------------------------------------------------------
ARCHITECTURE implementation OF arithmeticUnit IS
BEGIN

WITH F SELECT
  R(3 DOWNTO 0) <=
"0000" WHEN OP_CLRR,
 A + 1 WHEN OP_INCA,
 A - 1 WHEN OP_DECA,
 A + B WHEN OP_ADD,
 A + B + P(0) WHEN OP_ADC,
 A + B + P(0) WHEN OP_ADB,
 A - B WHEN OP_SUB,
 A - B - P(0) WHEN OP_SBC,
 NULL  WHEN OTHERS;
 
END ARCHITECTURE implementation;
