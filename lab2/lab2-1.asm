;=================================================
; Name: <Goshtasbi, Rashid>
; Username: rgosh001
; 
; Lab: <lab 2, Exercise 1>
; Lab section: 023
; TA: Bryan Marsh
; 
;=================================================

.ORIG x3000
   ;----------------------
   ;Instructions
   ;----------------------
   LD R3, DEC_65     ;R4, <-- #65
   LD R4, HEX_41     ;R3, <-- #41

   ;LEA - loads address into register
   ;LD - loads data value into register
   ;Label is always associate with adress with data or instruction

   HALT
   ;---
   ;LOCAL DATA
   ;---
   DEC_65 .FILL #65   ;PUT #65 INTO MEMORY HERE
   HEX_41 .FILL x41   ;PUT x41 INTO MEMORY HERE


.END
