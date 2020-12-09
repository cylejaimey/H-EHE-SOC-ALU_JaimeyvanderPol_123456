--------------------------------------------------------------------
--! \file      operandResultInterpreter.vhd
--! \date      see top of 'Version History'
--! \brief     Interpreter of operand and result with carry and opcode
--! \author    Remko Welling (WLGRW) remko.welling@han.nl
--! \copyright HAN TF ELT/ESE Arnhem 
--!
--! \todo Students that submit this code have to complete their details:
--!
--! Student 1 name         : 
--! Student 1 studentnumber: 
--! Student 1 email address: 
--!
--! Student 2 name         : 
--! Student 2 studentnumber: 
--! Student 2 email address: 
--!
--!
--! Version History:
--! ----------------
--!
--! Nr:    |Date:      |Author: |Remarks:
--! -------|-----------|--------|-----------------------------------
--! 001    |22-10-2019 |WLGRW   |Inital version
--! 002    |25-11-2020 |WLGRW   |Adpted version for H-EHE-SOC class
--!
--! \todo Add revsion history when executing these assignments.
--!
--! Design:
--! -------
--! Figure 1 presents the input-output diagram of the artithmetic unit.
--! Depending on the opcode the artithmetic unit will apply the operation
--! as specified in table 1.
--! 
--!
--! \verbatim
--!
--!  Figure 1: Input-output diagram of the artithmetic unit.
--! 
--!                   +----------------+
--!               n   |                |
--!  Operand A ---/---|                |
--!                   |                |
--!               n   |                |
--!  Operand B ---/---|                |
--!                   | Arthmatic unit |   n+1
--!               3   |                |---/--- Result R
--!  Opcode F ----/---|                |
--!                   |                |
--!               4   |                |
--!  Flags P -----/---|                |
--!                   |                |
--!                   +----------------+
--!
--! \endverbatim
--!
--! Function:
--! -----------
--! Table 1: Opcodes and operations of the artithmetic unit.
--!
--! Opcode  | Functionality/Operation
--! --------|--------------------------------------------------------------------------------------
--! OP_CLRR | CLR R, clear R (R:=0), all flag bits are affected
--! OP_INCA | INC A, Increment A, R:=A+1, all flag bits are affected 
--! OP_DECA | DEC A, Decrement A, R:=A-1, all flag bits are affected
--! OP_ADD  | ADD A with B, R:=A+B, all flag bits are affected
--! OP_ADC  | ADC A with B and Carry, R:=A+B+C, all flag bits are affected
--! OP_ADB  | ADB A with B and Carry, R:=A+B+C using BCD arithmetic, C and Z flag bits are affected
--! OP_SUB  | SUB B from A, R:=A-B, flag bits are affected
--! OP_SBC  | SBC B from A including C, R:=A-B-C, flag bits are affected
--!
--! OP_AND  | AND A with B, R:=A AND B, bitwise AND, Z-flag bit is affected
--! OP_OR   | OR A with B, R:=A OR B, bitwise OR, Z-flag bit is affected
--! OP_XOR  | XOR A with B, R:=A XOR B, bitwise XOR, Z-flag bit is affected
--! OP_NOTA | NOT A, R:=NOT A, Z-flag bit is affected
--! OP_SHLA | SHL A, R:=SHL A, flag bits are not affected
--! OP_ROLA | ROL A, R:=ROL A, flag bits are not affected
--! OP_SHRA | SHR A, R:=SHR A, flag bits are not affected
--! OP_RORA | ROR A, R:=ROR A, flag bits are not affected

------------------------------------------------------------------------------
LIBRARY ieee;
USE ieee.std_logic_1164.all;  --! STD_LOGIC
USE ieee.numeric_std.all;     --! SIGNED
------------------------------------------------------------------------------
ENTITY operandResultInterpreter is

      --! Implement here CONSTANTS as GENERIC when required.

   PORT (
      opcode :           IN   STD_LOGIC_VECTOR(3 DOWNTO 0); --! 4-bit opcode
      result :           IN   STD_LOGIC_VECTOR(3 DOWNTO 0); --! n-bit binary input carrying Result
      signed_operation : IN   STD_LOGIC;
      hexSignal0,
      hexSignal1 :       OUT  STD_LOGIC_VECTOR(3 DOWNTO 0);
      dotSignal0,
      control0,
      dotSignal1,
      control1 :         OUT  STD_LOGIC
   );
   
END ENTITY operandResultInterpreter;
------------------------------------------------------------------------------
ARCHITECTURE implementation OF operandResultInterpreter IS

   -- Implement here the SIGNALS to your descretion

BEGIN

   -- Implement here your logic.

END ARCHITECTURE implementation;
------------------------------------------------------------------------------
