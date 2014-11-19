;================================================
; Name: <Goshtasbi, Rashid>
; Username: rgosh001
; 
; Lab: <lab 7, Exercise 1>
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

.END
