;================================================
; Name: <Goshtasbi, Rashid>
; Username: rgosh001
; 
; Lab: <lab 6, Exercise 3>
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

   LEA R0, NUM_STRING
   TRAP x22
   
   LD R1, NUM
   
   JSR SUB_COUNT_3400

   LEA R0, NEW_LINE
   TRAP x22

   LEA R0, END_PROMPT
   TRAP x22

   LD R3, CONVERT
   ADD R0, R2, R3
   TRAP x21
   

   HALT                 ;HALT program
    
   ;---
   ;LOCAL DATA
   ;---
   CONVERT        .FILL x30
   PROMPT      .STRINGZ    "Number Inputted In R1 Is: "
   NEW_LINE    .STRINGZ    "\n"
   END_PROMPT  .STRINGZ    "xE After Left Shift Is: "
   NUM         .FILL       xE
   NUM_STRING  .STRINGZ    "xE(14)"

   ;---
   ; SUBROUTINE
   ;---


.ORIG x3400    ;PROGRAM BEGINS HERE
   ;SUBROUTINE INSTRUCTIONS
   ;(1) Backup R7 & any registers the subroutine changes except Return Values
      SUB_COUNT_3400    ST R3, BACKUP_R7_3400
                        ST R4, BACKUP_R7_3400
                        ST R5, BACKUP_R7_3400
                        ST R6, BACKUP_R7_3400
                        ST R7, BACKUP_R7_3400

   ;(2) Subroutine's algorithm

      LD R3, COUNT
      ;LD R2, EMPTY_BINARY
      LOOP
        ; ADD R2, R2, R2
         ADD R1, R1, #0
         BRn NEG
         BRp POS
         NEG
            ADD R2, R2, R2
            ADD R2, R2, #1
            BR LAST
         END_NEG
         POS
            ADD R2, R2, R2
            ADD R2, R2, #0
            BR LAST
         END_POS

         LAST
         ADD R1, R1, R1
         ADD R3, R3, #-1
         BRp LOOP
         BRnz END_LOOP
      END_LOOP


   ;(3) Restore Registers
      LD R3, BACKUP_R7_3400
      LD R4, BACKUP_R1_3400
      LD R5, BACKUP_R7_3400
      LD R6, BACKUP_R7_3400
      LD R7, BACKUP_R7_3400


   ;(4) Return
      RET
   
   ;(5) Subroutine Data
      BACKUP_R1_3400 .BLKW #1
      BACKUP_R3_3400 .BLKW #1
      BACKUP_R4_3400 .BLKW #1
      BACKUP_R5_3400 .BLKW #1
      BACKUP_R6_3400 .BLKW #1
      BACKUP_R7_3400 .BLKW #1
      
      COUNT          .FILL #15
      EMPTY_BINARY   .FILL #0

.END
