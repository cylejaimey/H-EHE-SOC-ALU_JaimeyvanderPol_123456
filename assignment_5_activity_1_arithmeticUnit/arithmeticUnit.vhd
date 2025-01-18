--------------------------------------------------------------------
--! \file      arithmeticUnit.vhd
--! \date      see top of 'Version History'
--! \brief     n-bit arithmetic unit
--! \author    Remko Welling (WLGRW) remko.welling@han.nl
--! \copyright HAN TF ELT/ESE Arnhem 
--!
--! \todo Students that submit this code have to complete their details:
--!
--! -Student 1 name         : 
--! -Student 1 studentnumber: 
--! -Student 1 email address: 
--! 
--! -Student 2 name         : 
--! -Student 2 studentnumber: 
--! -Student 2 email address: 
--!
--!
--! Version History:
--! ----------------
--!
--! Nr:    |Date:      |Author: |Remarks:
--! -------|-----------|--------|-----------------------------------
--! 001    |18-10-2019 |WLGRW   |Inital version
--! 002    |25-11-2020 |WLGRW   |Adapted for H-ESE-SOC class
--! 003    |9-12-2020  |WLGRW   |Modifications for assignment
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
--! Bin | Opcode  | Functionality/Operation
--! ----|---------|--------------------------------------------------------------------------------------
--! 000 | OP_CLRR | CLR R, clear R (R:=0), all flag bits are affected
--! 001 | OP_INCA | INC A, Increment A, R:=A+1, all flag bits are affected 
--! 010 | OP_DECA | DEC A, Decrement A, R:=A-1, all flag bits are affected
--! 011 | OP_ADD  | ADD A with B, R:=A+B, all flag bits are affected
--! 100 | OP_ADC  | ADC A with B and Carry, R:=A+B+C, all flag bits are affected
--! 101 | OP_ADB  | ADB A with B and Carry, R:=A+B+C using BCD arithmetic, C and Z flag bits are affected
--! 110 | OP_SUB  | SUB B from A, R:=A-B, flag bits are affected
--! 111 | OP_SBC  | SBC B from A including C, R:=A-B-C, flag bits are affected
--! 
------------------------------------------------------------------------------
LIBRARY ieee;
USE ieee.std_logic_1164.all;  --! STD_LOGIC
USE ieee.numeric_std.all;     --! SIGNED
------------------------------------------------------------------------------
ENTITY arithmeticUnit is

   GENERIC (
      N: INTEGER := 4  --! logic unit is designed for 4-bits
      
      --! Implement here CONSTANTS as GENERIC when required.
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
      A : IN  STD_LOGIC_VECTOR (N-1 DOWNTO 0); --! n-bit binary input
      B : IN  STD_LOGIC_VECTOR (N-1 DOWNTO 0); --! n-bit binary input
      P : IN  STD_LOGIC_VECTOR (3   DOWNTO 0); --! Flags input P(0)=Carry-bit
      F : IN  STD_LOGIC_VECTOR (2   DOWNTO 0); --! 3-bit opcode
      R : OUT STD_LOGIC_VECTOR (N   DOWNTO 0)  --! n+1-bit binary output
   );
   
END ENTITY arithmeticUnit;
------------------------------------------------------------------------------
ARCHITECTURE implementation OF arithmeticUnit IS
   
   -- Implement here the SIGNALS to your descretion
   
BEGIN

   -- Implement here your arithmetic unit.

END ARCHITECTURE implementation;
