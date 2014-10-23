;=================================================
; Name: <Goshtasbi, Rashid>
; Username: rgosh001
; 
; Lab: <lab 3, Exercise 1>
; Lab section: 023
; TA: Bryan Marsh
; 
;=================================================

.ORIG x3000
   ;----------------------
   ;Instructions
   ;----------------------
   LD R5, DATA_PTR ;R5, <-- x4000
   
   LDR R3, R5, #0 ;R3 <-- x4000
   ADD R3, R3, #1
   STR R3, R5, #0
   
   ADD R5, R5, #1

   STR R3, R5, #0


   ;LEA - loads address into register
   ;LD - loads data value into register
   ;Label is always associate with adress with data or instruction

   HALT
   ;---
   ;LOCAL DATA
   ;---
   DATA_PTR .FILL x4000   ;PUT #65 INTO MEMORY HERE
   
   .orig x4000
   x4000 .FILL #65
   x4001 .FILL x41
   

.END
