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
;ITERATION 1      0     0     12    6     0     0     0     1168
;ITERATION 2      0     12    12    5     0     0     0     1168
;ITERATION 3      0     24    12    4     0     0     0     1168
;ITERATION 4      0     36    12    3     0     0     0     1168
;ITERATION 5      0     48    12    2     0     0     0     1168
;ITERATION 5      0     60    12    1     0     0     0     1168
;ITERATION 6      0     72    12    0     0     0     0     DEC_0
;
;END OF PROGRAM   0     72    12    0     0     0     0     DEC_0
;---


.ORIG x3000                 ;PROGRAM BEGINS HERE
   ;----------------------
   ;Instructions
   ;----------------------
   LD R1, DEC_0      ;R1, <-- #0
   LD R2, DEC_12     ;R2, <-- #12
   LD R3, DEC_6      ;R3, <-- #6

   DO_WHILE_LOOP;
      ADD R1, R1, R2    ;R1 <-- R1 = R2
      ADD R3, R3, #-1   ;R3 <-- R3 + (#-1) AKA (R3 - 1)
      BRp DO_WHILE_LOOP ;  if (R3 > 0): goto DO_WHILE_LOOP
   END_DO_WHILE_LOOP

   HALT
   ;---
   ;LOCAL DATA
   ;---
   DEC_0 .FILL #0    ;PUT #0 INTO MEMORY HERE
   DEC_12 .FILL #12  ;PUT #12 INTO MEMORY HERE
   DEC_6 .FILL #6    ;PUT #6 INTO MEMORY HERE


.END
