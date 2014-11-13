;================================================
; Name: <Goshtasbi, Rashid>
; Username: rgosh001
; 
; Lab: <lab 6, Exercise 2>
; Lab section: 023
; TA: Bryan Marsh
; 
;=================================================

.ORIG x3000
   ;----------------------
   ;Instructions
   ;----------------------
   LEA R0, PROMPT
   TRAP x22

   GETC                 ;Get user input
   OUT
   
   ADD R2, R0, #0       ;Put input value into R2 for subroutine

   LEA R0, NEWLINE
   TRAP x22
   
   JSR SUB_COUNT_3400   ;Subroutine to find 1's

   LEA R0, END_PROMPT   ;End Prommpt
   TRAP x22

   LD R3, CONVERT
   ADD R0, R4, R3       ;puts result of subroutine from R4 into R0 for output
   OUT
   HALT                 ;HALT program
    
   ;---
   ;LOCAL DATA
   ;---

   ;---
   ; SUBROUTINE
   ;---

   CONVERT  .FILL       x30
   PROMPT   .STRINGZ    "Please Enter A Single Character: "
   NEWLINE  .STRINGZ    "\n"
   END_PROMPT  .STRINGZ "The Number of 1's is: "

.ORIG x3400    ;PROGRAM BEGINS HERE
   ;SUBROUTINE INSTRUCTIONS
   ;(1) Backup R7 & any registers the subroutine changes except Return Values
      SUB_COUNT_3400    ST R1, BACKUP_R1_3400
                        ST R3, BACKUP_R7_3400
                        ST R5, BACKUP_R7_3400
                        ST R6, BACKUP_R7_3400
                        ST R7, BACKUP_R7_3400

   ;(2) Subroutine's algorithm
      LD R3, COUNT            ;Holds count for loop for 16 times(aka 16-bits)   
      LOOP
         ADD R2, R2, #0       ;Make R2 LMR
         BRp PRINT_ZERO       ;if R2 is pos, go to print_zero loop
         BRn PRINT_ONE        ;if r2 is neg, go to print_one loop

         PRINT_ZERO           ;loop to print zero is positive
            ADD R2, R2, R2    ;left shift by adding number to itself
            ADD R3, R3, #-1   ;reduce COUNT aka the 16 bit count

            ADD R3, R3, #0
            BRp LOOP          ;goes back to begining of loop is NUM is positive
            BRnz END_LOOP     ;goes to end of loop is NUM is zero or negative
         END_PRINT_ZERO

         PRINT_ONE            ;loop to print zero is positive
            ADD R4, R4, #1

            ADD R2, R2, R2    ;left shift by adding number to its
            ADD R3, R3, #-1   ;reduce COUNT aka the 16 bit count

            ADD R3, R3, #0
            BRp LOOP         ;goes back to begining of loop is NUM is positive
            BRnz END_LOOP     ;goes to end of loop is NUM is zero or negative
         END_PRINT_ONE

      END_LOOP                ;END LOOP

   ;(3) Restore Registers
      LD R1, BACKUP_R1_3400
      LD R3, BACKUP_R7_3400
      LD R5, BACKUP_R7_3400
      LD R6, BACKUP_R7_3400
      LD R7, BACKUP_R7_3400


   ;(4) Return
      RET
   
   ;(5) Subroutine Data
      BACKUP_R1_3400 .BLKW #1
      BACKUP_R2_3400 .BLKW #1
      BACKUP_R3_3400 .BLKW #1
      BACKUP_R4_3400 .BLKW #1
      BACKUP_R5_3400 .BLKW #1
      BACKUP_R6_3400 .BLKW #1
      BACKUP_R7_3400 .BLKW #1

      SPACE_CHAR  .STRINGZ    " "

      NUM_ONE     .FILL       #48
      NUM_ZERO    .FILL       #49
      COUNT       .FILL       #16
.END
