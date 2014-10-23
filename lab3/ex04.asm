;================================================
; Name: <Goshtasbi, Rashid>
; Username: rgosh001
; 
; Lab: <lab 3, Exercise 4>
; Lab section: 023
; TA: Bryan Marsh
; 
;=================================================

;COULDNT WORK THIS EXERCISE OUT
;BELOW IS JUST PART OF MY CODE FORM LAB3-3 ADDED FOR THIS EXERCISE

.ORIG x3000
   .BLKW #10
   ;----------------------
   ;Instructions
   ;----------------------
   LEA R0, INPUT
   PUTS
   LD R1, COUNT         ;COUNTS THE INPUT AMOUNTS
   LD R3, NEWLINE       ;NEWLINE CHARACTER TO SEPARATE THE INPUTS AS INSTRUCTED IN SPECS
   
   
   LD R2, LOCATION
   LOOP
      TRAP x20          ;GETC
      STR R0, R2, #0
      ADD R2, R2, #1
      ADD R1, R1, #1


      LD R5, ENTER
      NOT R5, R5
      ADD R5, R5, #1
      
      ADD R5, R5, R0

      ;ADD R1, R1, #-1
      BRz END_LOOP
      BRnp LOOP
   END_LOOP

   LD R2, LOCATION
   OUT_LOOP
      ;LDR R4, R2, #0

      LDR R0, R2, #0
      TRAP x21
      ADD R2, R2, #1

      LD R0, NEWLINE
      OUT

      ADD R1, R1, #-1
      BRp OUT_LOOP
   END_OUT_LOOP

   HALT
   ;---
   ;LOCAL DATA
   ;---
   COUNT    .FILL       #0
   INPUT    .STRINGZ    "Enter 10 characters (Press Enter Key When Done):\n"
   NEWLINE  .STRINGZ    "\n"
   LOCATION .FILL       x4000
   ENTER    .FILL       #10
   
   .ORIG x4000
            .BLKW #100

.END
