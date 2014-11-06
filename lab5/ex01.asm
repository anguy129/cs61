;================================================
; Name: <Goshtasbi, Rashid>
; Username: rgosh001
; 
; Lab: <lab 5, Exercise 1>
; Lab section: 023
; TA: Bryan Marsh
; 
;=================================================

.ORIG x3000
   ;----------------------
   ;Instructions
   ;----------------------
   
   JSR SUB_COUNT_3400
    
   ;---
   ;LOCAL DATA
   ;---
   
   ; N/A

   ;---
   ; SUBROUTINE
   ;---

.ORIG x3400    ;PROGRAM BEGINS HERE
   ;SUBROUTINE INSTRUCTIONS
   ;(1) Backup R7 & any registers the subroutine changes except Return Values
      SUB_COUNT_3400

   ; (2) Subroutine's algorithm
      LD R5, COUNT3
      LD R6, ADD_NUM

      LOOP3
         LD R1, LOCATION
         LD R3, COUNT2
         LOOP1
            LDR R2, R1, #0

            ADD R2, R2, R2

            ADD R1, R1, #1
            STR R2, R1, #0


            ;LD R5, ENTER
            ;NOT R5, R5
            ;ADD R5, R5, #1
            
            ;ADD R5, R5, R0

            ADD R3, R3, #-1
            BRz END_LOOP1
            BRnp LOOP1
         END_LOOP1

         ;LD R2, LOCATION
         ;LD R3, NUM
         ;ADD R2, R2, #6
         ;ADD R0, R2, R3
         ;TRAP x21
         

         LEA R0, NUM_DEC         ;Prints to screen number information is
         TRAP x22

         LEA R0, LETTER
         TRAP x22
         
         LD R3, COUNT            ;Holds count for loop for 16 times(aka 16-bits)   
         ;Puts number 32767 into R0
         LD R4, LOCATION
         ADD R4, R4, R6
         LDR R2, R4, #0

         LOOP
            ADD R2, R2, #0       ;Make R2 LMR
            BRp PRINT_ZERO       ;if R2 is pos, go to print_zero loop
            BRn PRINT_ONE        ;if r2 is neg, go to print_one loop

            PRINT_ZERO           ;loop to print zero is positive
               LD R0, NUM_ONE    ;load #48, which is 0, to R0
               TRAP x21          ;prints out R0 = 0
               ADD R2, R2, R2    ;left shift by adding number to itself
               ADD R3, R3, #-1   ;reduce COUNT aka the 16 bit count

               LD R0, SPACE1     ;load R0 with space1 label
               ADD R0, R0, R3    ;add count & space1
               BRz PRINT_SPACE   ;if R0 is zero, go to PRINT_SPACE function to print space

               LD R0, SPACE2     ;load R0 with space2 label
               ADD R0, R0, R3    ;add count & space2
               BRz PRINT_SPACE   ;if R0 is zero, go to PRINT_SPACE function to print space

               LD R0, SPACE3     ;load R0 with space3 label
               ADD R0, R0, R3    ;add count & space3
               BRz PRINT_SPACE   ;if R0 is zero, go to PRINT_SPACE function to print space

               ADD R3, R3, #0
               BRp LOOP          ;goes back to begining of loop is NUM is positive
               BRnz END_LOOP     ;goes to end of loop is NUM is zero or negative
            END_PRINT_ZERO

            PRINT_ONE            ;loop to print zero is positive

               LD R0, NUM_ZERO   ;load #48, which is 0, to R0
               TRAP x21          ;prints out R0 = 0
               ADD R2, R2, R2    ;left shift by adding number to its
               ADD R3, R3, #-1   ;reduce COUNT aka the 16 bit count

               LD R0, SPACE1     ;load R0 with space1 label
               ADD R0, R0, R3    ;add count & space1
               BRz PRINT_SPACE   ;if R0 is zero, go to PRINT_SPACE function to print space

               LD R0, SPACE2     ;load R0 with space2 label
               ADD R0, R0, R3    ;add count & space2
               BRz PRINT_SPACE   ;if R0 is zero, go to PRINT_SPACE function to print space

               LD R0, SPACE3     ;load R0 with space3 label
               ADD R0, R0, R3    ;add count & space3
               BRz PRINT_SPACE   ;if R0 is zero, go to PRINT_SPACE function to print space

               ADD R3, R3, #0
               BRp LOOP         ;goes back to begining of loop is NUM is positive
               BRnz END_LOOP     ;goes to end of loop is NUM is zero or negative
            END_PRINT_ONE

            PRINT_SPACE          ;function to print out a space ONLY BETWEEN every 4 bits
               LD R0, SPACE_CHAR ;loads a space character into R0 for output
               TRAP x21          ;outputs the space character
               ADD R3, R3, #0    ;makes R3 LMR to check for loop iteration
               BRp LOOP         ;if its positive, enter loop again
               BRnz END_LOOP     ;if its negative or zero, exit loop, the HALT program
            END_PRINT_SPACE

         END_LOOP                ;END LOOP
         
         ADD R6, R6, #1

         ADD R5, R5, #-1
         BRp LOOP3
         BRnz END_LOOP3
      END_LOOP3

      HALT
   ;(3) Restore Registers
      

   ;(4) Return
   
   ; Subroutine Data

      NUM_DEC     .STRINGZ    "\n"
      SPACE_CHAR  .STRINGZ    " "
      LETTER      .STRINGZ    "b"

      ADD_NUM     .FILL       #0
      NUM         .FILL       xABCD
      NUM_ONE     .FILL       #48
      NUM_ZERO    .FILL       #49
      COUNT       .FILL       #16
      SPACE1      .FILL       #-4
      SPACE2      .FILL       #-8
      SPACE3      .FILL       #-12

      COUNT3   .FILL    #10
      COUNT2   .FILL    #9
      LOCATION .FILL    x4000
      NUM      .FILL    x30
      

      .ORIG x4000
      .FILL #1

      .END
