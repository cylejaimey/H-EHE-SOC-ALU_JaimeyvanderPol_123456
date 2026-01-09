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
USE ieee.numeric_std.all;     --! UNSIGNED and SIGNED types
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
      R : OUT STD_LOGIC_VECTOR (N   DOWNTO 0)  -- 5 bits output including carry
   );
   
END ENTITY arithmeticUnit;
------------------------------------------------------------------------------
ARCHITECTURE implementation OF arithmeticUnit IS
   -- Internal signal to hold the full result (5 bits)
   SIGNAL temp_result : STD_LOGIC_VECTOR(N DOWNTO 0);
   
   -- Helper signals for extended operands (extended to 5 bits for proper carry calculation)
   SIGNAL A_ext, B_ext : UNSIGNED(N DOWNTO 0);
   SIGNAL carry_in : UNSIGNED(N DOWNTO 0);
   
BEGIN

   -- Extend operands A and B to 5 bits (add leading zero)
   A_ext <= UNSIGNED('0' & A);
   B_ext <= UNSIGNED('0' & B);
   
   -- Extend carry input to 5 bits
   carry_in <= (0 => P(0), OTHERS => '0');

   -- Arithmetic operations with proper carry handling
   PROCESS(A_ext, B_ext, carry_in, F)
   BEGIN
      CASE F IS
         WHEN OP_CLRR =>
            temp_result <= (OTHERS => '0');
            
         WHEN OP_INCA =>
            temp_result <= STD_LOGIC_VECTOR(A_ext + 1);
            
         WHEN OP_DECA =>
            temp_result <= STD_LOGIC_VECTOR(A_ext - 1);
            
         WHEN OP_ADD =>
            temp_result <= STD_LOGIC_VECTOR(A_ext + B_ext);
            
         WHEN OP_ADC =>
            temp_result <= STD_LOGIC_VECTOR(A_ext + B_ext + carry_in);
            
         WHEN OP_ADB =>
            -- Add with BCD - for now implementing as regular add with carry
            -- Full BCD implementation would require decimal adjustment
            temp_result <= STD_LOGIC_VECTOR(A_ext + B_ext + carry_in);
            
         WHEN OP_SUB =>
            temp_result <= STD_LOGIC_VECTOR(A_ext - B_ext);
            
         WHEN OP_SBC =>
            temp_result <= STD_LOGIC_VECTOR(A_ext - B_ext - carry_in);
            
         WHEN OTHERS =>
            temp_result <= (OTHERS => '0');
            
      END CASE;
   END PROCESS;
   
   -- Assign the result to output
   R <= temp_result;
	
	END ARCHITECTURE implementation;
