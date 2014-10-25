;=================================================
; Name: <Goshtasbi, Rashid>
; Username: rgosh001
; 
; Assignment name: <assn 3>
; Lab section: 023
; TA: Bryan Marsh
; 
; I hereby certify that I have not received assistance on this assignment,
; or used code, from ANY outside source other than the instruction team.
;
;=================================================


.ORIG x3000    ;PROGRAM BEGINS HERE
   ;---
   ;INSTRUCTIONS
   ;---
   LEA R0, NUM_DEC         ;Prints to screen number information is
   TRAP x22
   
   LD R3, COUNT            ;Holds count for loop for 16 times(aka 16-bits)   
   LD R2, NUM              ;Puts number 32767 into R0

   LOOP
      ADD R2, R2, #0       ;Make R2 LMR
      BRp PRINT_ZERO       ;if R2 is pos, go to print_zero loop
      BRn PRINT_ONE        ;if r2 is neg, go to print_one loop

      PRINT_ZERO           ;loop to print zero is positive
         LD R0, NUM_ONE    ;load #48, which is 0, to R0
         TRAP x21          ;prints out R0 = 0
         ADD R2, R2, R2    ;left shift by adding number to itself
         ADD R3, R3, #-1   ;reduce COUNT aka the 16 bit count

         LD R0, SPACE1
         ADD R0, R0, R3
         BRz PRINT_SPACE

         LD R0, SPACE2
         ADD R0, R0, R3
         BRz PRINT_SPACE

         LD R0, SPACE3
         ADD R0, R0, R3
         BRz PRINT_SPACE

         ADD R3, R3, #0
         BRp LOOP          ;goes back to begining of loop is NUM is positive
         BRnz END_LOOP     ;goes to end of loop is NUM is zero or negative
      END_PRINT_ZERO

      PRINT_ONE
         LD R0, NUM_ZERO
         TRAP x21
         ADD R2, R2, R2
         ADD R3, R3, #-1

         LD R0, SPACE1
         ADD R0, R0, R3
         BRz PRINT_SPACE

         LD R0, SPACE2
         ADD R0, R0, R3
         BRz PRINT_SPACE

         LD R0, SPACE3
         ADD R0, R0, R3
         BRz PRINT_SPACE

         ADD R3, R3, #0
         BRzp LOOP
         BRnz END_LOOP
      END_PRINT_ONE

      PRINT_SPACE
         LD R0, SPACE_CHAR
         TRAP x21
         ADD R3, R3, #0
         BRzp LOOP
         BRnz END_LOOP
      END_PRINT_SPACE

   END_LOOP

   HALT
   ;---
   ;LOCAL DATA
   ;---
   NUM_DEC     .STRINGZ    "The Number 32767 In Binary Is:\n"
   SPACE_CHAR  .STRINGZ    " "

   NUM         .FILL       xABAB
   NUM_ONE     .FILL       #48
   NUM_ZERO    .FILL       #49
   COUNT       .FILL       #15
   SPACE1      .FILL       #-3
   SPACE2      .FILL       #-7
   SPACE3      .FILL       #-11


.END
