--------------------------------------------------------------------
--! \file      nBitBuffer.vhd
--! \date      See top of 'Version History'
--! \brief     D-H-EHE-SOC assignment-1
--!            n-bit buffer (D-FLIP-FLOP) 
--! \author    Remko Welling (WLGRW) remko.welling@han.nl
--! \copyright HAN TF ELT/ESE Arnhem 
--!
--! \todo Students that submit this code have to complete their details:
--!
--! - Student 1 name         : 
--! - Student 1 studentnumber: 
--! - Student 1 email address: 
--!
--! - Student 2 name         : 
--! - Student 2 studentnumber: 
--! - Student 2 email address: 
--!
--!
--! Version History:
--! ----------------
--!
--! Nr:    |Date:      |Author: |Remarks:
--! -------|-----------|--------|-----------------------------------
--! 001    |18-10-2019 |WLGRW   |Inital version
--! 002    |15-11-2020 |WLGRW   |Adapted version for H-EHE-SOC class
--! 003    |26-11-2020 |WLGRW   |Added student information, pin assignments, assignment description.
--! 
--! \todo Add revsion history when executing these assignments.
--!
--! \verbatim
--!
--! Figure 1: Layout DE10-Lite.
--!                                                  +--+
--!      DE10-Lite KEY, SW, LED, and HEX layout      |##| <= KEY0
--!                                                  +--+
--!                                                  |##| <= KEY1
--!                                                  +--+
--!
--!                                  9 8 7 6 5 4 3 2 1 0  <- Number
--!                                 +-+-+-+-+-+-+-+-+-+-+
--!       7-segment displays (HEX)  | | | | | | | | | | | <= Leds (LEDR)
--!      +---+---+---+---+---+---+  +-+-+-+-+-+-+-+-+-+-+
--!      |   |   |   |   |   |   |                     
--!      |   |   |   |   |   |   |  +-+-+-+-+-+-+-+-+-+-+
--!      | 8.| 8.| 8.| 8.| 8.| 8.|  | | | | | | | | | | |
--!      |   |   |   |   |   |   |  +-+-+-+-+-+-+-+-+-+-+
--!      |   |   |   |   |   |   |  |#|#|#|#|#|#|#|#|#|#| <= Switch (SW)
--!      +---+---+---+---+---+---+  +-+-+-+-+-+-+-+-+-+-+
--!        5   4   3   2   1   0     9 8 7 6 5 4 3 2 1 0  <- Number
--!
--! \endverbatim
--!
--! # Function description
--!
--! With this assignment a n-bit buffer will be implemented.
--!
--! The purpose of the n-bit buffer is a memory element that will hold n-bits
--! after a clock-puls is presented to input clk.
--!
--! n-bits means that with the use of GENERIC N the ENTITY can be changed and the 
--! width (vector length) of the buffer can be adapted to meet the required width.
--!
--! \verbatim
--!
--! Figure 2: input-output diagram n-bit buffer.
--!
--!               +--------+
--!           n   |        |
--!  input ---/---|        |   n
--!               | buffer |---/--- output
--!    clk -------|        |
--!               |        |
--!               +--------+
--!
--! \endverbatim
--!
--! When the n-bit buffer is programmed on the DE10-Lite board the switches, key
--! and leds are configured as displayed in figure 3.
--!
--! \verbatim
--!
--! Figure 3: GUI for n-but buffer on DE10-Lite.
--!
--!                   +--+
--!          clk ---> |##| <= KEY0
--!                   +--+
--!                   |##| <= KEY1
--!                   +--+
--!
--!               3 2 1 0  <- ouput[3..0]
--!  +-+-+-+-+-+-+-+-+-+-+
--!  | | | | | | |D|C|B|A| <= Leds (LEDR)
--!  +-+-+-+-+-+-+-+-+-+-+
--!                     
--!  +-+-+-+-+-+-+-+-+-+-+
--!  | | | | | | | | | | |
--!  +-+-+-+-+-+-+-+-+-+-+
--!  | | | | | | |D|C|B|A| <= Switch (SW)
--!  +-+-+-+-+-+-+-+-+-+-+
--!               3 2 1 0  <- input[3..0]
--!
--! \endverbatim
--!
--! # Assignment
--!
--! This assignment is split in to 4 tasks:
--!  A: Implement the n-bit buffer using concurent code in implementation 1
--!     of the ARCHITECTURE. 
--!  B: Implement the n-bit buffer using sequential code in implementation 2
--!     of the ARCHITECTURE. 
--!  C: Test the functionality of both ARCHITECTUREs using a waveform.
--!  D: Test the functionality of both ARCHITECTUREs using the DE10-Lite board.
--!
--! ## Assignment-A
--! 
--! Write VHDL code that implements the n-bit buffer using concurrent code.
--! 
--! See Pedroni paragraph "5.6 Implementing Sequential Circuits with 
--! Concurrent Code" for an explanation.
--! 
--! ## Assignment-B
--! 
--! Write VHDL code that implements the n-bit buffer using sequential code.
--! 
--! See Pedroni "example 6.1: DFFs with reset and Clear" for a example.
--! 
--! ## Assignment-C
--! 
--! Test both ARCHITECTUREs using waveforms and present the result.
--! 
--! ## Assignment-D
--! 
--! Test both ARCHITECTUREs by programming the project on a DE10-Lite.
--! 
--!
--! # Architecture selection
--! 
--! Select the architecture for compilation by uncommenting the architecture:
--!
--! - Uncomment to ARCHITECTURE implementation0 to select concurrent implementation
--! - Uncomment to ARCHITECTURE implementation1 to select sequential implementation
------------------------------------------------------------------------------
LIBRARY ieee;
USE ieee.std_logic_1164.all;
------------------------------------------------------------------------------
ENTITY nBitBuffer is

   GENERIC (
      N: INTEGER := 4
   );
   
   PORT (
      input  : IN     STD_LOGIC_VECTOR (N-1 DOWNTO 0); --! n-bit binary input
      clk    : IN     STD_LOGIC;                       --! trigger to initiate latch function
      output : BUFFER STD_LOGIC_VECTOR (N-1 DOWNTO 0)  --! n-bit binary output
   );
   
END ENTITY nBitBuffer;
------------------------------------------------------------------------------
ARCHITECTURE implementation0 OF nBitBuffer IS
BEGIN

--! Assignment-A: Implement here the concurrent VHDL code for the n-bit Buffer.

END ARCHITECTURE implementation0;
------------------------------------------------------------------------------
--ARCHITECTURE implementation1 OF nBitBuffer IS
--BEGIN
--
----! Assignment-B: Implement here the sequential VHDL code for the n-bit Buffer
--
--END ARCHITECTURE implementation1;
------------------------------------------------------------------------------