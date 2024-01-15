--------------------------------------------------------------------
--! \file      component7Out4Decoder.vhd
--! \date      see top of 'Version History'
--! \brief     Exercises week 2 
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
--! Version History:
--! ----------------
--!
--! Nr: |Date:      |Author: |Remarks:
--! ----|-----------|--------|-----------------------------------
--! 001 |17-10-2019 |WLGRW   |Inital version
--! 006 |11-1-2021  |WLGRW   |Added control signals for updated driver.
--! 
--! 
--! \verbatim
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
--!
--! Function 1:
--! -----------
--! With this function Switches 0 to 3 (A) and 4 to 7 (B) are 
--! used as input and are connected to HEX0 and HEX1. See figure 1.
--! Switch 9 will toggle the dot of both HEX dipslays.
--!
--! \verbatim
--!  
--!  Figure 1: GUI for function 1 on DE10-Lite
--!                               
--!       7-segment displays (HEX)
--!      +---+---+---+---+---+---+
--!      |   |   |   |   |YYY|XXX|
--!      |   |   |   |   |YYY|XXX|  +-+-+-+-+-+-+-+-+-+-+
--!      |   |   |   |   |YYY|XXX|  | | | | | | | | | | |
--!      |   |   |   |   |YYY|XXX|  +-+-+-+-+-+-+-+-+-+-+
--!      |   |   |   |   |YYY|XXX|  |D|C|B|B|B|B|A|A|A|A| <= Switch (SW)
--!      +---+---+---+---+---+---+  +-+-+-+-+-+-+-+-+-+-+
--!                        1   0     9 8 7 6 5 4 3 2 1 0  <- Number
--!  A = input for HEX0
--!  B = input for HEX1
--!  C = input to swith to extended characters for HEX1
--!  D = input to toggle dot on displays HEX0 and HEX1.
--!  X = 7-segment display HEX0
--!  Y = 7-segment display HEX1
--!
--! \endverbatim
--!
--! Design:
--! -------
--! Figure 2 shows in a graphical way how the vectors are connected.
--!
--! Switches are defined as a STD_LOGIC_VECTOR 0 TO 9. 4 bits of the 
--! 9-bit vector are reversed (LSB <> MSB) using a SIGNAL STD_LOGIC_VECTOR 3 DOWNTO 0
--! because the 7 out of 4 decoder requires 3 DOWNTO 0 order of the vector.
--! This is repeated for both displays.
--!
--! The switch for the dot is aplied to dot on HEX0 and inverted to dot on HEX1.
--!
--! \verbatim
--!
--!  Figure 2: Architecture of the display driver.
--!
--! INPUT  SW  Reverse MSB-LSB   7out4dec             HEX
--!
--!                                                   +-+
--!        +-+     |\   /|       +---------+          |0|
--!        |0|   4 | \ / |    4  | 7 out   |          |1|
--! Binary |1|--/--|  X  |----/--|  of 4   |   6      |2|
--! data   |2|     | / \ |       | decoder |--/-------|3|
--!        |3|     |/   \|       |         |          |5|
--!        +-+                   +---------+      +---|6|
--! Dot----|9|------------------------------------+   +-+
--!        +-+                                    |   +-+
--!        +-+     |\   /|       +---------+     NOT  |0|
--!        |4|   4 | \ / |    4  | 7 out   |      |   |1|
--! Binary |5|--/--|  X  |----/--|  of 4   |   6  |   |2|
--! data   |6|     | / \ |       | decoder |--/-------|3|
--!        |7|     |/   \|     +-|         |      |   |5|
--!        +-+                 | +---------+      +---|6|
--! Ctrl---|8|-----------------+                      +-+
--!        +-+
--!
--! \endverbatim
--!
--------------------------------------------------------------------
LIBRARY ieee;                      -- this lib needed for STD_LOGIC
USE ieee.std_logic_1164.all;       -- the package with this info
--------------------------------------------------------------------
ENTITY component7Out4Decoder is

   PORT ( 
      SW   : IN  STD_LOGIC_VECTOR(0 TO 9);  --! Switches
      HEX0 : OUT STD_LOGIC_VECTOR(0 TO 7);  --! 7-signals to control leds in HEX-display
      HEX1 : OUT STD_LOGIC_VECTOR(0 TO 7)   --! 7-signals to control leds in HEX-display
   );

END ENTITY component7Out4Decoder;
--------------------------------------------------------------------
ARCHITECTURE implementation OF component7Out4Decoder IS

--! signals interconnectX are used to reverse MSB-LSB.
   SIGNAL interconnect0,
          interconnect1 : STD_LOGIC_VECTOR(3 DOWNTO 0);

--! Signals dot0 and dot1 are used to connect SW(9) to the dot on the 
--! decoder. signals control0 is assigned logic '0' while control1
--! is connected to SW(8).
   SIGNAL dot0,
          dot1,
          control0,
          control1 : STD_LOGIC;
BEGIN

--! Here MSB-LSB are reversed from 0 TO 3 to 0 DOWNTO 3 for input A
   interconnect0(0) <= SW(0);
   interconnect0(1) <= SW(1);
   interconnect0(2) <= SW(2);
   interconnect0(3) <= SW(3);
   
--! Here MSB-LSB are reversed from 4 TO 7 to 0 DOWNTO 3 for input B
   interconnect1(0) <= SW(4);
   interconnect1(1) <= SW(5);
   interconnect1(2) <= SW(6);
   interconnect1(3) <= SW(7);
   
--! Assigning SW(9) to dot of HEX0 and the inverse to dot1
   dot0 <= SW(9);
   dot1 <= NOT dot0;
   
--! Assigning SW(8) to control of both display and the inverse to dot1
   control0 <= '0';  -- Switch off extended characters
   control1 <= SW(8);
   
--! Here are two methods to associate ports and signals to a component:
--!
--! Method 1:
--! ---------
--! Here the ports of component "sevenOut4Decoder" are mapped to SIGNALS and 
--! PORTS that are availabale in this ENTITY. When using this method
--! the order in which the PORTs are mapped is not relevant because
--! each individual PORT is mentioned and mapped.

   Display1 : work.sevenOut4Decoder port map ( 
      input   => interconnect1,  --! map to SIGNAL 
      dot     => dot1,           --! map to SIGNAL
      display => HEX1,           --! map to PORT
      ctrl    => control1        --! Control signal to enable extended characters
   );                            --! 7-segment decoder 1
      
 
--! Method 2:
--! ---------
--! When using this method the order in which the PORTs are mapped is relevant 
--! because the individual PORT are not mentioned. Mapping is executed in the 
--! order as written. 

   Display0 : work.sevenOut4Decoder port map (interconnect0, dot0, control0, HEX0);  -- 7-segment decoder 0


END ARCHITECTURE implementation;
--------------------------------------------------------------------
