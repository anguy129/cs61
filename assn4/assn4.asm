;=================================================
; Name: <Goshtasbi, Rashid>
; Username: rgosh001
; 
; Assignment name: <assn 4>
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
   START
      LEA R0, PROMPT          ;outputs input prompt for the user
      TRAP x22


      LD R1, EMPTY            ;initialize R1 to 0
      LD R3, EMPTY            ;for neg number

      LD R5, EMPTY            ;to make sure no 2nd use or +/- signs
      ADD R5, R5, #1

      INPUT_LOOP
         GETC                 ;get user input
         OUT                  ;ouput it to the screen

         ADD R7, R0, #-10     ;goes to multiplying and outputting the answer
         BRz END_INPUT_LOOP

         
         LD R6, EMPTY         ;init R6 to 0 to use for check
         LD R4, NEG           ;check for NEG# by negating negative dec values to compare to
         NOT R4, R4           ;check to see it its a negative sign inputted
         ADD R4, R4, #1
         ADD R6, R0, R4
         BRz NEG_LOOP         ;enters neg loop if it a neg sign
         BRnp END_NEG_LOOP    ;skips neg loop if it isnt a neg sign

         NEG_LOOP
            LD R3, ONE        ;makes R7 = 1 as a flag to negate answer at the end
            ADD R5, R5, #-1   ;checks to see if a second - was inputted = error
            BRn ERROR1
            BRzp INPUT_LOOP
            ;BRp INPUT_LOOP    ;starts over again
         END_NEG_LOOP


         LD R6, EMPTY         ;init R6 to 0 to use for check
         LD R4, POS           ;check for POS# by negating negative dec values to compare to
         NOT R4, R4           
         ADD R4, R4, #1
         ADD R6, R0, R4
         BRz POS_LOOP
         BRnp END_POS_LOOP

         POS_LOOP
            ADD R5, R5, #-1       ;checks to see if a second + was inputted = error
            BRn ERROR1
            BRzp  INPUT_LOOP      ;if plus sign, re-enter loop as it has no effect
         END_POS_LOOP

         ;---reg number input---
         REG_NUM
            LD R6, EMPTY      ;makes R6 = 0
            LD R4, CHAR_UP    ;load register with ascii value 9
            NOT R4, R4
            ADD R4, R4, #1
            LD R6, EMPTY      
            ADD R6, R0, R4    ;check if the character input is above char 9
            BRp ERROR1        ;if it is, enter ERROR1 loop to restart program
            BRnz END_ERROR    ;if isnt, skip over ERROR1 loop and do next check
            ERROR1
               LEA R0, ERROR
               TRAP x22
               ADD R3, R3, #1
               BRnzp START
            END_ERROR

            LD R6, EMPTY      ;makes R6 = 0
            LD R4, CHAR_DW    ;load register with ascii value 0
            NOT R4, R4
            ADD R4, R4, #1
            LD R6, EMPTY
            ADD R6, R0, R4    ;check if the character input is below char 0
            BRn ERROR1        ;if it is, enter ERROR1 loop to restart program
            BRzp END_ERROR    ;if isnt, skip over ERROR1 loop and do next check
            ERROR1            ;error loop to print out message and restart program
               LEA R0, ERROR
               TRAP x22
               ADD R3, R3, #1
               BRnzp START
            END_ERROR

            LD R6, COUNT10    ;counter for multiplying number by 10
            LD R4, EMPTY      ;init R4 to 0
            ADD R4, R1, #0    ;copies value to multiply itself by 10
            MULT_LOOP         ;multiply value by 10 loop
               ADD R1, R1, R4
               ADD R6, R6, #-1
               BRp MULT_LOOP
               BRz END_MULT_LOOP
            END_MULT_LOOP
            
            LD R6, CONVERT
            NOT R6, R6
            ADD R6, R6, #1
            ADD R0, R0, R6    ;convert to binary
            ADD R1, R1, R0    ;added to R1

            LD R6, EMPTY      ;repeats the loop indefinately unless by enter sign or error
            ADD R6, R6, #0
            BRnzp INPUT_LOOP
         ENG_REG_NUM

      END_INPUT_LOOP


      ADD R3, R3, #0          ;LMS R3 to check if value inputed was negative
      BRp NEG_ANSWER
      BRnz END_NEG_ANSWER
      NEG_ANSWER              ;loop to do 2's complement to negate answer
         NOT R1, R1
         ADD R1, R1, #1
      END_NEG_ANSWER


   HALT                    ;HALT program
   ;---
   ;LOCAL DATA
   ;---
   ERROR       .STRINGZ    "\nError: Only input +/- sign with 1-5 digits only. Please Try Again\n"
   PROMPT      .STRINGZ    "Input a positive or negative decimal number (max 5 digitis)\n"
   PROMPTNEG   .STRINGZ    "NEGATIVE NUMBER INPUTTED\n"
   PROMPTPOS   .STRINGZ    "POSITIVE NUMBER INPUTTED\n"
   
   ONE      .FILL       #1
   EMPTY    .FILL       #0
   CHAR_UP  .FILL       #57
   CHAR_DW  .FILL       #48
   ZERO     .FILL       #0
   CONVERT  .FILL       #48
   COUNT10  .FILL       #9
   ENTER    .FILL       #10
   POS      .FILL       #43
   NEG      .FILL       #45

   .ORIG x4000
   .FILL #0

.END
