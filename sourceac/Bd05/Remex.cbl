000100 IDENTIFICATION DIVISION.
000200 PROGRAM-ID. REMEX.
000300 AUTHOR. MO BUDLONG.
000400 INSTALLATION.
000500 DATE-WRITTEN. 09/07/96.
000600 DATE-COMPILED.
000700 SECURITY. NONE
000800 ENVIRONMENT DIVISION.
000900 INPUT-OUTPUT SECTION.
001000 FILE-CONTROL.
001100 DATA DIVISION.
001200 FILE SECTION.
001300 WORKING-STORAGE SECTION.
001400
001500 01  NUMERIC-1                PIC 9(9).
001600 01  NUMERIC-2                PIC 9(9).
001700 01  NUMERIC-3                PIC 9(9).
001800
001900 01  DUMMY     PIC X.
002000
002100 PROCEDURE DIVISION.
002200 MAIN-LOGIC SECTION.
002300 PROGRAM-BEGIN.
002400
002500     PERFORM OPENING-PROCEDURE.
002600     PERFORM MAIN-PROCESS.
002700     PERFORM CLOSING-PROCEDURE.
002800
002900 EXIT-PROGRAM.
003000     EXIT PROGRAM.
003100 STOP-RUN.
003200     ACCEPT OMITTED. STOP RUN.
003300
003400
003500 THE-OTHER SECTION.
003600
003700 OPENING-PROCEDURE.
003800 CLOSING-PROCEDURE.
003900 MAIN-PROCESS.
004000     MOVE 1 TO NUMERIC-1, NUMERIC-2.
004100     PERFORM ENTER-PARAMETERS.
004200     PERFORM TEST-REM UNTIL
004300         NUMERIC-1 = 0
004400      OR NUMERIC-2 = 0.
004500
004600 ENTER-PARAMETERS.
004700     DISPLAY "ENTER LARGER NUMBER (0 TO QUIT)".
004800     ACCEPT NUMERIC-1.
004900
005000     IF NUMERIC-1 NOT = 0
005100         DISPLAY "ENTER SMALLER NUMER (0 TO QUIT)"
005200         ACCEPT NUMERIC-2.
005300
005400 TEST-REM.
005500     COMPUTE NUMERIC-3 =
005600         FUNCTION REM (NUMERIC-1, NUMERIC-2).
005700
005800     DISPLAY "REMAINDER OF " NUMERIC-1 "/" NUMERIC-2 " IS ".
005900     DISPLAY NUMERIC-3.
006000     DISPLAY "PRESS ENTER TO CONTINUE . . . "
006100     ACCEPT DUMMY.
006200
006300     PERFORM ENTER-PARAMETERS.
006400
