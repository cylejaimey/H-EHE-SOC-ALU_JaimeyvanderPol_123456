--------------------------------------------------------------------
--! \file      lsevenOut4Decoder.vhd
--! \date      see top of 'Version History'
--! \brief     7 segment decoder with dot-driver and extended characters
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
--! 001    |25-2-2015  |WLGRW   |Inital version
--! 002    |28-3-20159 |WLGRW   |Modification to set dot in display
--! 003    |17-10-2019 |WLGRW   |Updated for use in LOGCIR labs
--! 004    |22-12-2019 |WLGRW   |added constants for all numbers and signs
--! 005    |25-11-2020 |WLGRW   |Updated for H-EHE-SOC class
--!
--! \todo Add revsion history when executing these assignments.
--!
--! 
--! 
--! \verbatim
--!  
--!  Figure 1: Layout DE10-Lite
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
--!      |   |   |   |   |   |   |  | | | | | | | | | | |
--!      |   |   |   |   |   |   |  +-+-+-+-+-+-+-+-+-+-+
--!      |   |   |   |   |   |   |  |#|#|#|#|#|#|#|#|#|#| <= Switch (SW)
--!      +---+---+---+---+---+---+  +-+-+-+-+-+-+-+-+-+-+
--!        5   4   3   2   1   0     9 8 7 6 5 4 3 2 1 0  <- Number
--!
--! \endverbatim


--! Design:
--! -------
--! Figure 2 presents the input-output diagram of the 7 out of 4 decoder.
--! 
--! \verbatim
--!
--!  Figure 2: Input-output diagram of the display driver.
--! 
--!              +---------+
--!          4   |         |
--! input ---/---|         |
--!              |         |   7
--!   dot -------|         |---/--- display
--!              |         |
--!  ctrl -------|         |
--!              |         |
--!              +---------+
--! 
--! \endverbatim
--!
--! Function 1:
--! -----------
--! With this function Switches 0 to 3 are used as input and will
--! be connected to port "input". Switch 4 is used to switch the 
--! "dot" in the HEX display on and off. 
--! HEX0 is used to display the input values and is connected to 
--! port "display". See figure 3:
--!
--! \verbatim
--!  
--!  Figure 3: GUI for function 1 on DE10-Lite
--!                               
--!       7-segment displays (HEX)
--!      +---+---+---+---+---+---+
--!      |   |   |   |   |   |ZZZ|
--!      |   |   |   |   |   |ZZZ|  +-+-+-+-+-+-+-+-+-+-+
--!      |   |   |   |   |   |ZZZ|  | | | | | | | | | | |
--!      |   |   |   |   |   |ZZZ|  +-+-+-+-+-+-+-+-+-+-+
--!      |   |   |   |   |   |ZZZ|  | | | | | |Y|X|X|X|X| <= Switch (SW)
--!      +---+---+---+---+---+---+  +-+-+-+-+-+-+-+-+-+-+
--!                            0               4 3 2 1 0  <- Number
--!  X = port "input"
--!  Y = port "dot"
--!  Z = port "display"
--!
--! \endverbatim
--!

------------------------------------------------------------------------------
LIBRARY ieee;
USE ieee.std_logic_1164.all;
------------------------------------------------------------------------------
ENTITY sevenOut4Decoder is
-- Constants to enhance readability of the VHDL code:

--   GENERIC ( -- REMOVE this comment when adding a CONSTANT

--! These constants are used to make the VHDL code more readable.
--! Beacuse we will create both numbers and alphanumeric characters in the 
--! display the caharacters are defined as CONSTANTS in the GENERIC part of the
--! entity. This will simplify maintaining the code because CONSTANTs can be 
--! defined once and reused many times.
--! 
--! The following constants are defined to generate alle required characters.
--! Each led in the HEX_display has been given a number for the purpose of 
--! identification. See figure 2.
--!
--! \verbatim
--!
--!  Figure 2: 7-segments lay-out:
--!  
--!        -0-
--!       |   |
--!       5   1
--!       |   |
--!        -6-
--!       |   |
--!       4   2
--!       |   |
--!        -3-  7 (dot)
--!  
--! \endverbatim
--!
--! All LEDs are grouped in a STD_LOGIC_VECTOR where the index number is
--! equal to the LED number. 
--!
--! Because the LEDs are contolled using inverted-logic we have to apply a
--! '1' to switch the LED off. 

   -- Implement here CONSTANT

--   ); -- REMOVE this comment when adding a CONSTANT
   
   PORT (
      input   : IN  STD_LOGIC_VECTOR(3 DOWNTO 0); --! 4-bit binary input
      dot     : IN  STD_LOGIC;                    --! Single line to control dot
      ctrl    : IN  STD_LOGIC;                    --! Control bit to access special functions
      display : OUT STD_LOGIC_VECTOR(0 TO 7)      --! 7-signals to control leds in HEX-display
   );
   
END ENTITY sevenOut4Decoder;
------------------------------------------------------------------------------
ARCHITECTURE implementation OF sevenOut4Decoder IS
   
   -- add here signals to your descretion
   
BEGIN

   -- Step 1: Connect port "dot" to the dot-segment in the HEX display.

   -- Display decoders. This code is using "WITH - SELECT" to encode 6 segments on
   -- a HEX diplay. This code is using the CONSTANTS that are defined at GENERIC.

   -- Step 2: Implement here the multiplexer that will present the normal characters.
   
   -- Step 3: Implement here the multiplexter that will the extended characters.

   -- Step 4: Implement here the  selector of the normal characters and the 
   -- extended characters using the ctrl signal.


END ARCHITECTURE implementation;
------------------------------------------------------------------------------
