;=================================================
; Name: <Goshtasbi, Rashid>
; Username: rgosh001
; 
; Lab: <lab 2, Exercise 2>
; Lab section: 023
; TA: Bryan Marsh
; 
;=================================================

.ORIG x3000
   ;----------------------
   ;Instructions
   ;----------------------
   LDI R3, DEC_65     ;R4, <-- #65
   LDI R4, HEX_41     ;R3, <-- #41
   
   ADD R3, R3, #1
   ADD R4, R4, #1
   

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
   NEW_DEC_65  .FILL #65
   NEW_HEX_41  .FILL x41
   
   STI R3, NEW_DEC_65
   STI R4, NEW_HEX_41

.END
