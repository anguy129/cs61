;=================================================
; Name: <Goshtasbi, Rashid>
; Username: rgosh001
; 
; Assignment name: <assn 6>
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
         ;TRAP x21          ;outputs user input

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
            LD R6, ALL_MACHINES_BUSY
            JSRR R6

            LEA R0, NEW_PROMPT
            TRAP x22
            BR LOOP
         END_ALL_MACHINES_BUSY_CALL

         ALL_MACHINES_FREE_CALL
            LD R6, ALL_MACHINES_FREE
            JSRR R6

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
      LEA R0, EXIT_PROMPT
      TRAP x22
      HALT
    
   ;---
   ;LOCAL DATA
   ;---
      VECTOR            .FILL    #27155
      CONVERT           .FILL    #48
      MENU              .FILL    x3100
      ALL_MACHINES_BUSY .FILL    x3200
      ALL_MACHINES_FREE .FILL    x3300
      NEW_PROMPT        .STRINGZ "\n-----------------------------------\n"
      ERROR_PROMPT      .STRINGZ "\nError: Input Not Valid. Please Try Again."
      TEST              .STRINGZ "TEST\n"
      EXIT_PROMPT       .STRINGZ "\nResponse: 7. Goodbye!\n"

;---------------------------------------------------------------------------------   
   ;---
   ; SUBROUTINE #1 -- MENU
   ;---
   .ORIG x3100

   ;SUBROUTINE INSTRUCTIONS
   ;(1) Backup R7 & any registers the subroutine changes except Return Values
      ST R0, BACKUP_R0_3100
      ST R1, BACKUP_R1_3100
      ST R2, BACKUP_R2_3100
      ST R3, BACKUP_R3_3100
      ST R4, BACKUP_R4_3100
      ST R5, BACKUP_R5_3100
      ST R6, BACKUP_R6_3100
      ST R7, BACKUP_R7_3100

   ;(2) Subroutine's algorithm
      LEA R0, MENU_PROMPT
      TRAP x22
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
      LD R0, BACKUP_R0_3100
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
      BACKUP_R0_3100 .BLKW #1
      BACKUP_R1_3100 .BLKW #1
      BACKUP_R2_3100 .BLKW #1
      BACKUP_R3_3100 .BLKW #1
      BACKUP_R4_3100 .BLKW #1
      BACKUP_R5_3100 .BLKW #1
      BACKUP_R6_3100 .BLKW #1
      BACKUP_R7_3100 .BLKW #1
      MENU1          .STRINGZ    "1. SEE IF ALL MACHINES ARE BUSY\n"
      MENU2          .STRINGZ    "2. SEE IF ALL MACHIENS ARE FREE\n"
      MENU3          .STRINGZ    "3. NUMBER OF FREE MACHINES\n"
      MENU4          .STRINGZ    "4. NUMBER OF BUSY MACHINES\n"
      MENU5          .STRINGZ    "5. STATUS OF MACHINE N\n"
      MENU6          .STRINGZ    "6. FIRST AVAILABLE MACHINE\n"
      MENU7          .STRINGZ    "7. QUIT\n"
      MENU_PROMPT    .STRINGZ    "*****The Busyness Server*****\n"
      .END

;---------------------------------------------------------------------------------   
   ;---
   ; SUBROUTINE #2 -- ALL_MACHINES_BUSY
   ;---
   .ORIG x3200

   ;SUBROUTINE INSTRUCTIONS
   ;(1) Backup R7 & any registers the subroutine changes except Return Values
      ST R0, BACKUP_R0_3200
      ST R1, BACKUP_R1_3200
      ;ST R2, BACKUP_R2_3200
      ST R3, BACKUP_R3_3200
      ST R4, BACKUP_R4_3200
      ST R5, BACKUP_R5_3200
      ST R6, BACKUP_R6_3200
      ST R7, BACKUP_R7_3200

   ;(2) Subroutine's algorithm
      ;0 means busy, 1 means free
      LD R2, EMPTY1

      LD R3, COUNT
      LOOP1
         ADD R1, R1, #0
         BRn NEG
         BRp POS
         NEG
            ADD R2, R2, #0    ;1 is busy
            BR LAST
         END_NEG
         POS                  ;0 is free
            ADD R2, R2, #1
            BR LAST
         END_POS

         LAST
         ADD R1, R1, R1

         ADD R2, R2, #0
         BRp NOT_ALL_BUSY
         NOT_ALL_BUSY
            LEA R0, NOT_BUSY
            TRAP x22
            BR END_END

         ADD R3, R3, #-1
         BRp LOOP1
         BRnz END_CHECK
         END_CHECK
            ADD R2, R2, #0
            BRp ALL_BUSY_PROMPT
            ALL_BUSY_PROMPT
               LEA R0, ALL_BUSY
               TRAP x22
      END_END


   ;(3) Restore Registers
      LD R0, BACKUP_R0_3200
      LD R1, BACKUP_R1_3200
      ;LD R2, BACKUP_R2_3200
      LD R3, BACKUP_R3_3200
      LD R4, BACKUP_R4_3200
      LD R5, BACKUP_R5_3200
      LD R6, BACKUP_R6_3200
      LD R7, BACKUP_R7_3200

   ;(4) Return
      RET

   ; Subroutine Data
      BACKUP_R0_3200 .BLKW #1
      BACKUP_R1_3200 .BLKW #1
      ;BACKUP_R2_3200 .BLKW #1
      BACKUP_R3_3200 .BLKW #1
      BACKUP_R4_3200 .BLKW #1
      BACKUP_R5_3200 .BLKW #1
      BACKUP_R6_3200 .BLKW #1
      BACKUP_R7_3200 .BLKW #1
      NOT_BUSY       .STRINGZ    "\nCHOICE 1: Not all machines are busy\n"
      ALL_BUSY       .STRINGZ    "\nCHOICE 1: All machines are busy\n"
      COUNT          .FILL #15
      EMPTY1         .FILL #0
      .END

;---------------------------------------------------------------------------------   
   ;---
   ; SUBROUTINE #3 -- ALL_MACHINES_BUSY
   ;---
   .ORIG x3300

   ;SUBROUTINE INSTRUCTIONS
   ;(1) Backup R7 & any registers the subroutine changes except Return Values
      ST R0, BACKUP_R0_3300
      ST R1, BACKUP_R1_3300
      ;ST R2, BACKUP_R2_3300
      ST R3, BACKUP_R3_3300
      ST R4, BACKUP_R4_3300
      ST R5, BACKUP_R5_3300
      ST R6, BACKUP_R6_3300
      ST R7, BACKUP_R7_3300

   ;(2) Subroutine's algorithm
      ;0 means busy, 1 means free
      LD R2, EMPTY11

      LD R3, COUNT1
      LOOP1
         ADD R1, R1, #0
         BRn NEG1
         BRp POS1
         NEG1
            ADD R2, R2, #1    ;1 is busy
            BR LAST1
         END_NEG1
         POS1                  ;0 is free
            ADD R2, R2, #0
            BR LAST1
         END_POS1

         LAST1
         ADD R1, R1, R1

         ADD R2, R2, #0
         BRp NOT_ALL_FREE
         NOT_ALL_FREE
            LEA R0, NOT_FREE
            TRAP x22
            BR END_END

         ADD R3, R3, #-1
         BRp LOOP1
         BRnz END_CHECK1
         END_CHECK1
            ADD R2, R2, #0
            BRp ALL_FREE_PROMPT
            ALL_FREE_PROMPT
               LEA R0, ALL_FREE
               TRAP x22
      END_END1


   ;(3) Restore Registers
      LD R0, BACKUP_R0_3300
      LD R1, BACKUP_R1_3300
      ;LD R2, BACKUP_R2_3300
      LD R3, BACKUP_R3_3300
      LD R4, BACKUP_R4_3300
      LD R5, BACKUP_R5_3300
      LD R6, BACKUP_R6_3300
      LD R7, BACKUP_R7_3300

   ;(4) Return
      RET

   ; Subroutine Data
      BACKUP_R0_3300 .BLKW #1
      BACKUP_R1_3300 .BLKW #1
      ;BACKUP_R2_3300 .BLKW #1
      BACKUP_R3_3300 .BLKW #1
      BACKUP_R4_3300 .BLKW #1
      BACKUP_R5_3300 .BLKW #1
      BACKUP_R6_3300 .BLKW #1
      BACKUP_R7_3300 .BLKW #1
      NOT_FREE       .STRINGZ    "\nCHOICE 2: Not all machines are free\n"
      ALL_FREE       .STRINGZ    "\nCHOICE 2: All machines are free\n"
      COUNT1          .FILL #15
      EMPTY11         .FILL #0
      .END

;---------------------------------------------------------------------------------   
   ;---
   ; SUBROUTINE #4 -- NUM_BUSY_MACHINES
   ;---
   .ORIG x3400

   ;SUBROUTINE INSTRUCTIONS
   ;(1) Backup R7 & any registers the subroutine changes except Return Values
      ST R0, BACKUP_R0_3400
      ST R1, BACKUP_R1_3400
      ;ST R2, BACKUP_R2_3400
      ST R3, BACKUP_R3_3400
      ST R4, BACKUP_R4_3400
      ST R5, BACKUP_R5_3400
      ST R6, BACKUP_R6_3400
      ST R7, BACKUP_R7_3400

   ;(2) Subroutine's algorithm
      ;0 means busy, 1 means free
      LD R2, EMPTY11

      LD R3, COUNT1
      LOOP1
         ADD R1, R1, #0
         BRn NEG1
         BRp POS1
         NEG1
            ADD R2, R2, #1    ;1 is busy
            BR LAST1
         END_NEG1
         POS1                  ;0 is free
            ADD R2, R2, #0
            BR LAST1
         END_POS1

         LAST1
         ADD R1, R1, R1

         ADD R2, R2, #0
         BRp NOT_ALL_FREE
         NOT_ALL_FREE
            LEA R0, NOT_FREE
            TRAP x22
            BR END_END

         ADD R3, R3, #-1
         BRp LOOP1
         BRnz END_CHECK1
         END_CHECK1
            ADD R2, R2, #0
            BRp ALL_FREE_PROMPT
            ALL_FREE_PROMPT
               LEA R0, ALL_FREE
               TRAP x22
      END_END1


   ;(3) Restore Registers
      LD R0, BACKUP_R0_3400
      LD R1, BACKUP_R1_3400
      ;LD R2, BACKUP_R2_3400
      LD R3, BACKUP_R3_3400
      LD R4, BACKUP_R4_3400
      LD R5, BACKUP_R5_3400
      LD R6, BACKUP_R6_3400
      LD R7, BACKUP_R7_3400

   ;(4) Return
      RET

   ; Subroutine Data
      BACKUP_R0_3400 .BLKW #1
      BACKUP_R1_3400 .BLKW #1
      ;BACKUP_R2_3400 .BLKW #1
      BACKUP_R3_3400 .BLKW #1
      BACKUP_R4_3400 .BLKW #1
      BACKUP_R5_3400 .BLKW #1
      BACKUP_R6_3400 .BLKW #1
      BACKUP_R7_3400 .BLKW #1
      NUM_BUSY       .STRINGZ    "\nCHOICE 2: Number of machines busy is \n"
      COUNT1          .FILL #15
      EMPTY11         .FILL #0
      .END

;---------------------------------------------------------------------------------   
