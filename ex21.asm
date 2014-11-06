;=================================================
; Name: Ting, Daniel
; Username: dting001
; Lab: 04
; Lab section: 22
; TA: Bryan Marsh
;=================================================


.orig x3000
        ;Get user input
        LEA R0, PROMPT
        PUTS
        GETC ;gets the b
        OUT


        LD R1, SUB_USER_INPUT
        JSRR R1


        LD R0, NEWLINES
        OUT


        LD R1, SUB_USER_OUTPUT
        JSRR R1






;Local Data
HALT
        SUB_USER_INPUT .FILL x3200
        SUB_USER_OUTPUT .FILL x3400
        PROMPT .stringz "Enter a 16-bit 2's complement binary number preceded by a b: \n"
        NEWLINES .FILL x0A


;First subroutine, SUB_USER_INPUT
.orig x3200
        
        ST R7, BACKUP_R7_3200


        ;Load the counter
        LD R1, COUNTER_SIXTEEN
        LD R4, CONVERT


        FOR_LOOP ;gets remainder of user input
                GETC
                OUT


                ;Check if the count is 0
                ADD R6, R1, #-1
                BRz ZERO_CASE


                ;Convert the user input, and store the conversion into R3
                LD R6, ZERO
                ADD R3, R0, R4


                ADD R5, R1, #0 ;Store current counter into R5
                ADD R5, R5, #-1
                MULT ;counter will be based off R1, and will be stored in R5
                        ADD R3, R3, R3


                        ADD R5, R5, #-1
                        BRp MULT
                END_MULT
                BR SKIPZERO




                ZERO_CASE ;check to see if user input was 1
                        ADD R3, R0, R4 ;Convert user input
                         BRp ISONE
                NOTONE
                        GO_ON
                ISONE
                        ADD R3, R3, #0         
                GO_ON
                
                SKIPZERO
                ADD R2, R2, R3
                LD R3, ZERO


                ADD R1, R1, #-1
                BRp FOR_LOOP
        END_FOR_LOOP


        LD R7, BACKUP_R7_3200


;Return for subroutine
RET


;Subroutine Data
BACKUP_R7_3200 .BLKW #1
CONVERT .FILL #-48
COUNTER_SIXTEEN .FILL #16
ZERO .FILL #0


.orig x3400
        
        ST R2, BACKUP_R2_3400
        ST R7, BACKUP_R7_3400




        ;Printing out LetterB
                LD R0, LETTERB
                OUT
                LD R3, ITERATE
                LD R6, HEXNUM


        DO_WHILE_LOOP ;SMALL LOOP
                        ADD R2, R2, #0                                 ;Checking for MSB 
                        
                        BRn ISNEG                                         ;If the result in R2 is 0
                        
                        ISZERO
                                LD R0, ZERO_TWO
                                OUT
                                ;If it goes here, needs another branch so it never goes to isneg
                                BR GO_ON
                        
                        ISNEG
                                LD R0, ONE
                                OUT
                        
                        GO_ON
                        
                        ADD R3, R3, #-1
                        ADD R5, R3, #-4                                ;checks for space values
                    BRz SPACE
                    ADD R5, R3, #-8
                    BRz SPACE
                    ADD R5, R3, #-12        
                    BRz SPACE
                        
                        NOSPACE
                                BR SKIPSPACE


                        SPACE
                                LD R0, SPACER
                                OUT


                        SKIPSPACE
                        
                        ADD R3, R3, #1
                        ADD R2, R2, R2                                 ;Left-shift
                        ADD R3, R3, #-1                         ;Decrement the sentinal, aka ITERATE
                        BRp DO_WHILE_LOOP
                        
                END_DO_WHILE_LOOP




                
        ;Printing out Newline
        LD R0, NEWLINE
        OUT


;Restore any registers that were backed up
LD R2, BACKUP_R2_3400
LD R7, BACKUP_R7_3400


;Return
RET


;Subroutine Data
BACKUP_R2_3400 .BLKW #1
BACKUP_R7_3400 .BLKW #1


ZERO_TWO .FILL x030
ONE .FILL x031
DECNUM .FILL #169
HEXNUM .FILL #2
ITERATE .FILL #16
SPACER .FILL x020
NEWLINE .FILL x0A
LETTERB .FILL #98








.end