;=================================================
; Name: <Goshtasbi, Rashid>
; Username: rgosh001
; 
; Assignment name: <assn 2>
; Lab section: 023
; TA: Bryan Marsh
; 
; I hereby certify that I have not received assistance on this assignment,
; or used code, from ANY outside source other than the instruction team.
;
;=================================================


.ORIG x3000    ;PROGRAM BEGINS HERE
   ;---
   ;INSTRUCTIONS
   ;---


   LEA R0, ASK_USER     ;ASK FOR USR INPUT IS LOADED IN R0
   PUTS                 ;PUTS DISPLAYS RO
   TRAP x20             ;TRAP TAKES USR INPUT INTO R0
   TRAP x21
   ADD R2, R2, R0       ;TAKES R0 AND PUTS IT INTO R2


   LEA R0, NEG_SIGN  ;PRINTS NEG SIGN
   TRAP x22


   TRAP x20             ;TRAP TAKES USR INPUT INTO R0
   TRAP x21
   ADD R3, R3, R0       ;TAKES R0 AND PUTS IT INTO R3


   LEA R0, EQUALS    ;PRINTS SPACE AND EQUALS SIGN
   TRAP x22
   
   NOT R3, R3           
   ADD R3, R3, #1       ;DOES 1ST OF 2'S COMPLIMENT
   ADD R4, R2, R3
   
   BRzp NOT_NEG_NUM     ;GOES TO REGULAR OUTPUT

   BRn NEG_NUM          ;GOES TO 2'S COMPLIMENT THEN OUTPUT

   NEG_NUM              ;DOES 2'S COMPLIMENT
      NOT R4, R4
      ADD R4, R4, #1
      LEA R0, MINUS
      TRAP x22

      LD R5, ADD_DIF
      ADD R0, R5, R4       ;ADDS x30 TO THE FINAL ANSWER
      TRAP x21

      HALT
   
   NOT_NEG_NUM             ;REGULAR OUTPUT W/O 2'S COMPLIMENT
      LD R5, ADD_DIF
      ADD R0, R5, R4       ;ADDS x30 TO THE FINAL ANSWER
      TRAP x21


   HALT
   ;---
   ;LOCAL DATA
   ;---

   ASK_USER    .STRINGZ "PLEASE ENTER TWO NUMBERS:\n"
   NEG_SIGN    .STRINGZ " - "
   EQUALS      .STRINGZ " = "
   MINUS       .STRINGZ "-"

   ADD_DIF     .FILL x30


.END
