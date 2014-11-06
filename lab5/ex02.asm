;================================================
; Name: <Goshtasbi, Rashid>
; Username: rgosh001
; 
; Lab: <lab 5, Exercise 2>
; Lab section: 023
; TA: Bryan Marsh
; 
;=================================================

.ORIG x3000
   ;----------------------
   ;Instructions
   ;----------------------
   LEA R0, PROMPT
   PUTS
   GETC
   OUT

   LD R1, SUB_COUNT_3400
   JSRR R1

   LEA R0, SKIPLINE
   TRAP x24

   LD R1, SUB_PRINT_OUT
   JSRR R1

   HALT
    
   ;---
   ;LOCAL DATA
   ;---
   
   PROMPT   .STRINGZ    "Enter Binary Number Starting With 'b': "
   SKIPLINE .STRINGZ    "\n"
   SUB_COUNT_3400 .FILL x3200
   SUB_PRINT_OUT  .FILL x3400

;---------------------------------------------------------------------------------   
   ;---
   ; SUBROUTINE #1
   ;---

   .ORIG x3200

   ;SUBROUTINE INSTRUCTIONS
   ;(1) Backup R7 & any registers the subroutine changes except Return Values
      ST R7, BACKUP_R7_3200   ;backup R2

   ; (2) Subroutine's algorithm

      LD R1, COUNT_INPUT
      GETC_LOOP
         GETC
         OUT

         ADD R6, R1, #-1
         BRz SKIP
         
         LD R4, CONVERT
         ADD R3, R0, R4    ;convert input

         ADD R5, R1, #-1
         MULT_LOOP
            ADD R3, R3, R3
            ADD R5, R5, #-1
            BRp MULT_LOOP
         END_MULT_LOOP
         BRz SKIP_ZERO

         SKIP
            ADD R3, R0, R4
            BRp NUMB_ONE

         NUMB_ONE
            ADD R3, R3, #0
         
         SKIP_ZERO
         ADD R2, R2, R3
         LD R3, EMPTY
         
         ADD R1, R1, #-1
         BRp GETC_LOOP
      END_GETC_LOOP


   ;(3) Restore Registers
      LD R7, BACKUP_R7_3200   ;backup R2
      

   ;(4) Return
      RET
   ; Subroutine Data

      BACKUP_R7_3200 .BLKW #1

      COUNT_INPUT      .FILL       #16
      CONVERT     .FILL       #-48
      EMPTY       .FILL       #0


      .END

;---------------------------------------------------------------------------------   
   ;---
   ; SUBROUTINE #2
   ;---

   .ORIG x3400

   ;SUBROUTINE INSTRUCTIONS
   ;(1) Backup R7 & any registers the subroutine changes except Return Values
      ST R7, BACKUP_R7_4000   ;backup R7
      ST R2, BACKUP_R2_4000   ;backup R2

   ; (2) Subroutine's algorithm
      LEA R0, LETTER
      TRAP x24
      LD R3, COUNT            ;Holds count for loop for 16 times(aka 16-bits)   
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



   ;(3) Restore Registers
      LD R2, BACKUP_R2_4000   ;backup R2
      LD R7, BACKUP_R7_4000   ;backup R7

   ;(4) Return
      RET

   ; Subroutine Data

      BACKUP_R2_4000 .BLKW #1
      BACKUP_R7_4000 .BLKW #1

      SPACE_CHAR  .STRINGZ    " "
      NUM_ONE     .FILL       #48
      NUM_ZERO    .FILL       #49
      ADD_NUM     .FILL       #0
      NUM         .FILL       xABCD
      COUNT       .FILL       #16
      COUNT3   .FILL    #10
      COUNT2   .FILL    #9
      LOCATION .FILL    x4000
      NUM      .FILL    x30
      SPACE1      .FILL       #-4
      SPACE2      .FILL       #-8
      SPACE3      .FILL       #-12

      NUM_DEC     .STRINGZ    "\n"
      LETTER      .STRINGZ    "b"

      .END
      
;---------------------------------------------------------------------------------   
