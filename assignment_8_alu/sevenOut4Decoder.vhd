------------------------------------------------------------------------------
--! \file      lsevenOut4Decoder.vhd
--! \date      see top of 'Version History'
--! \brief     Placegolder for 7 segment decoder with dot-driver and extended characters
--! \author    Remko Welling (WLGRW) remko.welling@han.nl
--! \copyright HAN TF ELT/ESE Arnhem 
--!
--! \todo Students shall replace this file for the result of assignment 2
------------------------------------------------------------------------------
LIBRARY ieee;
USE ieee.std_logic_1164.all;
------------------------------------------------------------------------------
ENTITY sevenOut4Decoder is

generic (
	
	
	constant hex_off:    STD_LOGIC_VECTOR(0 to 6) := "1111111";
	
	
	constant hex_zero:   STD_LOGIC_VECTOR(0 to 6) := "0000001";
	constant hex_one:    STD_LOGIC_VECTOR(0 to 6) := "1001111";
	constant hex_two:    STD_LOGIC_VECTOR(0 to 6) := "0010010";
	constant hex_three:  STD_LOGIC_VECTOR(0 to 6) := "0000110";
	constant hex_four:   STD_LOGIC_VECTOR(0 to 6) := "1001100";
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
	constant hex_plus:   STD_LOGIC_VECTOR(0 to 6) := "1001110";
	constant hex_min:    STD_LOGIC_VECTOR(0 to 6) := "1111110";
	

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
	constant b_hex_F:      STD_LOGIC_VECTOR(0 to 3) := "1111";
	constant b_hex_plus:   STD_LOGIC_VECTOR(0 to 3) := "0000";
	constant b_hex_min:    STD_LOGIC_VECTOR(0 to 3) := "0001"
	
	);

   PORT (
      input   : IN  STD_LOGIC_VECTOR(3 DOWNTO 0);
      dot     : IN  STD_LOGIC;                   
      ctrl    : IN  STD_LOGIC;                   
      display : OUT STD_LOGIC_VECTOR(0 TO 7);
		normal  : INOUT STD_LOGIC_VECTOR(0 TO 6);
		extended: INOUT STD_LOGIC_VECTOR(0 TO 6)		
   );
   
END ENTITY sevenOut4Decoder;
------------------------------------------------------------------------------
ARCHITECTURE implementation OF sevenOut4Decoder IS
BEGIN

   -- Step 1: Connect port "dot" to the dot-segment in the HEX display.
display(7) <= NOT dot;
   -- Display decoders. This code is using "WITH - SELECT" to encode 6 segments on
   -- a HEX diplay. This code is using the CONSTANTS that are defined at GENERIC.
   -- Step 2: Implement here the multiplexer that will present the normal characters.
with input select
      normal(0 to 6) <= 
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
           hex_F     when b_hex_F,
			  hex_off   when OTHERS;
	
   
   -- Step 3: Implement here the multiplexter that will the extended characters.
	WITH input SELECT
		extended(0 To 6) <=	hex_plus  WHEN b_hex_plus,
								   hex_min   WHEN b_hex_min,
								   "0000000" WHEN OTHERS;
   -- Step 4: Implement here the  selector of the normal characters and the 
   -- extended characters using the ctrl signal.
	WITH ctrl SELECT
		display(0 TO 6)  <=	normal WHEN '0',
									extended WHEN '1';


END ARCHITECTURE implementation;
------------------------------------------------------------------------------
