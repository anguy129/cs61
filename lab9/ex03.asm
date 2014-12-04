;================================================
; Name: <Goshtasbi, Rashid>
; Username: rgosh001
; 
; Lab: <lab 9, Exercise 2>
; Lab section: 023
; TA: Bryan Marsh
; 
;=================================================

.ORIG x3000
   ;----------------------
   ;Instructions
   ;----------------------
      LEA R0, INPUT_PROMPT
      TRAP x22

      LD R1, ARRAY
      LD R2, ARRAY
      ADD R3, R3, #4

      LOOP
         LD R6, INPUT_SUB
         JSRR R6

         LD R6, SUB_STACK_PUSH
         JSRR R6

         ADD R3, R3, #0
         BRz POP_ARRAY
         BR LOOP
      END_LOOP

      POP_ARRAY
         ADD R5, R1, #0
         LD R6, SUB_RPN_MULT
         JSRR R6

         ADD R1, R4, #0
         ADD R0, R1, #0

         ADD R2, R2, #-2
         LD R6, SUB_STACK_PUSH
         JSRR R6

         LD R6, SUB_STACK_OUTPUT
         JSRR R6

         HALT

   ;---
   ;LOCAL DATA
   ;---
      INPUT_PROMPT      .STRINGZ    "Please Enter 4 Numbers (5 Digits MAX) Followed By Enter To Test POP: "
      INPUT_SUB         .FILL    x3100
      SUB_STACK_PUSH    .FILL    x3300
      SUB_STACK_POP     .FILL    x3400
      SUB_RPN_MULT      .FILL    x3500
      SUB_STACK_OUTPUT  .FILL    x2800
      ARRAY             .FILL    x4000
      CONVERTER         .FILL    x30

;---------------------------------------------------------------------------------   
   ;---
   ; SUBROUTINE #1 - INPUT_SUB
   ;---

   .ORIG x3100

   ;SUBROUTINE INSTRUCTIONS
   ;(1) Backup R7 & any registers the subroutine changes except Return Values
      ST R1, BACKUP_R1_3100
      ST R2, BACKUP_R2_3100
      ST R3, BACKUP_R3_3100
      ST R4, BACKUP_R4_3100
      ST R5, BACKUP_R5_3100
      ST R6, BACKUP_R6_3100
      ST R7, BACKUP_R7_3100

   ;(2) Subroutine's algorithm

   START
      LD R1, EMPTY            ;initialize R1 to 0
      LD R3, EMPTY            ;for neg number

      LD R5, EMPTY            ;to make sure no 2nd use or +/- signs
      ADD R5, R5, #1

      INPUT_LOOP
         GETC                 ;get user input
         TRAP x21

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

      ADD R0, R1, #0

   ;(3) Restore Registers
      LD R1, BACKUP_R1_3100
      LD R2, BACKUP_R2_3100
      LD R3, BACKUP_R3_3100
      LD R4, BACKUP_R4_3100
      LD R5, BACKUP_R5_3100
      LD R6, BACKUP_R6_3100
      LD R7, BACKUP_R7_3100

   ;(4) Return
      RET

   ; Subroutine Data
      BACKUP_R1_3100 .BLKW #1
      BACKUP_R2_3100 .BLKW #1
      BACKUP_R3_3100 .BLKW #1
      BACKUP_R4_3100 .BLKW #1
      BACKUP_R5_3100 .BLKW #1
      BACKUP_R6_3100 .BLKW #1
      BACKUP_R7_3100 .BLKW #1
      EMPTY    .FILL       #0
      NEG      .FILL       #45
      ERROR       .STRINGZ    "\nError: Only input +/- sign with 1-5 digits only. Please Try Again\n"
      ONE      .FILL       #1
      CHAR_UP  .FILL       #57
      CHAR_DW  .FILL       #48
      ZERO     .FILL       #0
      CONVERT  .FILL       #48
      COUNT10  .FILL       #9
      ENTER    .FILL       #10
      POS      .FILL       #43

      .END

;---------------------------------------------------------------------------------   
   ;---
   ; SUBROUTINE #2 - SUB_STACK_PUSH
   ;---

.ORIG x3300    ;PROGRAM BEGINS HERE
   ;SUBROUTINE INSTRUCTIONS
   ;(1) Backup R7 & any registers the subroutine changes except Return Values
      SUB_GET_STRING    ST R0, BACKUP_R0_3300
                        ST R1, BACKUP_R1_3300
                        ST R4, BACKUP_R4_3300
                        ST R6, BACKUP_R6_3300
                        ST R7, BACKUP_R7_3300

   ;(2) Subroutine's algorithm
      STR R0, R2, #0
      ADD R2, R2, #1
      ADD R3, R3, #-1

   ;(3) Restore Registers
      LD R0, BACKUP_R0_3300
      LD R1, BACKUP_R1_3300
      LD R4, BACKUP_R4_3300
      LD R5, BACKUP_R5_3300
      LD R6, BACKUP_R6_3300
      LD R7, BACKUP_R7_3300

   ;(4) Return
      RET
   
   ;(5) Subroutine Data
      BACKUP_R0_3300 .BLKW #1
      BACKUP_R1_3300 .BLKW #1
      BACKUP_R4_3300 .BLKW #1
      BACKUP_R5_3300 .BLKW #1
      BACKUP_R6_3300 .BLKW #1
      BACKUP_R7_3300 .BLKW #1
      
.END
;---------------------------------------------------------------------------------   
;---
; SUBROUTINE #3 - SUB_STACK_MULT
;---

.ORIG x3500    ;PROGRAM BEGINS HERE
   ;SUBROUTINE INSTRUCTIONS
   ;(1) Backup R7 & any registers the subroutine changes except Return Values
      ST R0, BACKUP_R0_3500
      ST R1, BACKUP_R1_3500
      ST R2, BACKUP_R2_3500
      ST R3, BACKUP_R3_3500
      ST R5, BACKUP_R5_3500
      ST R6, BACKUP_R6_3500
      ST R7, BACKUP_R7_3500

   ;(2) Subroutine's algorithm
      ADD R2, R2, #-1
      LDR R0, R2, #0
      LD R4, EMPTY4
      STR R4, R2, #0
      ADD R3, R3, #1

      ADD R5, R0, #0

      ADD R2, R2, #-1
      LDR R0, R2, #0
      LD R4, EMPTY4
      STR R4, R2, #0
      ADD R3, R3, #1

      ADD R6, R0, #0

      ADD R1, R5, #0
      ADD R2, R6, #0

      LD R4, EMPTY4
      ADD R5, R2, #0

      NOT R1, R1
      ADD R1, R1, #1

      ADD R2, R2, R1
      BRzp REG1_BIGGER
      BRn  REG2_BIGGER
   
      REG1_BIGGER
         ADD R2, R5, #0
         NOT R1, R1
         ADD R1, R1, #1
         MULT1
            ADD R4, R4, R1
            BRn ENDALL

            ADD R2, R2, #-1
            BRp MULT1
            BRnz ENDALL
         END_MULT1
      END_REG1_BIGGER


      REG2_BIGGER
         ADD R2, R5, #0
         NOT R1, R1
         ADD R1, R1, #1
         MULT2
            ADD R4, R4, R2
            BRn ENDALL

            ADD R1, R1, #-1
            BRp MULT2
            BRnz ENDALL
         END_MULT2
      END_REG2_BIGGER
      
      ENDALL
         ADD R4, R4, #0
      
   ;(3) Restore Registers
      LD R0, BACKUP_R0_3500
      LD R1, BACKUP_R1_3500
      LD R2, BACKUP_R2_3500
      LD R3, BACKUP_R3_3500
      LD R5, BACKUP_R5_3500
      LD R6, BACKUP_R6_3500
      LD R7, BACKUP_R7_3500


   ;(4) Return

      RET
   
   ;(5) Subroutine Data
      BACKUP_R0_3500 .BLKW #1
      BACKUP_R1_3500 .BLKW #1
      BACKUP_R2_3500 .BLKW #1
      BACKUP_R3_3500 .BLKW #1
      BACKUP_R5_3500 .BLKW #1
      BACKUP_R6_3500 .BLKW #1
      BACKUP_R7_3500 .BLKW #1
      EMPTY4   .FILL #0

      .END
;---------------------------------------------------------------------------------   
   ;---
   ; SUBROUTINE #5 - SUB_STACK_OUTPUT
   ;---

.ORIG x2800    ;PROGRAM BEGINS HERE
   ;SUBROUTINE INSTRUCTIONS
   ;(1) Backup R7 & any registers the subroutine changes except Return Values
      OUTPUT_NUM_3800   
                        ST R2, BACKUP_R2_2800
                        ST R3, BACKUP_R3_2800
                        ST R4, BACKUP_R4_2800
                        ST R5, BACKUP_R5_2800
                        ST R6, BACKUP_R6_2800
                        ST R7, BACKUP_R7_2800

   ;(2) Subroutine's algorithm
      LEA R0, OUTPUT_END
      TRAP x22
      
      LD R2, SUB_EMPTY
      LD R3, SUB_EMPTY
      LD R5, SUB_EMPTY
      LD R6, SUB_EMPTY
      LD R3, TEN_T
      TEN_THOUSAND_LOOP
         ADD R1, R1, R3
         BRn  END_TEN_THOUSAND_LOOP
         BRzp   INCREMENT
         INCREMENT
            ADD R2, R2, #1
            BR TEN_THOUSAND_LOOP
      END_TEN_THOUSAND_LOOP

      LD R3, P_TEN_T
      ADD R1, R1, R3

      LD R3, SUB_CONVERT
      LD R0, SUB_EMPTY
      LD R4, SUB_EMPTY
      ADD R4, R2, #0
      BRp PRINT0
      BRz SKIP0
      PRINT0
         ADD R0, R2, R3
         OUT

      SKIP0

      LD R2, SUB_EMPTY

      LD R3, THOUS
      THOUSAND_LOOP
         ADD R1, R1, R3
         BRn  END_THOUSAND_LOOP
         BRzp   INCREMENT2
         INCREMENT2
            ADD R2, R2, #1
            BR THOUSAND_LOOP
      END_THOUSAND_LOOP
      
      LD R3, P_THOUS
      ADD R1, R1, R3

      LD R3, SUB_CONVERT
      LD R0, SUB_EMPTY
      ADD R4, R4, #0
      BRp PRINT
      BRz CHECK1
      CHECK1
         ADD R4, R2, #0
         BRp PRINT
         BRz SKIP2
      PRINT
         ADD R0, R2, R3
         OUT

      SKIP2

      LD R2, SUB_EMPTY

      LD R3, HUNDS
      HUNDS_LOOP
         ADD R1, R1, R3
         BRn  END_HUNDS_LOOP
         BRzp   INCREMENT3
         INCREMENT3
            ADD R2, R2, #1
            BR HUNDS_LOOP
      END_HUNDS_LOOP
      
      LD R3, P_HUNDS
      ADD R1, R1, R3

      LD R3, SUB_CONVERT
      LD R0, SUB_EMPTY
      ADD R4, R4, #0
      BRp PRINT1
      BRz CHECK2
      CHECK2
         ADD R4, R2, #0
         BRp PRINT1
         BRz SKIP3
      PRINT1
         ADD R0, R2, R3
         OUT

      SKIP3

      LD R2, SUB_EMPTY

      LD R3, TENS
      TENS_LOOP
         ADD R1, R1, R3
         BRn  END_TENS_LOOP
         BRzp   INCREMENT4
         INCREMENT4
            ADD R2, R2, #1
            BR TENS_LOOP
      END_TENS_LOOP
      
      LD R3, P_TENS
      ADD R1, R1, R3

      LD R3, SUB_CONVERT
      LD R0, SUB_EMPTY
      ADD R4, R4, #0
      BRp PRINT2
      BRz CHECK3
      CHECK3
         ADD R4, R2, #0
         BRp PRINT2
         BRz SKIP4
      PRINT2
         ADD R0, R2, R3
         OUT

      SKIP4

      LD R2, SUB_EMPTY

      LD R3, ONES
      ONES_LOOP
         ADD R1, R1, R3
         BRn  END_ONES_LOOP
         BRzp   INCREMENT5
         INCREMENT5
            ADD R2, R2, #1
            BR ONES_LOOP
      END_ONES_LOOP
      
      LD R3, P_ONES
      ADD R1, R1, R3

      LD R3, SUB_CONVERT
      LD R0, SUB_EMPTY
      ADD R4, R4, #0
      BRp PRINT3
      BRz CHECK4
      CHECK4
         ADD R4, R2, #0
         BRp PRINT3
         BRz SKIP5
      PRINT3
         ADD R0, R2, R3
         OUT

      SKIP5

   ;(3) Restore Registers
      LD R2, BACKUP_R2_2800
      LD R3, BACKUP_R3_2800
      LD R4, BACKUP_R4_2800
      LD R5, BACKUP_R5_2800
      LD R6, BACKUP_R6_2800
      LD R7, BACKUP_R7_2800


   ;(4) Return

      RET
   
   ;(5) Subroutine Data
      BACKUP_R2_2800 .BLKW #1
      BACKUP_R3_2800 .BLKW #1
      BACKUP_R4_2800 .BLKW #1
      BACKUP_R5_2800 .BLKW #1
      BACKUP_R6_2800 .BLKW #1
      BACKUP_R7_2800 .BLKW #1

   
      OUTPUT_END     .STRINGZ "After Multiplying: "
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
;---------------------------------------------------------------------------------   
