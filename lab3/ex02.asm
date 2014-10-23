;================================================
; Name: <Goshtasbi, Rashid>
; Username: rgosh001
; 
; Lab: <lab 3, Exercise 2>
; Lab section: 023
; TA: Bryan Marsh
; 
;=================================================

.ORIG x3000
   .BLKW #10
   ;----------------------
   ;Instructions
   ;----------------------
   LEA R0, INPUT
   PUTS
   LD R1, COUNT
   
   
   LD R2, LOCATION
   LOOP
      TRAP x20          ;GETC
      STR R0, R2, #0
      ADD R2, R2, #1

      ADD R1, R1, #-1
      BRp LOOP
   END_LOOP

   HALT
   ;---
   ;LOCAL DATA
   ;---
   COUNT    .FILL       #10
   INPUT    .STRINGZ    "Enter 10 characters:\n"
   LOCATION .FILL       x4000
   
   .ORIG x4000
   .BLKW #10

.END
