;=================================================
; Name: <Goshtasbi, Rashid>
; Username: rgosh001
; 
; Assignment name: <assn 1>
; Lab section: 023
; TA: Bryan Marsh
; 
; I hereby certify that I have not received assistance on this assignment,
; or used code, from ANY outside source other than the instruction team.
;
;=================================================

;---
;REG VALUES
;---
;**We are using the variables 8 * 5 as our two numbers
;REGISTERS        R0    R1    R2    R3    R4    R5    R6    R7
;
;PRE-LOOP         0     32767 0     0     0     0     0     1168
;ITERATION 1      0     5     8     0     0     0     0     1168
;ITERATION 2      0     4     8     8     0     0     0     1168
;ITERATION 3      0     3     8     16    0     0     0     1168
;ITERATION 4      0     2     8     24    0     0     0     1168
;ITERATION 5      0     1     8     32    0     0     0     1168
;
;END OF PROGRAM   0     0     8     40    0     0     0     DEC_0
;---

.ORIG x3000                   ;PROGRAM BEGINS HERE
;---
;INSTRUCTIONS
;---
LD R1, DEC_5                  ;R1 = DEC_5 => 5
LD R2, DEC_8                  ;R2 = DEC_8 => 8
LD R3, DEC_0                  ;R3 = DEC_0 => 0

DO_WHILE    ADD R3, R3, R2    ;R3 = R3 + R2
            ADD R1, R1, #-1   ;R1 = R1 - 1
            BRp DO_WHILE      ;WILL KEEP LOOPING UNTILL R1 EQUALS 0 (OR NOT POSITIVE)

HALT
;---
;DATA
;---
DEC_0    .FILL #0             ;DEC_0   = 0
DEC_5    .FILL #5             ;DEC_5   = 6
DEC_8    .FILL #8             ;DEC_8   = 12

.END                          ;PROGRAM ENDS HERE
