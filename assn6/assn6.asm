;=================================================
; Name: <Goshtasbi, Rashid>
; Username: rgosh001
; 
; Assignment name: <assn 5>
; Lab section: 023
; TA: Bryan Marsh
; 
; I hereby certify that I have not received assistance on this assignment,
; or used code, from ANY outside source other than the instruction team.
;
;=================================================

.ORIG x3000
   ;----------------------
   ;Instructions
   ;----------------------
      LOOP
         LD R1, VECTOR     ;inputs vector into R1
         LD R2, MENU       ;loads MENU output
         JSRR R2
         
         TRAP x20          ;get user input
         TRAP x21          ;outputs user input

         LD R3, CONVERT    ;convert input to decimal'
         NOT R3, R3
         ADD R3, R3, #1
         ADD R0, R0, R3    ;puts converted decimal into R0
         
         NOT R0, R0
         ADD R0, R0, #1    ;negates user decimal input to use for BR checks

         ADD R3, R0, #1
         BRz ALL_MACHINES_BUSY_CALL
         
         ADD R3, R0, #2
         BRz ALL_MACHINES_FREE_CALL

         ADD R3, R0, #3
         BRz NUM_BUSY_MACHINES_CALL

         ADD R3, R0, #4
         BRz NUM_FREE_MACHINES_CALL

         ADD R3, R0, #5
         BRz NUM_MACHINE_STATUS_CALL

         ADD R3, R0, #6
         BRz FIRST_FREE_CALL

         ADD R3, R0, #7
         BRz END_ALL
         BRnp  ERROR_MESSAGE
         
         ALL_MACHINES_BUSY_CALL
            LEA R0, NEW_PROMPT
            TRAP x22
            BR LOOP
         END_ALL_MACHINES_BUSY_CALL

         ALL_MACHINES_FREE_CALL
            LEA R0, NEW_PROMPT
            TRAP x22
            BR LOOP
         END_ALL_MACHINES_FREE_CALL

         NUM_BUSY_MACHINES_CALL
            LEA R0, NEW_PROMPT
            TRAP x22
            BR LOOP
         END_NUM_BUSY_MACHINES_CALL

         NUM_FREE_MACHINES_CALL
            LEA R0, NEW_PROMPT
            TRAP x22
            BR LOOP
         END_NUM_FREE_MACHINES_CALL

         NUM_MACHINE_STATUS_CALL
            LEA R0, NEW_PROMPT
            TRAP x22
            BR LOOP
         END_NUM_MACHINE_STATUS_CALL

         FIRST_FREE_CALL
            LEA R0, NEW_PROMPT
            TRAP x22
            BR LOOP
         END_FIRST_FREE_CALL

         ERROR_MESSAGE
            LEA R0, ERROR_PROMPT
            TRAP x22
            LEA R0, NEW_PROMPT
            TRAP x22
            BR LOOP
         END_ERROR_MESSAGE

         LEA R0, NEW_PROMPT   ;new line to separate menu loop
         TRAP x22
      END_LOOP

      END_ALL
      HALT
    
   ;---
   ;LOCAL DATA
   ;---
      VECTOR         .FILL    #27155
      CONVERT        .FILL    #48
      MENU           .FILL    x3100
      NEW_PROMPT     .STRINGZ "\n-----------------------------------\n"
      ERROR_PROMPT   .STRINGZ "\nError: Input Not Valid. Please Try Again."
      TEST           .STRINGZ "TEST\n"

;---------------------------------------------------------------------------------   
   ;---
   ; SUBROUTINE #1 -- MENU
   ;---
   .ORIG x3100

   ;SUBROUTINE INSTRUCTIONS
   ;(1) Backup R7 & any registers the subroutine changes except Return Values
      ST R0, BACKUP_R2_3100
      ST R1, BACKUP_R3_3100
      ST R2, BACKUP_R3_3100
      ST R3, BACKUP_R3_3100
      ST R4, BACKUP_R4_3100
      ST R5, BACKUP_R5_3100
      ST R6, BACKUP_R6_3100
      ST R7, BACKUP_R7_3100

   ;(2) Subroutine's algorithm
      LEA R0, MENU1
      TRAP x22
      LEA R0, MENU2
      TRAP x22
      LEA R0, MENU3
      TRAP x22
      LEA R0, MENU4
      TRAP x22
      LEA R0, MENU5
      TRAP x22
      LEA R0, MENU6
      TRAP x22
      LEA R0, MENU7
      TRAP x22

   ;(3) Restore Registers
      LD R0, BACKUP_R2_3100
      LD R1, BACKUP_R2_3100
      LD R2, BACKUP_R2_3100
      LD R3, BACKUP_R3_3100
      LD R4, BACKUP_R4_3100
      LD R5, BACKUP_R5_3100
      LD R6, BACKUP_R6_3100
      LD R7, BACKUP_R7_3100

   ;(4) Return
      RET

   ; Subroutine Data
      BACKUP_R0_3100 .BLKW #1
      BACKUP_R1_3100 .BLKW #1
      BACKUP_R2_3100 .BLKW #1
      BACKUP_R3_3100 .BLKW #1
      BACKUP_R4_3100 .BLKW #1
      BACKUP_R5_3100 .BLKW #1
      BACKUP_R6_3100 .BLKW #1
      BACKUP_R7_3100 .BLKW #1
      MENU1    .STRINGZ    "1. SEE IF ALL MACHINES ARE BUSY\n"
      MENU2    .STRINGZ    "2. SEE IF ALL MACHIENS ARE FREE\n"
      MENU3    .STRINGZ    "3. NUMBER OF FREE MACHINES\n"
      MENU4    .STRINGZ    "4. NUMBER OF BUSY MACHINES\n"
      MENU5    .STRINGZ    "5. STATUS OF MACHINE N\n"
      MENU6    .STRINGZ    "6. FIRST AVAILABLE MACHINE\n"
      MENU7    .STRINGZ    "7. QUIT\n"
      .END

;---------------------------------------------------------------------------------   
