;=================================================
; Name: <Goshtasbi, Rashid>
; Username: rgosh001
; 
; Lab: <lab 2, Exercise 3>
; Lab section: 023
; TA: Bryan Marsh
; 
;=================================================

.ORIG x3000
   ;----------------------
   ;Instructions
   ;----------------------
   LD R5, DEC_65     ;R5, <-- x4000
   LD R6, HEX_41     ;R6, <-- x4001
   
   LDR R3, R5, #0 ;R3 <-- #65
   ADD R3, R3, #1

   LDR R4, R6, #0 ;R4 <-- x41
   ADD R4, R4, #1

   STR R3, R5, #0
   STR R4, R6, #0

   ;LEA - loads address into register
   ;LD - loads data value into register
   ;Label is always associate with adress with data or instruction

   HALT
   ;---
   ;LOCAL DATA
   ;---
   DEC_65 .FILL x4000   ;PUT #65 INTO MEMORY HERE
   HEX_41 .FILL x4001   ;PUT x41 INTO MEMORY HERE
   
   .orig x4000
   x4000 .FILL #65
   x4001 .FILL x41
   

.END
