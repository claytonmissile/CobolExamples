000100 IDENTIFICATION DIVISION.
000200 PROGRAM-ID. QUIT01.
000300 ENVIRONMENT DIVISION.
000400 DATA DIVISION.
000500 WORKING-STORAGE SECTION.
000600
000700 01  YES-OR-NO       PIC X.
000800
000900 PROCEDURE DIVISION.
001000 PROGRAM-BEGIN.
001100
001200     PERFORM SHALL-WE-CONTINUE.
001300     IF YES-OR-NO = "N"
001400         GO TO PROGRAM-DONE.
001500
001600     PERFORM MAIN-LOGIC.
001700
001800 PROGRAM-DONE.
001900     ACCEPT OMITTED. STOP RUN.
002000
002100 SHALL-WE-CONTINUE.
002200     DISPLAY "Continue (Y/N)?".
002300     ACCEPT YES-OR-NO.
002400     IF YES-OR-NO = "n"
002500         MOVE "N" TO YES-OR-NO.
002600
002700 MAIN-LOGIC.
002800     DISPLAY "This is the main logic.".
002900
