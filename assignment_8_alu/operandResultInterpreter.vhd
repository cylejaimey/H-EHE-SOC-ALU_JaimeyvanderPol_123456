--------------------------------------------------------------------
--! \file      operandResultInterpreter.vhd
--! \date      see top of 'Version History'
--! \brief     Interpreter of operand and result with carry and opcode
--! \author    Remko Welling (WLGRW) remko.welling@han.nl
--! \copyright HAN TF ELT/ESE Arnhem 
--!
--! \todo Students shall replace this file for the result of assignment 4
------------------------------------------------------------------------------
LIBRARY ieee;
USE ieee.std_logic_1164.all;  --! STD_LOGIC
USE ieee.numeric_std.all;     --! SIGNED
------------------------------------------------------------------------------
ENTITY operandResultInterpreter is

   PORT (
      opcode :           IN   STD_LOGIC_VECTOR(3 DOWNTO 0); --! 4-bit opcode
      result :           IN   STD_LOGIC_VECTOR(3 DOWNTO 0); --! n-bit binary input carrying Result
      signed_operation : IN   STD_LOGIC;
      hexSignal1,
      hexSignal0 :       OUT  STD_LOGIC_VECTOR(3 DOWNTO 0);
      dotSignal1,
      control1,
      dotSignal0,
      control0 :         OUT  STD_LOGIC
   );
   
END ENTITY operandResultInterpreter;
------------------------------------------------------------------------------
ARCHITECTURE implementation OF operandResultInterpreter IS
BEGIN

 dotSignal0 <=  '0';
 dotSignal1  <= '0';
 
 control0   <= '1'; -- linker display altijd extended characters 
 control1   <= '0'; -- rechter display altijd standaard characters
 
	-- linker display
	hexSignal0 <= "1111" WHEN signed_operation='0'                         ELSE -- Unsigned mode
					  "0010" WHEN result(3) = '1' AND signed_operation = '1'   ELSE -- Signed mode, negatieve waarde
					  "0001" WHEN result(3) = '0' AND signed_operation = '1';		 -- Signed mode, positieve waarde
	

   -- rechter display
	hexSignal1 <= result                             WHEN signed_operation = '0'                     ELSE -- Unsigned mode, het resultaat laten zien.
					  STD_LOGIC_VECTOR(-SIGNED(result))  WHEN signed_operation = '1' AND result(3) = '1' ELSE -- Signed mode, negatief resultaat
					  result                             WHEN signed_operation = '1' AND result(3) = '0';     -- Signed mode, positief resultaat
	                                                 

END ARCHITECTURE implementation;
------------------------------------------------------------------------------
