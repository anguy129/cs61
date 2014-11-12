;================================================
; Name: <Goshtasbi, Rashid>
; Username: rgosh001
; 
; Lab: <lab 6, Exercise 1>
; Lab section: 023
; TA: Bryan Marsh
; 
;=================================================

.ORIG x3000
   ;----------------------
   ;Instructions
   ;----------------------
   
   START
      LEA R0, PROMPT          ;outputs input prompt for the user
      TRAP x22


      LD R1, EMPTY            ;initialize R1 to 0
      LD R3, EMPTY            ;for neg number

      LD R5, EMPTY            ;to make sure no 2nd use or +/- signs
      ADD R5, R5, #1

      INPUT_LOOP
         GETC                 ;get user input
         OUT                  ;ouput it to the screen

         ADD R7, R0, #-10     ;goes to multiplying and outputting the answer
         BRz END_INPUT_LOOP

         
         LD R6, EMPTY         ;init R6 to 0 to use for check
         LD R4, NEG           ;check for NEG# by negating negative dec values to compare to
         NOT R4, R4           ;check to see it its a negative sign inputted
         ADD R4, R4, #1
         ADD R6, R0, R4
         BRz NEG_LOOP         ;enters neg loop if it a neg sign
         BRnp END_NEG_LOOP    ;skips neg loop if it isnt a neg sign

         NEG_LOOP
            LD R3, ONE        ;makes R7 = 1 as a flag to negate answer at the end
            ADD R5, R5, #-1   ;checks to see if a second - was inputted = error
            BRn ERROR1
            BRzp INPUT_LOOP
            ;BRp INPUT_LOOP    ;starts over again
         END_NEG_LOOP


         LD R6, EMPTY         ;init R6 to 0 to use for check
         LD R4, POS           ;check for POS# by negating negative dec values to compare to
         NOT R4, R4           
         ADD R4, R4, #1
         ADD R6, R0, R4
         BRz POS_LOOP
         BRnp END_POS_LOOP

         POS_LOOP
            ADD R5, R5, #-1       ;checks to see if a second + was inputted = error
            BRn ERROR1
            BRzp  INPUT_LOOP      ;if plus sign, re-enter loop as it has no effect
         END_POS_LOOP

         ;---reg number input---
         REG_NUM
            LD R6, EMPTY      ;makes R6 = 0
            LD R4, CHAR_UP    ;load register with ascii value 9
            NOT R4, R4
            ADD R4, R4, #1
            LD R6, EMPTY      
            ADD R6, R0, R4    ;check if the character input is above char 9
            BRp ERROR1        ;if it is, enter ERROR1 loop to restart program
            BRnz END_ERROR    ;if isnt, skip over ERROR1 loop and do next check
            ERROR1
               LEA R0, ERROR
               TRAP x22
               ADD R3, R3, #1
               BRnzp START
            END_ERROR

            LD R6, EMPTY      ;makes R6 = 0
            LD R4, CHAR_DW    ;load register with ascii value 0
            NOT R4, R4
            ADD R4, R4, #1
            LD R6, EMPTY
            ADD R6, R0, R4    ;check if the character input is below char 0
            BRn ERROR1        ;if it is, enter ERROR1 loop to restart program
            BRzp END_ERROR    ;if isnt, skip over ERROR1 loop and do next check
            ERROR1            ;error loop to print out message and restart program
               LEA R0, ERROR
               TRAP x22
               ADD R3, R3, #1
               BRnzp START
            END_ERROR

            LD R6, COUNT10    ;counter for multiplying number by 10
            LD R4, EMPTY      ;init R4 to 0
            ADD R4, R1, #0    ;copies value to multiply itself by 10
            MULT_LOOP         ;multiply value by 10 loop
               ADD R1, R1, R4
               ADD R6, R6, #-1
               BRp MULT_LOOP
               BRz END_MULT_LOOP
            END_MULT_LOOP
            
            LD R6, CONVERT
            NOT R6, R6
            ADD R6, R6, #1
            ADD R0, R0, R6    ;convert to binary
            ADD R1, R1, R0    ;added to R1

            LD R6, EMPTY      ;repeats the loop indefinately unless by enter sign or error
            ADD R6, R6, #0
            BRnzp INPUT_LOOP
         ENG_REG_NUM

      END_INPUT_LOOP


      ADD R3, R3, #0          ;LMS R3 to check if value inputed was negative
      BRp NEG_ANSWER
      BRnz END_NEG_ANSWER
      NEG_ANSWER              ;loop to do 2's complement to negate answer
         NOT R1, R1
         ADD R1, R1, #1
      END_NEG_ANSWER

      ADD R1, R1, #1

   JSR SUB_COUNT_3400

   HALT                    ;HALT program
    
   ;---
   ;LOCAL DATA
   ;---
   ERROR       .STRINGZ    "\nError: Only input +/- sign with 0 to 32766 only. Please Try Again\n"
   PROMPT      .STRINGZ    "Input a number between 0 and 32766, followed by 'ENTER'\n"
   PROMPTNEG   .STRINGZ    "NEGATIVE NUMBER INPUTTED\n"
   PROMPTPOS   .STRINGZ    "POSITIVE NUMBER INPUTTED\n"
   EMPTY    .FILL       #0
   ONE      .FILL       #1
   CHAR_UP  .FILL       #57
   CHAR_DW  .FILL       #48
   ZERO     .FILL       #0
   CONVERT  .FILL       #48
   COUNT10  .FILL       #9
   ENTER    .FILL       #10
   POS      .FILL       #43
   NEG      .FILL       #45

   .ORIG x4000
   .FILL #0

   ;---
   ; SUBROUTINE
   ;---

.ORIG x3400    ;PROGRAM BEGINS HERE
   ;SUBROUTINE INSTRUCTIONS
   ;(1) Backup R7 & any registers the subroutine changes except Return Values
      SUB_COUNT_3400    ST R1, BACKUP_R1_3400
                        ST R2, BACKUP_R7_3400
                        ST R3, BACKUP_R7_3400
                        ST R4, BACKUP_R7_3400
                        ST R5, BACKUP_R7_3400
                        ST R6, BACKUP_R7_3400
                        ST R7, BACKUP_R7_3400

   ;(2) Subroutine's algorithm
      LEA R0, OUTPUT
      TRAP x22
      
      LD R3, TEN_T
      TEN_THOUSAND_LOOP
         ADD R1, R1, R3
         BRnz  END_TEN_THOUSAND_LOOP
         BRp   INCREMENT
         INCREMENT
            ADD R2, R2, #1
            BR TEN_THOUSAND_LOOP
      END_TEN_THOUSAND_LOOP

      LD R3, P_TEN_T
      ADD R1, R1, R3

      LD R3, SUB_CONVERT
      ADD R0, R2, R3
      OUT

      LD R2, SUB_EMPTY

      LD R3, THOUS
      THOUSAND_LOOP
         ADD R1, R1, R3
         BRnz  END_THOUSAND_LOOP
         BRp   INCREMENT2
         INCREMENT2
            ADD R2, R2, #1
            BR THOUSAND_LOOP
      END_THOUSAND_LOOP
      
      LD R3, P_THOUS
      ADD R1, R1, R3

      LD R3, SUB_CONVERT
      LD R0, SUB_EMPTY
      ADD R0, R2, R3
      OUT

      LD R2, SUB_EMPTY

      LD R3, HUNDS
      HUNDS_LOOP
         ADD R1, R1, R3
         BRnz  END_HUNDS_LOOP
         BRp   INCREMENT3
         INCREMENT3
            ADD R2, R2, #1
            BR HUNDS_LOOP
      END_HUNDS_LOOP
      
      LD R3, P_HUNDS
      ADD R1, R1, R3

      LD R3, SUB_CONVERT
      LD R0, SUB_EMPTY
      ADD R0, R2, R3
      OUT
      
      LD R2, SUB_EMPTY

      LD R3, TENS
      TENS_LOOP
         ADD R1, R1, R3
         BRnz  END_TENS_LOOP
         BRp   INCREMENT4
         INCREMENT4
            ADD R2, R2, #1
            BR TENS_LOOP
      END_TENS_LOOP
      
      LD R3, P_TENS
      ADD R1, R1, R3

      LD R3, SUB_CONVERT
      LD R0, SUB_EMPTY
      ADD R0, R2, R3
      OUT

      LD R2, SUB_EMPTY

      LD R3, ONES
      ONES_LOOP
         ADD R1, R1, R3
         BRnz  END_ONES_LOOP
         BRp   INCREMENT5
         INCREMENT5
            ADD R2, R2, #1
            BR ONES_LOOP
      END_ONES_LOOP
      
      LD R3, P_ONES
      ADD R1, R1, R3

      LD R3, SUB_CONVERT
      LD R0, SUB_EMPTY
      ADD R0, R2, R3
      OUT

   ;(3) Restore Registers
      LD R1, BACKUP_R1_3400
      LD R2, BACKUP_R7_3400
      LD R3, BACKUP_R7_3400
      LD R4, BACKUP_R7_3400
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

      OUTPUT         .STRINGZ "Output: "
   
      SUB_CONVERT    .FILL x30
      SUB_EMPTY      .FILL #0
      TEN_T          .FILL #-10000
      THOUS          .FILL #-1000
      HUNDS          .FILL #-100
      TENS           .FILL #-10
      ONES           .FILL #-1
      P_TEN_T          .FILL #10000
      P_THOUS          .FILL #1000
      P_HUNDS          .FILL #100
      P_TENS           .FILL #10
      P_ONES           .FILL #1
.END
