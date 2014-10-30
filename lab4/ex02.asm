;================================================
; Name: <Goshtasbi, Rashid>
; Username: rgosh001
; 
; Lab: <lab 4, Exercise 2>
; Lab section: 023
; TA: Bryan Marsh
; 
;=================================================

.ORIG x3000
   ;----------------------
   ;Instructions
   ;----------------------
   LD R3, COUNT
   LD R1, LOCATION
   LOOP
      LDR R2, R1, #0

      ADD R2, R2, #1

      ADD R1, R1, #1
      STR R2, R1, #0


      ;LD R5, ENTER
      ;NOT R5, R5
      ;ADD R5, R5, #1
      
      ;ADD R5, R5, R0

      ADD R3, R3, #-1
      BRz END_LOOP
      BRnp LOOP
   END_LOOP

   LD R2, LOCATION
   LD R3, NUM
   ADD R2, R2, #6
   ADD R0, R2, R3
   TRAP x21

   HALT
   ;---
   ;LOCAL DATA
   ;---
   COUNT    .FILL    #9
   LOCATION .FILL    x4000
   NUM      .FILL    x30
   

   .ORIG x4000
   .FILL #0

.END
