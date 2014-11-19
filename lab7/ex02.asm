;================================================
; Name: <Goshtasbi, Rashid>
; Username: rgosh001
; 
; Lab: <lab 7, Exercise 2>
; Lab section: 023
; TA: Bryan Marsh
; 
;=================================================

.ORIG x3000
   ;----------------------
   ;Instructions
   ;----------------------
      LD R0, LOCATION
      JSR SUB_GET_STRING   

      JSR SUB_IS_A_PALINDROME
      ADD R4, R4, #0
      BRp YES_PAL
      BRnz NOT_PAL
      YES_PAL
         LEA R0, YES_PAL_PROMPT
         TRAP x22
         BR END_PROGRAM
      NOT_PAL
         LEA R0, NOT_PAL_PROMPT
         TRAP x22
         BR END_PROGRAM

      END_PROGRAM
         HALT

   ;---
   ;LOCAL DATA
   ;---
      LOCATION       .FILL     x3300
      YES_PAL_PROMPT .STRINGZ "Input Was A Palindrome"
      NOT_PAL_PROMPT .STRINGZ "Input Was Not A Palindrome"

      .ORIG x3300
      .BLKW #10

   ;---
   ; SUBROUTINE #1
   ;---

.ORIG x3100    ;PROGRAM BEGINS HERE
   ;SUBROUTINE INSTRUCTIONS
   ;(1) Backup R7 & any registers the subroutine changes except Return Values
      SUB_GET_STRING    ST R0, BACKUP_R0_3100
                        ST R1, BACKUP_R1_3100
                        ST R2, BACKUP_R2_3100
                        ST R3, BACKUP_R3_3100
                        ST R4, BACKUP_R4_3100
                        ST R6, BACKUP_R6_3100
                        ST R7, BACKUP_R7_3100

   ;(2) Subroutine's algorithm
      ADD R1, R0, #0
      LD R5, EMPTY
      LEA R0, PROMPT
      TRAP x22
      
      INPUT_LOOP
         TRAP x20
         TRAP x21
         LD R2, ENTER
         NOT R2, R2
         ADD R2, R2, #1

         ADD R7, R0, R2     ;goes to multiplying and outputting the answer
         BRz END_INPUT_LOOP
         ADD R5, R5, #1

         STR R0, R1, #0
         ADD R1, R1, #1
         BR INPUT_LOOP
      END_INPUT_LOOP

   ;(3) Restore Registers
      LD R0, BACKUP_R0_3100
      LD R1, BACKUP_R1_3100
      LD R2, BACKUP_R2_3100
      LD R3, BACKUP_R3_3100
      LD R4, BACKUP_R4_3100
      LD R6, BACKUP_R6_3100
      LD R7, BACKUP_R7_3100

   ;(4) Return
      RET
   
   ;(5) Subroutine Data
      BACKUP_R0_3100 .BLKW #1
      BACKUP_R1_3100 .BLKW #1
      BACKUP_R2_3100 .BLKW #1
      BACKUP_R3_3100 .BLKW #1
      BACKUP_R4_3100 .BLKW #1
      BACKUP_R6_3100 .BLKW #1
      BACKUP_R7_3100 .BLKW #1
      
      ENTER          .FILL #10
      EMPTY          .FILL     #0
      PROMPT         .STRINGZ  "Please Enter A String of Text Below: \n"

   ;---
   ; SUBROUTINE #2
   ;---

.ORIG x3200    ;PROGRAM BEGINS HERE
   ;SUBROUTINE INSTRUCTIONS
   ;(1) Backup R7 & any registers the subroutine changes except Return Values
      SUB_IS_A_PALINDROME     ST R0, BACKUP_R0_3200
                              ST R1, BACKUP_R1_3200
                              ST R2, BACKUP_R2_3200
                              ST R3, BACKUP_R3_3200
                              ST R6, BACKUP_R6_3200
                              ST R7, BACKUP_R7_3200

   ;(2) Subroutine's algorithm
      ;R0 has location
      
      ;R1 has start address
      ;R5 has end address

      ;R2 has begining char
      ;R3 has ending   char

      LD R1, ZEROOUT
      ADD R5, R5, #-1

      ADD R4, R4, #1                   ;makes R4 true to palindrome

      ADD R1, R0, R1                   ;makes R1 address of begining
      ADD R5, R0, R5                   ;makes R5 address of begining
      CHECK_PALINDROME
         LDR R2, R1, #0                ;Load R2 with begining char
         LDR R3, R5, #0                ;Load R2 with endign char

         NOT R3, R3                    ;NOT R3 to add to R2 to see if they equal 0
         ADD R3, R3, #1

         ADD R6, R2, R3                ;ADD the two together to see if they are the same
         BRz   INCREMENT               ;if they the same, increment
         BRnp  ERROR_END               ;if they arent the same, end with error
         INCREMENT
            LD R6, ZEROOUT
            NOT R1, R1                 ;negate to see if they are at the same address
            ADD R1, R1, #1

            ADD R6, R1, R5             ;add the two together into R6 to check with BR
            NOT R1, R1                 ;negatve R1 back to normal
            ADD R1, R1, #1
            ADD R6, R6, #0 

            BRnz END_CHECK_PALINDROME   ;if R6 is the same, end check
            BRp INCREMENT_COUNT        ;If not, do increment then loop again
            INCREMENT_COUNT
               ADD R1, R1, #1          ;increment R1 address by 1
               ADD R5, R5, #-1         ;decrement R5 address by 1
               BR CHECK_PALINDROME
            END_INCREMENT_COUNT
         END_INCREMENT

         ERROR_END
            ADD R4, R4, #-1            ;makes R4 0
            BR END_CHECK_PALINDROME    ;exits with false palindrome
         END_ERROR_END
      END_CHECK_PALINDROME

      

   ;(3) Restore Registers
      LD R0, BACKUP_R0_3200
      LD R1, BACKUP_R1_3200
      LD R2, BACKUP_R2_3200
      LD R3, BACKUP_R3_3200
      LD R6, BACKUP_R6_3200
      LD R7, BACKUP_R7_3200

   ;(4) Return
      RET
   
   ;(5) Subroutine Data
      BACKUP_R0_3200 .BLKW #1
      BACKUP_R1_3200 .BLKW #1
      BACKUP_R2_3200 .BLKW #1
      BACKUP_R3_3200 .BLKW #1
      BACKUP_R6_3200 .BLKW #1
      BACKUP_R7_3200 .BLKW #1

      ZEROOUT        .FILL #0
      
.END
