--------------------------------------------------------------------
--! \file      sevenOut4Decoder.vhd
--! \date      see top of 'Version History'
--! \brief     7 segment decoder with dot-driver and extended characters
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
--!h
--! \endverbatim
--!
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
entity sevenOut4Decoder is

   generic (
	
	
	constant hex_off:    STD_LOGIC_VECTOR(0 to 6) := "1111111";
	constant hex_minus:  STD_LOGIC_VECTOR(0 to 6) := "1111110";
	constant hex_plus:   STD_LOGIC_VECTOR(0 to 6) := "1001101";
	
	constant hex_zero:   STD_LOGIC_VECTOR(0 to 6) := "0000001";
	constant hex_one:    STD_LOGIC_VECTOR(0 to 6) := "1001111";
	constant hex_two:    STD_LOGIC_VECTOR(0 to 6) := "0010010";
	constant hex_three:  STD_LOGIC_VECTOR(0 to 6) := "0000110";
	constant hex_four:   STD_LOGIC_VECTOR(0 to 6) := "1001010";
	constant hex_five:   STD_LOGIC_VECTOR(0 to 6) := "0100100";
	constant hex_six:    STD_LOGIC_VECTOR(0 to 6) := "0100000";
	constant hex_seven:  STD_LOGIC_VECTOR(0 to 6) := "0001111";
	constant hex_eight:  STD_LOGIC_VECTOR(0 to 6) := "0000000";
	constant hex_nine:   STD_LOGIC_VECTOR(0 to 6) := "0001100";
	constant hex_A:      STD_LOGIC_VECTOR(0 to 6) := "0001000";
	constant hex_B:      STD_LOGIC_VECTOR(0 to 6) := "1100000";
	constant hex_C:      STD_LOGIC_VECTOR(0 to 6) := "0110001";
	constant hex_D:      STD_LOGIC_VECTOR(0 to 6) := "1000010";
	constant hex_E:      STD_LOGIC_VECTOR(0 to 6) := "0110000";
	constant hex_F:      STD_LOGIC_VECTOR(0 to 6) := "0111000";

	constant b_hex_zero:   STD_LOGIC_VECTOR(0 to 3) := "0000";
	constant b_hex_one:    STD_LOGIC_VECTOR(0 to 3) := "0001";
	constant b_hex_two:    STD_LOGIC_VECTOR(0 to 3) := "0010";
	constant b_hex_three:  STD_LOGIC_VECTOR(0 to 3) := "0011";
	constant b_hex_four:   STD_LOGIC_VECTOR(0 to 3) := "0100";
	constant b_hex_five:   STD_LOGIC_VECTOR(0 to 3) := "0101";
	constant b_hex_six:    STD_LOGIC_VECTOR(0 to 3) := "0110";
	constant b_hex_seven:  STD_LOGIC_VECTOR(0 to 3) := "0111";
	constant b_hex_eight:  STD_LOGIC_VECTOR(0 to 3) := "1000";
	constant b_hex_nine:   STD_LOGIC_VECTOR(0 to 3) := "1001";
	constant b_hex_A:      STD_LOGIC_VECTOR(0 to 3) := "1010";
	constant b_hex_B:      STD_LOGIC_VECTOR(0 to 3) := "1011";
	constant b_hex_C:      STD_LOGIC_VECTOR(0 to 3) := "1100";
	constant b_hex_D:      STD_LOGIC_VECTOR(0 to 3) := "1101";
	constant b_hex_E:      STD_LOGIC_VECTOR(0 to 3) := "1110";
	constant b_hex_F:      STD_LOGIC_VECTOR(0 to 3) := "1111"
	
	);
   
   PORT (
      input   : IN  STD_LOGIC_VECTOR(3 DOWNTO 0); --! 4-bit binary input
      dot     : IN  STD_LOGIC;                    --! Single line to control dot
      ctrl    : IN  STD_LOGIC;                    --! Control bit to access special functions
      display : OUT STD_LOGIC_VECTOR(0 TO 7)  --! 7-signals to control leds in HEX-display
   );
   
END ENTITY sevenOut4Decoder;
------------------------------------------------------------------------------
ARCHITECTURE implementation OF sevenOut4Decoder IS
   
   -- add here signals to your descretion
   
BEGIN

   -- Step 1: Connect port "dot" to the dot-segment in the HEX display.
display(7) <= NOT dot;
   -- Display decoders. This code is using "WITH - SELECT" to encode 6 segments on
   -- a HEX diplay. This code is using the CONSTANTS that are defined at GENERIC.
with input select
display(0 to 6) <= 
           hex_zero  when b_hex_zero, 
           hex_one   when b_hex_one,  
           hex_two   when b_hex_two,  
           hex_three when b_hex_three,
           hex_four  when b_hex_four, 
           hex_five  when b_hex_five, 
           hex_six   when b_hex_six,  
           hex_seven when b_hex_seven,
           hex_eight when b_hex_eight,
           hex_nine  when b_hex_nine, 
           hex_A     when b_hex_A,    
           hex_B     when b_hex_B,    
           hex_C     when b_hex_C,
           hex_D     when b_hex_D,    
           hex_E     when b_hex_E,    
           hex_F     when b_hex_F;

	

   -- Step 2: Implement here the multiplexer that will present the normal characters.
   
   -- Step 3: Implement here the multiplexter that will the extended characters.

   -- Step 4: Implement here the  selector of the normal characters and the 
   -- extended characters using the ctrl signal.


END ARCHITECTURE implementation;
------------------------------------------------------------------------------
