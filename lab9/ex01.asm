;================================================
; Name: <Goshtasbi, Rashid>
; Username: rgosh001
; 
; Lab: <lab 8, Exercise 1>
; Lab section: 023
; TA: Bryan Marsh
; 
;=================================================

.ORIG x3000
   ;----------------------
   ;Instructions
   ;----------------------
      JSR SUB_GET_STRING   

      HALT

   ;---
   ;LOCAL DATA
   ;---
      YES_PAL_PROMPT .STRINGZ "Input Was A Palindrome"
      NOT_PAL_PROMPT .STRINGZ "Input Was Not A Palindrome"

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
      
.END
