--------------------------------------------------------------------
--! \file      flagHandler.vhd
--! \date      see top of 'Version History'
--! \brief     Generate flags for ALU
--! \author    Remko Welling (WLGRW) remko.welling@han.nl
--! \copyright HAN TF ELT/ESE Arnhem 
--!
--! Version History:
--! ----------------
--!
--! Nr:    |Date:      |Author: |Remarks:
--! -------|-----------|--------|-----------------------------------
--! 001    |24-11-2020 |WLGRW   |Inital version
--! 002    |25-11-2020 |WLGRW   |Adapted version for H-EHE-SOC class
--! 003    |7-4-2021 0 |WLGRW   |Corrected Zero flag handling 
--!
--! Map named signals to flag register for output flagResult consists of 4 flags:
--!  - Carry (C-flag)
--!  - Sign (S-flag)
--!  - oVerflow (V-flag)
--!  - Zero (Z-Flag)
--! flagResult has the bit sequence CSVZ (C = MSB).
--!
--! Opcodes
--! -------
--!
--!   Bin  | Opcode  | Functionality/Operation
--!   -----|---------|--------------------------------------------------------------------------------------
--!   0000 | OP_CLRR | CLR R, clear R (R:=0), all flag bits are affected
--!   0001 | OP_INCA | INC A, Increment A, R:=A+1, all flag bits are affected 
--!   0010 | OP_DECA | DEC A, Decrement A, R:=A-1, all flag bits are affected
--!   0011 | OP_ADD  | ADD A with B, R:=A+B, all flag bits are affected
--!   0100 | OP_ADC  | ADC A with B and Carry, R:=A+B+C, all flag bits are affected
--!   0101 | OP_ADB  | ADB A with B and Carry, R:=A+B+C using BCD arithmetic, C and Z flag bits are affected
--!   0110 | OP_SUB  | SUB B from A, R:=A-B, flag bits are affected
--!   0111 | OP_SBC  | SBC B from A including C, R:=A-B-C, flag bits are affected
--!   1000 | OP_AND  | AND A with B, R:=A AND B, bitwise AND, Z-flag bit is affected
--!   1001 | OP_OR   | OR A with B, R:=A OR B, bitwise OR, Z-flag bit is affected
--!   1010 | OP_XOR  | XOR A with B, R:=A XOR B, bitwise XOR, Z-flag bit is affected
--!   1011 | OP_NOTA | NOT A, R:=NOT A, Z-flag bit is affected
--!   1100 | OP_SHLA | SHL A, R:=SHL A, flag bits are not affected
--!   1101 | OP_ROLA | ROL A, R:=ROL A, flag bits are not affected
--!   1110 | OP_SHRA | SHR A, R:=SHR A, flag bits are not affected
--!   1111 | OP_RORA | ROR A, R:=ROR A, flag bits are not affected


--  #########################################################################
--  #########################################################################
--  ##                                                                     ##
--  ##                                                                     ##
--  ## The flag-handler is delivered as is and is not part of assignments  ##
--  ##                                                                     ##
--  ##      No modification or adaptations by students are required        ##
--  ##                                                                     ##
--  #########################################################################
--  #########################################################################

------------------------------------------------------------------------------
LIBRARY ieee;
USE ieee.std_logic_1164.all;  -- STD_LOGIC
USE ieee.numeric_std.all;     -- SIGNED
------------------------------------------------------------------------------
ENTITY flagHandler is

   GENERIC (
      CARRY_FLAG:     INTEGER := 0; 
      SIGN_FLAG:      INTEGER := 1;
      OVER_FLOW_FLAG: INTEGER := 2;
      ZERO_FLAG:      INTEGER := 3
   );
   
   PORT (
      signedOperation :  IN STD_LOGIC;
      operandA,
      operandB,
      opcode,                                              --! 4-bit opcode
      flagStatus,
      logicResult :      IN  STD_LOGIC_VECTOR(3 DOWNTO 0); --! n-bit binary input carrying Result
      arithmeticresult : IN  STD_LOGIC_VECTOR(4 DOWNTO 0);
      flagResult :       OUT STD_LOGIC_VECTOR(3 DOWNTO 0)
   );
   
END ENTITY flagHandler;
------------------------------------------------------------------------------
ARCHITECTURE implementation OF flagHandler IS

   SIGNAL carryFlag,             --! carry flag
          signFlag,              --! Sign flag
          oVerflowFlag,          --! overflow flag
          zeroFlag : STD_LOGIC;  --! zero flag
          
BEGIN
  
   flagResult(CARRY_FLAG)     <= carryFlag;
   flagResult(SIGN_FLAG)      <= signFlag;
   flagResult(OVER_FLOW_FLAG) <= oVerflowFlag;
   flagResult(ZERO_FLAG)      <= zeroFlag; 

--! FLAG handling
   
   --! Transport carry from arithmetic result to carry flag.
   carryFlag <= arithmeticresult(4) WHEN opcode(3)='0';

   --!
   oVerflowFlag <= '1' WHEN (opcode(3 DOWNTO 1) = "010" AND operandA(3)=operandB(3)     AND arithmeticresult(3)=NOT operandA(3)) OR   -- for ADD and ADC
                            (opcode(3 DOWNTO 1) = "011" AND operandA(3)=NOT operandB(3) AND arithmeticresult(3)=NOT operandA(3)) ELSE -- for SUB and SBC
                   '1' WHEN (opcode = "0101" AND SIGNED(arithmeticresult) > 9) OR (opcode = "0101" AND SIGNED(arithmeticresult) < -9) ELSE
                   '0' WHEN  opcode(3 DOWNTO 2) = "01" ELSE
                   oVerflowFlag;

   --! 
   signFlag <= signedOperation;
   
   --! Z-flag looks only at content of c, independant of (un)signed:
   zeroFlag <= '1' WHEN (UNSIGNED(opcode) < "1000") AND (arithmeticresult = "00000") ELSE -- Arthmic operation result is 0 and no carry
               '1' WHEN (UNSIGNED(opcode) < "1000") AND (arithmeticresult = "10000") ELSE -- Arthmic operation result is 0 with carry
               '0' WHEN (UNSIGNED(opcode) < "1000") ELSE
               zeroFlag;

END ARCHITECTURE implementation;
------------------------------------------------------------------------------