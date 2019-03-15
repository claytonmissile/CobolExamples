000100 IDENTIFICATION DIVISION.
000200 PROGRAM-ID. DOW.
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
001500 01  CD-DATE.
001600     05  CD-CCYYMMDD          PIC 9(8).
001700     05  FILLER               PIC X(13).
001800 01  ENTERED-DATE             PIC 9(8).
001900 01  ANSI-DATE                PIC 9(6).
002000 01  THE-DOW                  PIC 9.
002100
002200 01  DAYS-OF-WEEK.
002300     05  FILLER               PIC X(9) VALUE "SUNDAY".
002400     05  FILLER               PIC X(9) VALUE "MONDAY".
002500     05  FILLER               PIC X(9) VALUE "TUESDAY".
002600     05  FILLER               PIC X(9) VALUE "WEDNESDAY".
002700     05  FILLER               PIC X(9) VALUE "THURSDAY".
002800     05  FILLER               PIC X(9) VALUE "FRIDAY".
002900     05  FILLER               PIC X(9) VALUE "SATURDAY".
003000 01  FILLER REDEFINES DAYS-OF-WEEK.
003100     05  THE-DAY              PIC X(9) OCCURS 7 TIMES.
003200
003300 01  DOW-SUBSCRIPT            PIC S9.
003400
003500 01  DUMMY     PIC X.
003600
003700 PROCEDURE DIVISION.
003800 MAIN-LOGIC SECTION.
003900 PROGRAM-BEGIN.
004000
004100     PERFORM OPENING-PROCEDURE.
004200     PERFORM MAIN-PROCESS.
004300     PERFORM CLOSING-PROCEDURE.
004400
004500 EXIT-PROGRAM.
004600     EXIT PROGRAM.
004700 STOP-RUN.
004800     ACCEPT OMITTED. STOP RUN.
004900
005000
005100 THE-OTHER SECTION.
005200
005300 OPENING-PROCEDURE.
005400 CLOSING-PROCEDURE.
005500 MAIN-PROCESS.
005600     MOVE 1 TO ENTERED-DATE.
005700     PERFORM ENTER-PARAMETERS.
005800     PERFORM TEST-DOW UNTIL
005900         ENTERED-DATE = 0.
006000
006100 ENTER-PARAMETERS.
006200     DISPLAY "ENTER A DATE IN CCYYMMDD FORMAT (0 TO QUIT)".
006300     ACCEPT ENTERED-DATE.
006400
006500 TEST-DOW.
006600     MOVE FUNCTION CURRENT-DATE TO CD-DATE.
006700
006800     COMPUTE ANSI-DATE = FUNCTION INTEGER-OF-DATE(CD-CCYYMMDD).
006900     COMPUTE THE-DOW = FUNCTION REM(ANSI-DATE,7).
007000     COMPUTE DOW-SUBSCRIPT = THE-DOW + 1.
007100
007200     DISPLAY "TODAY IS " CD-CCYYMMDD " A "
007300         THE-DAY(DOW-SUBSCRIPT).
007400
007500     COMPUTE DOW-SUBSCRIPT = FUNCTION REM(
007600         FUNCTION INTEGER-OF-DATE(ENTERED-DATE), 7) + 1.
007700
007800     DISPLAY ENTERED-DATE " IS A "
007900         THE-DAY(DOW-SUBSCRIPT).
008000
008100     DISPLAY "PRESS ENTER TO CONTINUE . . . "
008200     ACCEPT DUMMY.
008300
008400     PERFORM ENTER-PARAMETERS.
008500