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
         LD R6, MENU
         JSRR R6

         LD R3, CONVERT    ;convert input to decimal'
         NOT R3, R3
         ADD R3, R3, #1
         ADD R0, R1, R3    ;puts converted decimal into R0
         
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

            ADD R2, R2, #0
            BRn ALLBUSY
            BRzp ALLNOTBUSY
            ALLBUSY
               LEA R0, ALLBUSYPROMPT
               TRAP x22
               LEA R0, NEW_PROMPT
               TRAP x22
               BR LOOP
            ALLNOTBUSY
               LEA R0, ALLNOTBUSYPROMPT
               TRAP x22
               LEA R0, NEW_PROMPT
               TRAP x22
               BR LOOP
         END_ALL_MACHINES_BUSY_CALL

         ALL_MACHINES_FREE_CALL
            LD R6, ALL_MACHINES_FREE
            JSRR R6

            ADD R2, R2, #0
            BRn ALLFREE
            BRzp ALLNOTFREE
            ALLFREE
               LEA R0, ALLFREEPROMPT
               TRAP x22
               LEA R0, NEW_PROMPT
               TRAP x22
               BR LOOP
            ALLNOTFREE
               LEA R0, ALLNOTFREEPROMPT
               TRAP x22
               LEA R0, NEW_PROMPT
               TRAP x22
               BR LOOP
         END_ALL_MACHINES_FREE_CALL

         NUM_BUSY_MACHINES_CALL
            LD R6, NUM_M_B
            JSRR R6

            LEA R0, NEW_PROMPT
            TRAP x22
            BR LOOP
         END_NUM_BUSY_MACHINES_CALL

         NUM_FREE_MACHINES_CALL
            LD R6, NUM_M_F
            JSRR R6

            LEA R0, NEW_PROMPT
            TRAP x22
            BR LOOP
         END_NUM_FREE_MACHINES_CALL

         NUM_MACHINE_STATUS_CALL
            LD R6, M_STATUS
            JSRR R6

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
      CONVERT           .FILL    #48
      MENU              .FILL    x3100
      ALL_MACHINES_BUSY .FILL    x3200
      ALL_MACHINES_FREE .FILL    x3300
      NUM_M_B           .FILL    x3400
      NUM_M_F           .FILL    x3500
      M_STATUS          .FILL    x3600
      NEW_PROMPT        .STRINGZ "\n-----------------------------------\n"
      ERROR_PROMPT      .STRINGZ "\nError: Input Not Valid. Please Try Again."
      TEST              .STRINGZ "TEST\n"
      EXIT_PROMPT       .STRINGZ "\nResponse: 7. Goodbye!\n"
      ALLNOTBUSYPROMPT  .STRINGZ    "ALL NOT BUSY"
      ALLBUSYPROMPT  .STRINGZ    "ALL BUSY"
      ALLNOTFREEPROMPT  .STRINGZ    "ALL NOT FREE"
      ALLFREEPROMPT  .STRINGZ    "ALL FREE"

;---------------------------------------------------------------------------------   
   ;---
   ; SUBROUTINE #1 -- MENU
   ; INPUTS: NONE
   ; POSTCONDITION: PRINT OUT NUMERICAL OPTION MENU
   ; RETURN VALUE IN R1 IS SELECTION
   ;---
   .ORIG x3100

   ;SUBROUTINE INSTRUCTIONS
   ;(1) Backup R7 & any registers the subroutine changes except Return Values
      ST R0, BACKUP_R0_3100
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
         
         TRAP x20          ;get user input
         ADD R1, R0, #0


   ;(3) Restore Registers
      LD R0, BACKUP_R0_3100
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
   ; INPUTS: NONE
   ; POSTCONDITION: CHECKS TO SEE IF ALL MACHINES ARE BUSY
   ; RETURN: R2 is 1 if all machines are busy, 0 otherwise.
   ;---
   .ORIG x3200

   ;SUBROUTINE INSTRUCTIONS
   ;(1) Backup R7 & any registers the subroutine changes except Return Values
      ST R0, BACKUP_R0_3200
      ST R1, BACKUP_R1_3200
      ST R3, BACKUP_R3_3200
      ST R4, BACKUP_R4_3200
      ST R5, BACKUP_R5_3200
      ST R6, BACKUP_R6_3200
      ST R7, BACKUP_R7_3200

   ;(2) Subroutine's algorithm
      ;0 means busy, 1 means free
      LD R1, VECTOR     ;inputs vector into R1
      LD R3, COUNT
      LD R2, EMPTY1
      ADD R2, R2, #1
      LOOP1
         ADD R1, R1, #0
         BRn POS
         BRzp NOT_ALL_BUSY
         POS 
            LD R2, EMPTY1
            ADD R2, R2, #0
            BR END_END
   
         NOT_ALL_BUSY
         ADD R1, R1, R1

         ADD R3, R3, #-1
         BRp LOOP1
         BRnz END_END
      END_END


   ;(3) Restore Registers
      LD R0, BACKUP_R0_3200
      LD R1, BACKUP_R1_3200
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
      BACKUP_R3_3200 .BLKW #1
      BACKUP_R4_3200 .BLKW #1
      BACKUP_R5_3200 .BLKW #1
      BACKUP_R6_3200 .BLKW #1
      BACKUP_R7_3200 .BLKW #1
      VECTOR            .FILL    xABCD
      NOT_BUSY       .STRINGZ    "\nCHOICE 1: Not all machines are busy\n"
      ALL_BUSY       .STRINGZ    "\nCHOICE 1: All machines are busy\n"
      COUNT          .FILL #15
      EMPTY1         .FILL #0
      .END

;---------------------------------------------------------------------------------   
   ;---
   ; SUBROUTINE #3 -- ALL_MACHINES_FREE
   ; INPUTS: NONE
   ; POSTCONDITION: CHECKS TO SEE IF ALL MACHINES ARE FREE
   ; RETURN: R2 is 1 if all machines are FREE, 0 otherwise.
   ;---
   .ORIG x3300

   ;SUBROUTINE INSTRUCTIONS
   ;(1) Backup R7 & any registers the subroutine changes except Return Values
      ST R0, BACKUP_R0_3300
      ST R1, BACKUP_R1_3300
      ST R3, BACKUP_R3_3300
      ST R4, BACKUP_R4_3300
      ST R5, BACKUP_R5_3300
      ST R6, BACKUP_R6_3300
      ST R7, BACKUP_R7_3300

   ;(2) Subroutine's algorithm
      ;0 means busy, 1 means free
      LD R1, VECTOR2     ;inputs vector into R1
      LD R3, COUNT2
      LD R2, EMPTY2
      ADD R2, R2, #1
      LOOP2
         ADD R1, R1, #0
         BRzp POS2
         BRn NOT_ALL_FREE
         POS2
            LD R2, EMPTY2
            ADD R2, R2, #0
            BR END_END2
   
         NOT_ALL_FREE
         ADD R1, R1, R1

         ADD R3, R3, #-1
         BRp LOOP2
         BRnz END_END2
      END_END2

   ;(3) Restore Registers
      LD R0, BACKUP_R0_3300
      LD R1, BACKUP_R1_3300
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
      BACKUP_R3_3300 .BLKW #1
      BACKUP_R4_3300 .BLKW #1
      BACKUP_R5_3300 .BLKW #1
      BACKUP_R6_3300 .BLKW #1
      BACKUP_R7_3300 .BLKW #1
      VECTOR2           .FILL    xABCD
      NOT_FREE       .STRINGZ    "\nCHOICE 1: Not all machines are busy\n"
      ALL_FREE       .STRINGZ    "\nCHOICE 1: All machines are busy\n"
      COUNT2         .FILL #15
      EMPTY2         .FILL #0
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
      ST R2, BACKUP_R2_3400
      ST R3, BACKUP_R3_3400
      ST R4, BACKUP_R4_3400
      ST R5, BACKUP_R5_3400
      ST R6, BACKUP_R6_3400
      ST R7, BACKUP_R7_3400

   ;(2) Subroutine's algorithm
      ;0 means busy, 1 means free
      LD R2, EMPTY_IT

      LD R3, COUNT_IT
      LOOP_IT
         ADD R1, R1, #0
         BRp POS_IT
         BRn SKIP_IT
         POS_IT
            ADD R2, R2, #1    ;0 is BUSY
            BR SKIP_IT
         END_POS_IT
   
         SKIP_IT

         ADD R3, R3, #-1
         BRp LOOP_IT
         BRnz END_IT_ALL
      END_IT_ALL

      LEA R0, NUMBER_BUSY
      TRAP x22

      LD R3, CONVERT2
      ADD R0, R2, R3
      TRAP x21


   ;(3) Restore Registers
      LD R0, BACKUP_R0_3400
      LD R1, BACKUP_R1_3400
      LD R2, BACKUP_R2_3400
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
      BACKUP_R2_3400 .BLKW #1
      BACKUP_R3_3400 .BLKW #1
      BACKUP_R4_3400 .BLKW #1
      BACKUP_R5_3400 .BLKW #1
      BACKUP_R6_3400 .BLKW #1
      BACKUP_R7_3400 .BLKW #1
      CONVERT2 .FILL x30
      NUMBER_BUSY       .STRINGZ    "Number of machines busy: "
      EMPTY_IT         .FILL #0
      COUNT_IT       .FILL    #15
      .END

;---------------------------------------------------------------------------------   
   ;---
   ; SUBROUTINE #5 -- NUM_FREE_MACHINES
   ;---
   .ORIG x3500

   ;SUBROUTINE INSTRUCTIONS
   ;(1) Backup R7 & any registers the subroutine changes except Return Values
      ST R0, BACKUP_R0_3500
      ST R1, BACKUP_R1_3500
      ST R2, BACKUP_R2_3500
      ST R3, BACKUP_R3_3500
      ST R4, BACKUP_R4_3500
      ST R5, BACKUP_R5_3500
      ST R6, BACKUP_R6_3500
      ST R7, BACKUP_R7_3500

   ;(2) Subroutine's algorithm
      ;0 means busy, 1 means free
      LD R1, EMPTY_IT1

      LD R3, COUNT_IT1
      LOOP_IT1
         ADD R2, R2, #0
         BRn NEG_IT
         BRp SKIP_IT1
         NEG_IT
            ADD R1, R1, #1    ;0 is BUSY
            BR SKIP_IT1
         END_NEG_IT
   
         SKIP_IT1

         ADD R3, R3, #-1
         BRp LOOP_IT1
         BRnz END_IT_ALL1
      END_IT_ALL1

      LEA R0, NUMBER_FREE
      TRAP x22

      LD R3, CONVERT1
      ADD R0, R1, R3
      TRAP x21


   ;(3) Restore Registers
      LD R0, BACKUP_R0_3500
      LD R1, BACKUP_R1_3500
      LD R2, BACKUP_R2_3500
      LD R3, BACKUP_R3_3500
      LD R4, BACKUP_R4_3500
      LD R5, BACKUP_R5_3500
      LD R6, BACKUP_R6_3500
      LD R7, BACKUP_R7_3500

   ;(4) Return
      RET

   ; Subroutine Data
      BACKUP_R0_3500 .BLKW #1
      BACKUP_R1_3500 .BLKW #1
      BACKUP_R2_3500 .BLKW #1
      BACKUP_R3_3500 .BLKW #1
      BACKUP_R4_3500 .BLKW #1
      BACKUP_R5_3500 .BLKW #1
      BACKUP_R6_3500 .BLKW #1
      BACKUP_R7_3500 .BLKW #1
      NUMBER_FREE       .STRINGZ    "Number of machines free: "
      EMPTY_IT1         .FILL #0
      COUNT_IT1       .FILL    #15
      CONVERT1    .FILL x30
      .END
;---------------------------------------------------------------------------------   
   ;---
   ; SUBROUTINE #6 -- MACHINE_STATUS
   ;---
   .ORIG x3600

   ;SUBROUTINE INSTRUCTIONS
   ;(1) Backup R7 & any registers the subroutine changes except Return Values
      ST R0, BACKUP_R0_3600
      ST R1, BACKUP_R1_3600
      ST R2, BACKUP_R2_3600
      ST R3, BACKUP_R3_3600
      ST R4, BACKUP_R4_3600
      ST R5, BACKUP_R5_3600
      ST R6, BACKUP_R6_3600
      ST R7, BACKUP_R7_3600

   ;(2) Subroutine's algorithm
      ;0 means busy, 1 means free
      LD R1, EMPTY12

      LD R3, COUNT12
      LEA R0, N_MACHINE
      TRAP x22

      TRAP x20
      NOT R0, R0
      ADD R0, R0, #1

      ADD R3, R3, R0
      LD R4, EMPTY12

      LOOP12
         ADD R2, R2, R2

         ADD R3, R3, #-1
         BRn STATUS_CHECK
         BRzp LOOP12
         STATUS_CHECK
            ADD R2, R2, #0
            BRn NEG_STATUS
            BRp POS_STATUS
            NEG_STATUS
               ADD R4, R4, #1    ;1 is busy
               BR END_END12   
            POS_STATUS
               ADD R4, R4, #1    ;0 is FREE
               BR END_END12
            END_POS_STATUS
         END_STATUS_CHECK
      END_END12

      LEA R0, N_MACHINE_STATUS
      TRAP x22

      ADD R4, R4, #0
      BRn BUSY_OUT
      BRp FREE_OUT
      BUSY_OUT
         LEA R0, STAT_BUSY
         TRAP x22
         BR FINISHED
      FREE_OUT
         LEA R0, STAT_FREE
         TRAP x22
         BR FINISHED

      FINISHED

   ;(3) Restore Registers
      LD R0, BACKUP_R0_3600
      LD R1, BACKUP_R1_3600
      LD R2, BACKUP_R2_3600
      LD R3, BACKUP_R3_3600
      LD R4, BACKUP_R4_3600
      LD R5, BACKUP_R5_3600
      LD R6, BACKUP_R6_3600
      LD R7, BACKUP_R7_3600

   ;(4) Return
      RET

   ; Subroutine Data
      BACKUP_R0_3600 .BLKW #1
      BACKUP_R1_3600 .BLKW #1
      BACKUP_R2_3600 .BLKW #1
      BACKUP_R3_3600 .BLKW #1
      BACKUP_R4_3600 .BLKW #1
      BACKUP_R5_3600 .BLKW #1
      BACKUP_R6_3600 .BLKW #1
      BACKUP_R7_3600 .BLKW #1
      N_MACHINE         .STRINGZ    "Enter Machine Number To Check Status: "
      N_MACHINE_STATUS  .STRINGZ    "Status: "
      STAT_BUSY         .STRINGZ    "BUSY\n"
      STAT_FREE         .STRINGZ    "FREE\n"
      COUNT12          .FILL #15
      EMPTY12         .FILL #0
      .END

;---------------------------------------------------------------------------------   
