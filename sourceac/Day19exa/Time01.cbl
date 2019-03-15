000100 IDENTIFICATION DIVISION.
000200 PROGRAM-ID. TIME01.
000300*---------------------------------
000400* Testing CHECK-TIME
000500*---------------------------------
000600 ENVIRONMENT DIVISION.
000700 INPUT-OUTPUT SECTION.
000800 FILE-CONTROL.
000900
001000 DATA DIVISION.
001100 FILE SECTION.
001200
001300 WORKING-STORAGE SECTION.
001400
001500 77  ANY-TIME           PIC 9(6) VALUE ZEROES.
001600
001700 77  TIME-FIELD         PIC Z(6).
001800
001900     COPY "WSTIME01.CBL".
002000
002100 PROCEDURE DIVISION.
002200 PROGRAM-BEGIN.
002300     PERFORM OPENING-PROCEDURE.
002400     PERFORM MAIN-PROCESS.
002500     PERFORM CLOSING-PROCEDURE.
002600
002700 PROGRAM-EXIT.
002800     EXIT PROGRAM.
002900
003000 PROGRAM-DONE.
003100     ACCEPT OMITTED. STOP RUN.
003200
003300 OPENING-PROCEDURE.
003400
003500 CLOSING-PROCEDURE.
003600
003700 MAIN-PROCESS.
003800     PERFORM GET-A-TIME.
003900     PERFORM DISPLAY-AND-GET-TIME
004000         UNTIL ANY-TIME = 000001.
004100
004200 GET-A-TIME.
004300     PERFORM ACCEPT-A-TIME.
004400     PERFORM RE-ACCEPT-A-TIME
004500         UNTIL TIME-IS-VALID.
004600     MOVE TIME-HHMMSS TO ANY-TIME.
004700
004800 ACCEPT-A-TIME.
004900     DISPLAY "ENTER A TIME (HHMMSS) (000001 TO EXIT)"
005000     ACCEPT TIME-FIELD.
005100     PERFORM EDIT-CHECK-TIME.
005200
005300 RE-ACCEPT-A-TIME.
005400     DISPLAY "INVALID TIME"
005500     PERFORM ACCEPT-A-TIME.
005600
005700 EDIT-CHECK-TIME.
005800     PERFORM EDIT-TIME.
005900     PERFORM CHECK-TIME.
006000
006100 EDIT-TIME.
006200     MOVE TIME-FIELD TO TIME-HHMMSS.
006300
006400 DISPLAY-AND-GET-TIME.
006500     PERFORM DISPLAY-THE-TIME.
006600     PERFORM GET-A-TIME.
006700
006800 DISPLAY-THE-TIME.
006900     DISPLAY "ANY TIME IS " ANY-TIME.
007000
007100     COPY "PLTIME01.CBL".
007200
