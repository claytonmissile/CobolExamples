000100 IDENTIFICATION DIVISION.
000200 PROGRAM-ID. MAYBE02.
000300*--------------------------------------------------
000400* This program asks for a Y or N answer, and then
000500* displays whether the user chose yes or no.
000600* The edit logic allows for entry of Y, y, N, or n.
000700*--------------------------------------------------
000800 ENVIRONMENT DIVISION.
000900 DATA DIVISION.
001000 WORKING-STORAGE SECTION.
001100
001200 01  YES-OR-NO      PIC X.
001300
001400 PROCEDURE DIVISION.
001500 PROGRAM-BEGIN.
001600
001700     PERFORM GET-THE-ANSWER.
001800
001900     PERFORM EDIT-THE-ANSWER.
002000
002100     PERFORM DISPLAY-THE-ANSWER.
002200
002300 PROGRAM-DONE.
002400     STOP RUN.
002500
002600 GET-THE-ANSWER.
002700
002800     DISPLAY "Is the answer Yes, No or Maybe? (Y/N/M)".
002900     ACCEPT YES-OR-NO.
003000
003100 EDIT-THE-ANSWER.
003200
003300     IF YES-OR-NO = "y"
003400         MOVE "Y" TO YES-OR-NO.
003500
003600     IF YES-OR-NO = "n"
003700         MOVE "N" TO YES-OR-NO.
003800
003900     IF YES-OR-NO = "m"
004000         MOVE "M" TO YES-OR-NO.
004100
004200 DISPLAY-THE-ANSWER.
004300
004400     IF YES-OR-NO = "Y" OR
004500        YES-OR-NO = "N" OR
004600        YES-OR-NO = "M"
004700         PERFORM DISPLAY-YES-NO-OR-MAYBE
004800     ELSE
004900         DISPLAY "Your answer was invalid.".
005000
005100 DISPLAY-YES-NO-OR-MAYBE.
005200     IF YES-OR-NO = "Y"
005300         DISPLAY "You answered Yes.".
005400
005500     IF YES-OR-NO = "N"
005600         DISPLAY "You answered No.".
005700
005800     IF YES-OR-NO = "M"
005900         DISPLAY "You answered Maybe.".
006000
