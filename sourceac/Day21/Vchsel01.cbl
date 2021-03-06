000100 IDENTIFICATION DIVISION.
000200 PROGRAM-ID. VCHSEL01.
000300*---------------------------------
000400* Asks the user for a cut off
000500* date
000600*
000700* 1. Searches the voucher file for
000800*    unpaid vouchers that are
000900*    within the cut off date
001000*    and re flags them as selected
001100*---------------------------------
001200 ENVIRONMENT DIVISION.
001300 INPUT-OUTPUT SECTION.
001400 FILE-CONTROL.
001500
001600     COPY "SLVOUCH.CBL".
001700
001800 DATA DIVISION.
001900 FILE SECTION.
002000
002100     COPY "FDVOUCH.CBL".
002200
002300 WORKING-STORAGE SECTION.
002400
002500 77  OK-TO-PROCESS           PIC X.
002600 77  VOUCHER-FILE-AT-END     PIC X.
002700
002800 77  CUT-OFF-DATE            PIC 9(8).
002900
003000     COPY "WSCASE01.CBL".
003100
003200     COPY "WSDATE01.CBL".
003300
003400 PROCEDURE DIVISION.
003500 PROGRAM-BEGIN.
003600     PERFORM OPENING-PROCEDURE.
003700     PERFORM MAIN-PROCESS.
003800     PERFORM CLOSING-PROCEDURE.
003900
004000 PROGRAM-EXIT.
004100     EXIT PROGRAM.
004200
004300 PROGRAM-DONE.
004400     ACCEPT OMITTED. STOP RUN.
004500
004600 OPENING-PROCEDURE.
004700     OPEN I-O VOUCHER-FILE.
004800
004900 CLOSING-PROCEDURE.
005000     CLOSE VOUCHER-FILE.
005100
005200 MAIN-PROCESS.
005300     PERFORM GET-OK-TO-PROCESS.
005400     IF OK-TO-PROCESS = "Y"
005500         PERFORM GET-CUT-OFF-DATE
005600         PERFORM PROCESS-VOUCHERS.
005700
005800 GET-OK-TO-PROCESS.
005900     PERFORM ACCEPT-OK-TO-PROCESS.
006000     PERFORM RE-ACCEPT-OK-TO-PROCESS
006100         UNTIL OK-TO-PROCESS = "Y" OR "N".
006200
006300 ACCEPT-OK-TO-PROCESS.
006400     DISPLAY "SELECT VOUCHER BY DATE RANGE (Y/N)?".
006500     ACCEPT OK-TO-PROCESS.
006600     INSPECT OK-TO-PROCESS
006700       CONVERTING LOWER-ALPHA
006800       TO         UPPER-ALPHA.
006900
007000
007100 RE-ACCEPT-OK-TO-PROCESS.
007200     DISPLAY "YOU MUST ENTER YES OR NO".
007300     PERFORM ACCEPT-OK-TO-PROCESS.
007400
007500 GET-CUT-OFF-DATE.
007600     MOVE "N" TO ZERO-DATE-IS-OK.
007700     MOVE "SELECT ON OR BEFORE (MM/DD/CCYY)?"
007800             TO DATE-PROMPT.
007900     PERFORM GET-A-DATE.
008000     MOVE DATE-CCYYMMDD TO CUT-OFF-DATE.
008100
008200*---------------------------------
008300* Clear all previous selections.
008400*---------------------------------
008500 PROCESS-VOUCHERS.
008600     PERFORM READ-FIRST-VALID-VOUCHER.
008700     PERFORM PROCESS-ALL-VOUCHERS
008800         UNTIL VOUCHER-FILE-AT-END = "Y".
008900
009000 PROCESS-ALL-VOUCHERS.
009100     PERFORM PROCESS-THIS-VOUCHER.
009200     PERFORM READ-NEXT-VALID-VOUCHER.
009300
009400 PROCESS-THIS-VOUCHER.
009500     MOVE "Y" TO VOUCHER-SELECTED
009600     PERFORM REWRITE-VOUCHER-RECORD.
009700
009800*---------------------------------
009900* Read first, read next routines
010000*---------------------------------
010100 READ-FIRST-VALID-VOUCHER.
010200     PERFORM READ-NEXT-VALID-VOUCHER.
010300
010400 READ-NEXT-VALID-VOUCHER.
010500     PERFORM READ-NEXT-VOUCHER-RECORD.
010600     PERFORM READ-NEXT-VOUCHER-RECORD
010700         UNTIL VOUCHER-FILE-AT-END = "Y"
010800            OR (    VOUCHER-PAID-DATE = ZEROES
010900                AND VOUCHER-DUE NOT > CUT-OFF-DATE).
011000
011100 READ-NEXT-VOUCHER-RECORD.
011200     MOVE  "N" TO VOUCHER-FILE-AT-END.
011300     READ VOUCHER-FILE NEXT RECORD
011400        AT END
011500         MOVE "Y" TO VOUCHER-FILE-AT-END.
011600
011700*---------------------------------
011800* Other File I-O routines.
011900*---------------------------------
012000 REWRITE-VOUCHER-RECORD.
012100     REWRITE VOUCHER-RECORD
012200         INVALID KEY
012300         DISPLAY "ERROR REWRITING VENDOR RECORD".
012400*---------------------------------
012500* Utility routines.
012600*---------------------------------
012700     COPY "PLDATE01.CBL".
012800
