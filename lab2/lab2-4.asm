;=================================================
; Name: <Goshtasbi, Rashid>
; Username: rgosh001
; 
; Lab: <lab 2, Exercise 4>
; Lab section: 023
; TA: Bryan Marsh
; 
;=================================================

.ORIG x3000
   ;----------------------
   ;Instructions
   ;----------------------
   LD R0, DEC_1     ;R5, <-- x4000
   LD R1, DEC_2     ;R6, <-- x4001

   LOOP
      TRAP x21
      ADD R0, R0, #1
      ADD R1, R1, #-1
   BRp LOOP

   HALT 

   DEC_1 .FILL x61
   DEC_2 .FILL x1A

.END
