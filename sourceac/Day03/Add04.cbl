000100 IDENTIFICATION DIVISION.
000200 PROGRAM-ID. ADD04.
000300 ENVIRONMENT DIVISION.
000400 DATA DIVISION.
000500
000600 WORKING-STORAGE SECTION.
000700
000800 01  FIRST-NUMBER      PIC 99.
000900 01  SECOND-NUMBER     PIC 99.
001000 01  THE-RESULT        PIC 999.
001100
001200 PROCEDURE DIVISION.
001300
001400 PROGRAM-BEGIN.
001500
001600     DISPLAY "This program will add 2 numbers.".
001700
001800 GET-FIRST-NUMBER.
001900
002000     DISPLAY "Enter the first number.".
002100
002200     ACCEPT FIRST-NUMBER.
002300
002400 GET-SECOND-NUMBER.
002500
002600     DISPLAY "Enter the second number.".
002700
002800     ACCEPT SECOND-NUMBER.
002900
003000 COMPUTE-AND-DISPLAY.
003100     COMPUTE THE-RESULT = FIRST-NUMBER + SECOND-NUMBER.
003200
003300     DISPLAY "The result is " THE-RESULT.
003400
003500
003600 PROGRAM-DONE.
003700     ACCEPT OMITTED. STOP RUN.
003800
