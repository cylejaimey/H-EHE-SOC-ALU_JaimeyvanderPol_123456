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
--! 002    |25-11-2020 |WLGRW   |Adapted version for H-EHE-SOC class
--! 003    |19-12-2020 |WLGRW   |Version created to be used as assignment
--!
--! \todo Add revsion history when executing these assignments.
--!
--! Function
--! --------
--!
--! The purpose of the unit is to control 2 7-segment displays (HEX-displays)
--! and present the result of the ALU operation of both displays.
--!
--! In the ALU, operand A and B as well as the result R are presented on 2 
--! HEX-displays. The left display can present the number 1, the symbols '+'
--! and '-' or switched off. The right display will present the hexadecimal 
--! numbers 0 to F. See figure 1.
--!
--! \verbatim
--!
--!  Figure 1: arrangement of HEX displays for operand or result.
--!
--!   Left (0)  Right (1)
--!    Display   Display
--!   +-------+ +-------+
--!   |  --   | |  --   |
--!   | |  |  | | |  |  |
--!   |  --   | |  --   |
--!   | |  |  | | |  |  |
--!   |  -- o | |  -- o |
--!   +-------+ +-------+
--!
--! \endverbatim
--!
--! HEX display 0 is primary controlled by the signed-operation signal. 
--! in SIGNED operation it is switched on and in UNSIGNED operation off.
--! When the opcode ADB is executed HEX 0 will present a '1' when a carry occurs. 
--!
--! HEX display 1 present the hexadecimal numbers 0 to F.
--!
--! The dot-led is not used with the ALU and therefore always switched off.
--!
--! Design
--! ------
--!
--! Figure 2 presents the input-output diagram of the operand-result-interpreter.
--!
--! \verbatim
--!
--!  Figure 2: Input-output diagram of the operand-result-interpreter.
--! 
--!                 +----------------+   4
--!                 |                |---/--- hexSignal 0     \
--!             4   |                |                        |
--!  Result ----/---|                |------- dotSignal 0     +-> 1st 7-segment display
--!                 |              t |                        |
--!             4   |    Operand     |------- controlSignal 0 /
--!  Opcode ----/---|     result     |   4
--!                 |   Interpreter  |---/--- hexSignal 0     \
--!                 |                |                        |
--!  Signed ops ----|                |------- dotSignal 0     +-> 2nd 7-segment display
--!                 |                |                        |
--!                 |                |------- controlSignal 0 /
--!                 +----------------+
--!
--! \endverbatim
--!
--! Opcodes and operations of the ALU
--! ---------------------------------
--! The following table is for reference purpose.
--!
--! Table 1: Opcodes and operations of the ALU.
--!
--! Bin  | Opcode  | Functionality/Operation
--! -----|---------|--------------------------------------------------------------------------------------
--! 0000 | OP_CLRR | CLR R, clear R (R:=0), all flag bits are affected
--! 0001 | OP_INCA | INC A, Increment A, R:=A+1, all flag bits are affected 
--! 0010 | OP_DECA | DEC A, Decrement A, R:=A-1, all flag bits are affected
--! 0011 | OP_ADD  | ADD A with B, R:=A+B, all flag bits are affected
--! 0100 | OP_ADC  | ADC A with B and Carry, R:=A+B+C, all flag bits are affected
--! 0101 | OP_ADB  | ADB A with B and Carry, R:=A+B+C using BCD arithmetic, C and Z flag bits are affected
--! 0110 | OP_SUB  | SUB B from A, R:=A-B, flag bits are affected
--! 0111 | OP_SBC  | SBC B from A including C, R:=A-B-C, flag bits are affected
--!        
--! Bin  | Opcode  | Functionality/Operation
--! -----|---------|-------------------------------------------------------------------
--! 1000 | OP_AND  | AND A with B, R:=A AND B, bitwise AND, Z-flag bit is affected
--! 1001 | OP_OR   | OR A with B, R:=A OR B, bitwise OR,    Z-flag bit is affected
--! 1010 | OP_XOR  | XOR A with B, R:=A XOR B, bitwise XOR, Z-flag bit is affected
--! 1011 | OP_NOTA | NOT A, R:=NOT A,                       Z-flag bit is affected
--! 1100 | OP_SHLA | SHL A, R:=SHL A,                       flag bits are not affected
--! 1101 | OP_ROLA | ROL A, R:=ROL A,                       flag bits are not affected
--! 1110 | OP_SHRA | SHR A, R:=SHR A,                       flag bits are not affected
--! 1111 | OP_RORA | ROR A, R:=ROR A,                       flag bits are not affected

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
