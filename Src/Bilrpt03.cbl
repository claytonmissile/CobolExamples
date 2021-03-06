000100 IDENTIFICATION DIVISION.
000200 PROGRAM-ID. BILRPT03.
000300*---------------------------------
000400* Bills Report with totals by day.
000500*---------------------------------
000600 ENVIRONMENT DIVISION.
000700 INPUT-OUTPUT SECTION.
000800 FILE-CONTROL.
000900
001000     COPY "SLVOUCH.CBL".
001100
001200     COPY "SLVND02.CBL".
001300
001400     COPY "SLSTATE.CBL".
001500
001600     SELECT WORK-FILE
001700         ASSIGN TO "WORK"
001800         ORGANIZATION IS SEQUENTIAL.
001900
002000     SELECT SORT-FILE
002100         ASSIGN TO "SORT".
002200
002300     SELECT PRINTER-FILE
002400         ASSIGN TO PRINTER
002500         ORGANIZATION IS LINE SEQUENTIAL.
002600
002700 DATA DIVISION.
002800 FILE SECTION.
002900
003000     COPY "FDVOUCH.CBL".
003100
003200     COPY "FDVND04.CBL".
003300
003400     COPY "FDSTATE.CBL".
003500
003600 FD  WORK-FILE
003700     LABEL RECORDS ARE STANDARD.
003800 01  WORK-RECORD.
003900     05  WORK-NUMBER           PIC 9(5).
004000     05  WORK-VENDOR           PIC 9(5).
004100     05  WORK-INVOICE          PIC X(15).
004200     05  WORK-FOR              PIC X(30).
004300     05  WORK-AMOUNT           PIC S9(6)V99.
004400     05  WORK-DATE             PIC 9(8).
004500     05  WORK-DUE              PIC 9(8).
004600     05  WORK-DEDUCTIBLE       PIC X.
004700     05  WORK-SELECTED         PIC X.
004800     05  WORK-PAID-AMOUNT      PIC S9(6)V99.
004900     05  WORK-PAID-DATE        PIC 9(8).
005000     05  WORK-CHECK-NO         PIC 9(6).
005100
005200 SD  SORT-FILE.
005300
005400 01  SORT-RECORD.
005500     05  SORT-NUMBER           PIC 9(5).
005600     05  SORT-VENDOR           PIC 9(5).
005700     05  SORT-INVOICE          PIC X(15).
005800     05  SORT-FOR              PIC X(30).
005900     05  SORT-AMOUNT           PIC S9(6)V99.
006000     05  SORT-DATE             PIC 9(8).
006100     05  SORT-DUE              PIC 9(8).
006200     05  SORT-DEDUCTIBLE       PIC X.
006300     05  SORT-SELECTED         PIC X.
006400     05  SORT-PAID-AMOUNT      PIC S9(6)V99.
006500     05  SORT-PAID-DATE        PIC 9(8).
006600     05  SORT-CHECK-NO         PIC 9(6).
006700
006800 FD  PRINTER-FILE
006900     LABEL RECORDS ARE OMITTED.
007000 01  PRINTER-RECORD             PIC X(80).
007100
007200 WORKING-STORAGE SECTION.
007300
007400 77  OK-TO-PROCESS         PIC X.
007500
007600     COPY "WSCASE01.CBL".
007700
007800 01  DETAIL-LINE.
007900     05  PRINT-NUMBER      PIC ZZZZ9.
008000     05  FILLER            PIC X(3) VALUE SPACE.
008100     05  PRINT-NAME        PIC X(30).
008200     05  FILLER            PIC X(1) VALUE SPACE.
008300     05  PRINT-DUE-DATE   PIC Z9/99/9999.
008400     05  FILLER            PIC X(1) VALUE SPACE.
008500     05  PRINT-AMOUNT      PIC ZZZ,ZZ9.99.
008600     05  FILLER            PIC X(1) VALUE SPACE.
008700     05  PRINT-INVOICE     PIC X(15).
008800     05  FILLER            PIC X(1) VALUE SPACE.
008900     05  PRINT-SELECTED    PIC X(1) VALUE SPACE.
009000
009100 01  TOTAL-THRU.
009200     05  FILLER            PIC X(20) VALUE SPACE.
009300     05  FILLER            PIC X(10) VALUE "TOTAL THRU".
009400
009500 01  COLUMN-LINE.
009600     05  FILLER         PIC X(7)  VALUE "VOUCHER".
009700     05  FILLER         PIC X(1)  VALUE SPACE.
009800     05  FILLER         PIC X(10) VALUE "VENDOR/For".
009900     05  FILLER         PIC X(23) VALUE SPACE.
010000     05  FILLER         PIC X(8)  VALUE "DUE DATE".
010100     05  FILLER         PIC X(1)  VALUE SPACE.
010200     05  FILLER         PIC X(10) VALUE "AMOUNT DUE".
010300     05  FILLER         PIC X(1)  VALUE SPACE.
010400     05  FILLER         PIC X(7)  VALUE "INVOICE".
010500     05  FILLER         PIC X(9)  VALUE SPACE.
010600     05  FILLER         PIC X(1)  VALUE "S".
010700
010800 01  TITLE-LINE.
010900     05  FILLER              PIC X(30) VALUE SPACE.
011000     05  FILLER              PIC X(12)
011100         VALUE "BILLS REPORT".
011200     05  FILLER              PIC X(19) VALUE SPACE.
011300     05  FILLER              PIC X(5) VALUE "PAGE:".
011400     05  FILLER              PIC X(1) VALUE SPACE.
011500     05  PRINT-PAGE-NUMBER   PIC ZZZ9.
011600
011700 77  WORK-FILE-AT-END     PIC X.
011800 77  VENDOR-RECORD-FOUND     PIC X.
011900
012000 77  LINE-COUNT              PIC 999 VALUE ZERO.
012100 77  PAGE-NUMBER             PIC 9999 VALUE ZERO.
012200 77  MAXIMUM-LINES           PIC 999 VALUE 55.
012300
012400 77  RECORD-COUNT            PIC 9999 VALUE ZEROES.
012500
012600 77  SAVE-DUE                PIC 9(8).
012700
012800 77  RUNNING-TOTAL           PIC S9(6)V99.
012900
013000     COPY "WSDATE01.CBL".
013100
013200 PROCEDURE DIVISION.
013300 PROGRAM-BEGIN.
013400
013500     PERFORM OPENING-PROCEDURE.
013600     PERFORM MAIN-PROCESS.
013700     PERFORM CLOSING-PROCEDURE.
013800
013900 PROGRAM-EXIT.
014000     EXIT PROGRAM.
014100
014200 PROGRAM-DONE.
014300     STOP RUN.
014400
014500 OPENING-PROCEDURE.
014600     OPEN I-O VENDOR-FILE.
014700
014800     OPEN OUTPUT PRINTER-FILE.
014900
015000 MAIN-PROCESS.
015100     PERFORM GET-OK-TO-PROCESS.
015200     IF OK-TO-PROCESS = "Y"
015300         PERFORM SORT-DATA-FILE
015400         PERFORM PRINT-THE-REPORT.
015500
015600 CLOSING-PROCEDURE.
015700     CLOSE VENDOR-FILE.
015800     PERFORM END-LAST-PAGE.
015900     CLOSE PRINTER-FILE.
016000
016100 GET-OK-TO-PROCESS.
016200     PERFORM ACCEPT-OK-TO-PROCESS.
016300     PERFORM RE-ACCEPT-OK-TO-PROCESS
016400         UNTIL OK-TO-PROCESS = "Y" OR "N".
016500
016600 ACCEPT-OK-TO-PROCESS.
016700     DISPLAY "PRINT BILLS REPORT (Y/N)?".
016800     ACCEPT OK-TO-PROCESS.
016900     INSPECT OK-TO-PROCESS
017000       CONVERTING LOWER-ALPHA
017100       TO         UPPER-ALPHA.
017200
017300 RE-ACCEPT-OK-TO-PROCESS.
017400     DISPLAY "YOU MUST ENTER YES OR NO".
017500     PERFORM ACCEPT-OK-TO-PROCESS.
017600
017700*---------------------------------
017800* Sorting logic
017900*---------------------------------
018000 SORT-DATA-FILE.
018100     SORT SORT-FILE
018200         ON ASCENDING KEY SORT-DUE
018300          USING VOUCHER-FILE
018400          GIVING WORK-FILE.
018500
018600 PRINT-THE-REPORT.
018700     OPEN INPUT WORK-FILE.
018800     PERFORM START-ONE-REPORT.
018900     PERFORM PROCESS-VOUCHERS.
019000     PERFORM END-ONE-REPORT.
019100     CLOSE WORK-FILE.
019200
019300 START-ONE-REPORT.
019400     PERFORM INITIALIZE-REPORT.
019500     PERFORM START-NEW-PAGE.
019600     MOVE ZEROES TO RUNNING-TOTAL.
019700
019800 INITIALIZE-REPORT.
019900     MOVE ZEROES TO LINE-COUNT PAGE-NUMBER.
020000
020100 END-ONE-REPORT.
020200     IF RECORD-COUNT = ZEROES
020300         MOVE "NO RECORDS FOUND" TO PRINTER-RECORD
020400         PERFORM WRITE-TO-PRINTER.
020500
020600 PROCESS-VOUCHERS.
020700     PERFORM READ-FIRST-VALID-WORK.
020800     PERFORM PROCESS-ALL-DATES
020900         UNTIL WORK-FILE-AT-END = "Y".
021000
021100 PROCESS-ALL-DATES.
021200     PERFORM START-ONE-DATE.
021300
021400     PERFORM PROCESS-ALL-VOUCHERS
021500         UNTIL WORK-FILE-AT-END = "Y"
021600            OR WORK-DUE NOT = SAVE-DUE.
021700
021800     PERFORM END-ONE-DATE.
021900
022000 START-ONE-DATE.
022100     MOVE WORK-DUE TO SAVE-DUE.
022200
022300 END-ONE-DATE.
022400     PERFORM PRINT-RUNNING-TOTAL.
022500
022600 PRINT-RUNNING-TOTAL.
022700     MOVE SPACE TO DETAIL-LINE.
022800     MOVE SAVE-DUE TO DATE-CCYYMMDD.
022900     PERFORM CONVERT-TO-MMDDCCYY.
023000     MOVE DATE-MMDDCCYY TO PRINT-DUE-DATE.
023100     MOVE RUNNING-TOTAL TO PRINT-AMOUNT.
023200     MOVE TOTAL-THRU TO PRINT-NAME.
023300     MOVE DETAIL-LINE TO PRINTER-RECORD.
023400     PERFORM WRITE-TO-PRINTER.
023500     PERFORM LINE-FEED 2 TIMES.
023600
023700 PROCESS-ALL-VOUCHERS.
023800     PERFORM PROCESS-THIS-VOUCHER.
023900     PERFORM READ-NEXT-VALID-WORK.
024000
024100 PROCESS-THIS-VOUCHER.
024200     ADD 1 TO RECORD-COUNT.
024300     IF LINE-COUNT > MAXIMUM-LINES
024400         PERFORM START-NEXT-PAGE.
024500     PERFORM PRINT-THE-RECORD.
024600     ADD WORK-AMOUNT TO RUNNING-TOTAL.
024700
024800 PRINT-THE-RECORD.
024900     PERFORM PRINT-LINE-1.
025000     PERFORM PRINT-LINE-2.
025100     PERFORM LINE-FEED.
025200
025300 PRINT-LINE-1.
025400     MOVE SPACE TO DETAIL-LINE.
025500     MOVE WORK-NUMBER TO PRINT-NUMBER.
025600
025700     MOVE WORK-VENDOR TO VENDOR-NUMBER.
025800     PERFORM READ-VENDOR-RECORD.
025900     IF VENDOR-RECORD-FOUND = "Y"
026000         MOVE VENDOR-NAME TO PRINT-NAME
026100     ELSE
026200         MOVE "*VENDOR NOT ON FILE*" TO PRINT-NAME.
026300
026400     MOVE WORK-DUE TO DATE-CCYYMMDD.
026500     PERFORM CONVERT-TO-MMDDCCYY.
026600     MOVE DATE-MMDDCCYY TO PRINT-DUE-DATE.
026700
026800     MOVE WORK-AMOUNT TO PRINT-AMOUNT.
026900     MOVE WORK-INVOICE TO PRINT-INVOICE.
027000
027100     IF WORK-SELECTED = "Y"
027200         MOVE WORK-SELECTED TO PRINT-SELECTED
027300     ELSE
027400         MOVE SPACE TO PRINT-SELECTED.
027500
027600     MOVE DETAIL-LINE TO PRINTER-RECORD.
027700     PERFORM WRITE-TO-PRINTER.
027800
027900 PRINT-LINE-2.
028000     MOVE SPACE TO DETAIL-LINE.
028100     MOVE WORK-FOR TO PRINT-NAME.
028200     MOVE DETAIL-LINE TO PRINTER-RECORD.
028300     PERFORM WRITE-TO-PRINTER.
028400
028500 WRITE-TO-PRINTER.
028600     WRITE PRINTER-RECORD BEFORE ADVANCING 1.
028700     ADD 1 TO LINE-COUNT.
028800
028900 LINE-FEED.
029000     MOVE SPACE TO PRINTER-RECORD.
029100     PERFORM WRITE-TO-PRINTER.
029200
029300 START-NEXT-PAGE.
029400     PERFORM END-LAST-PAGE.
029500     PERFORM START-NEW-PAGE.
029600
029700 START-NEW-PAGE.
029800     ADD 1 TO PAGE-NUMBER.
029900     MOVE PAGE-NUMBER TO PRINT-PAGE-NUMBER.
030000     MOVE TITLE-LINE TO PRINTER-RECORD.
030100     PERFORM WRITE-TO-PRINTER.
030200     PERFORM LINE-FEED.
030300     MOVE COLUMN-LINE TO PRINTER-RECORD.
030400     PERFORM WRITE-TO-PRINTER.
030500     PERFORM LINE-FEED.
030600
030700 END-LAST-PAGE.
030800     PERFORM FORM-FEED.
030900     MOVE ZERO TO LINE-COUNT.
031000
031100 FORM-FEED.
031200     MOVE SPACE TO PRINTER-RECORD.
031300     WRITE PRINTER-RECORD BEFORE ADVANCING PAGE.
031400
031500*---------------------------------
031600* Read first, read next routines
031700*---------------------------------
031800 READ-FIRST-VALID-WORK.
031900     PERFORM READ-NEXT-VALID-WORK.
032000
032100 READ-NEXT-VALID-WORK.
032200     PERFORM READ-NEXT-WORK-RECORD.
032300     PERFORM READ-NEXT-WORK-RECORD
032400         UNTIL WORK-FILE-AT-END = "Y"
032500            OR WORK-PAID-DATE = ZEROES.
032600
032700 READ-NEXT-WORK-RECORD.
032800     MOVE "N" TO WORK-FILE-AT-END.
032900     READ WORK-FILE NEXT RECORD
033000         AT END MOVE "Y" TO WORK-FILE-AT-END.
033100
033200*---------------------------------
033300* Other File IO routines
033400*---------------------------------
033500 READ-VENDOR-RECORD.
033600     MOVE "Y" TO VENDOR-RECORD-FOUND.
033700     READ VENDOR-FILE RECORD
033800         INVALID KEY
033900         MOVE "N" TO VENDOR-RECORD-FOUND.
034000
034100*---------------------------------
034200* Utility Routines
034300*---------------------------------
034400     COPY "PLDATE01.CBL".
034500
