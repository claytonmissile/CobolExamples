000100 IDENTIFICATION DIVISION.
000200 PROGRAM-ID. SLSSUM01.
000300*---------------------------------
000400* Generate test sales data
000500*---------------------------------
000600 ENVIRONMENT DIVISION.
000700 INPUT-OUTPUT SECTION.
000800 FILE-CONTROL.
000900
001000*---------------------------------
001100* SLSALES.CBL
001200*---------------------------------
001300     SELECT SALES-FILE
001400         ASSIGN TO "SALES"
001500         ORGANIZATION IS SEQUENTIAL.
001600
001700     SELECT WORK-FILE
001800         ASSIGN TO "WORK"
001900         ORGANIZATION IS SEQUENTIAL.
002000
002100     SELECT SORT-FILE
002200         ASSIGN TO "SORT".
002300
002400     SELECT PRINTER-FILE
002500         ASSIGN TO PRINTER
002600         ORGANIZATION IS LINE SEQUENTIAL.
002700
002800 DATA DIVISION.
002900 FILE SECTION.
003000
003100*---------------------------------
003200* FDSALES.CBL
003300* Temporary daily sales file.
003400*---------------------------------
003500 FD  SALES-FILE
003600     LABEL RECORDS ARE STANDARD.
003700 01  SALES-RECORD.
003800     05  SALES-STORE              PIC 9(2).
003900     05  SALES-DIVISION           PIC 9(2).
004000     05  SALES-DEPARTMENT         PIC 9(2).
004100     05  SALES-CATEGORY           PIC 9(2).
004200     05  SALES-AMOUNT             PIC S9(6)V99.
004300
004400 FD  WORK-FILE
004500     LABEL RECORDS ARE STANDARD.
004600 01  WORK-RECORD.
004700     05  WORK-STORE              PIC 9(2).
004800     05  WORK-DIVISION           PIC 9(2).
004900     05  WORK-DEPARTMENT         PIC 9(2).
005000     05  WORK-CATEGORY           PIC 9(2).
005100     05  WORK-AMOUNT             PIC S9(6)V99.
005200
005300 SD  SORT-FILE.
005400    
005500 01  SORT-RECORD.
005600     05  SORT-STORE              PIC 9(2).
005700     05  SORT-DIVISION           PIC 9(2).
005800     05  SORT-DEPARTMENT         PIC 9(2).
005900     05  SORT-CATEGORY           PIC 9(2).
006000     05  SORT-AMOUNT             PIC S9(6)V99.
006100
006200 FD  PRINTER-FILE
006300     LABEL RECORDS ARE OMITTED.
006400 01  PRINTER-RECORD              PIC X(80).
006500
006600 WORKING-STORAGE SECTION.
006700
006800 77  OK-TO-PROCESS         PIC X.
006900
007000     COPY "WSCASE01.CBL".
007100
007200 01  LEGEND-LINE.
007300     05  FILLER            PIC X(6) VALUE "STORE:".
007400     05  FILLER            PIC X(1) VALUE SPACE.
007500     05  PRINT-STORE       PIC Z9.
007600
007700*01  DETAIL-LINE.
007800*    05  FILLER            PIC X(3) VALUE SPACE.
007900*    05  PRINT-DIVISION    PIC Z9.
008000*    05  FILLER            PIC X(4) VALUE SPACE.
008100*    05  FILLER            PIC X(3) VALUE SPACE.
008200*    05  PRINT-DEPARTMENT  PIC Z9.
008300*    05  FILLER            PIC X(6) VALUE SPACE.
008400*    05  FILLER            PIC X(3) VALUE SPACE.
008500*    05  PRINT-CATEGORY    PIC Z9.
008600*    05  FILLER            PIC X(4) VALUE SPACE.
008700*    05  PRINT-AMOUNT      PIC ZZZ,ZZ9.99-.
008800
008900*01  COLUMN-LINE.
009000*    05  FILLER         PIC X(8)  VALUE "DIVISION".
009100*    05  FILLER         PIC X(1)  VALUE SPACE.
009200*    05  FILLER         PIC X(10) VALUE "DEPARTMENT".
009300*    05  FILLER         PIC X(1)  VALUE SPACE.
009400*    05  FILLER         PIC X(8)  VALUE "CATEGORY".
009500*    05  FILLER         PIC X(1)  VALUE SPACE.
009600*    05  FILLER         PIC X(4)  VALUE SPACE.
009700*    05  FILLER         PIC X(6)  VALUE "AMOUNT".
009800
009900 01  TITLE-LINE.
010000     05  FILLER              PIC X(30) VALUE SPACE.
010100     05  FILLER              PIC X(13)
010200         VALUE "SALES SUMMARY".
010300     05  FILLER              PIC X(15) VALUE SPACE.
010400     05  FILLER              PIC X(5) VALUE "PAGE:".
010500     05  FILLER              PIC X(1) VALUE SPACE.
010600     05  PRINT-PAGE-NUMBER   PIC ZZZ9.
010700
010800 01  TOTAL-LINE.
010900     05  FILLER              PIC X(11) VALUE SPACE.
011000     05  TOTAL-TYPE          PIC X(8).
011100     05  FILLER              PIC X(1) VALUE SPACE.
011200     05  TOTAL-NUMBER        PIC Z9.
011300     05  FILLER              PIC X(1) VALUE SPACE.
011400     05  TOTAL-LITERAL       PIC X(5) VALUE "TOTAL".
011500     05  FILLER              PIC X(1) VALUE SPACE.
011600     05  PRINT-TOTAL         PIC ZZZ,ZZ9.99-.
011700
011800 77  GRAND-TOTAL-LITERAL      PIC X(8) VALUE "   GRAND".
011900 77  STORE-TOTAL-LITERAL      PIC X(8) VALUE "   STORE".
012000 77  DIVISION-TOTAL-LITERAL   PIC X(8) VALUE "DIVISION".
012100 77  DEPARTMENT-TOTAL-LITERAL PIC X(8) VALUE "    DEPT".
012200
012300 77  WORK-FILE-AT-END        PIC X.
012400
012500 77  LINE-COUNT              PIC 999 VALUE ZERO.
012600 77  PAGE-NUMBER             PIC 9999 VALUE ZERO.
012700 77  MAXIMUM-LINES           PIC 999 VALUE 55.
012800
012900 77  RECORD-COUNT            PIC 9999 VALUE ZEROES.
013000
013100* Control break current values for store, division
013200* department.
013300 77  CURRENT-STORE          PIC 99.
013400 77  CURRENT-DIVISION       PIC 99.
013500 77  CURRENT-DEPARTMENT     PIC 99.
013600
013700* Control break accumulators
013800* GRAND TOTAL is the level 1 accumulator for the whole file
013900* STORE TOTAL is the level 2 accumulator
014000* DIVISION TOTAL is the level 3 accumulator
014100* DEPARTMENT TOTAL is the level 4 accumulator.
014200 77  GRAND-TOTAL            PIC S9(6)V99.
014300 77  STORE-TOTAL            PIC S9(6)V99.
014400 77  DIVISION-TOTAL         PIC S9(6)V99.
014500 77  DEPARTMENT-TOTAL       PIC S9(6)V99.
014600
014700 PROCEDURE DIVISION.
014800 PROGRAM-BEGIN.
014900
015000     PERFORM OPENING-PROCEDURE.
015100     PERFORM MAIN-PROCESS.
015200     PERFORM CLOSING-PROCEDURE.
015300
015400 PROGRAM-EXIT.
015500     EXIT PROGRAM.
015600
015700 PROGRAM-DONE.
015800     ACCEPT OMITTED. STOP RUN.
015900
016000 OPENING-PROCEDURE.
016100
016200     OPEN OUTPUT PRINTER-FILE.
016300
016400 MAIN-PROCESS.
016500     PERFORM GET-OK-TO-PROCESS.
016600     PERFORM PROCESS-THE-FILE
016700         UNTIL OK-TO-PROCESS = "N".
016800
016900 CLOSING-PROCEDURE.
017000     CLOSE PRINTER-FILE.
017100
017200 GET-OK-TO-PROCESS.
017300     PERFORM ACCEPT-OK-TO-PROCESS.
017400     PERFORM RE-ACCEPT-OK-TO-PROCESS
017500         UNTIL OK-TO-PROCESS = "Y" OR "N".
017600
017700 ACCEPT-OK-TO-PROCESS.
017800     DISPLAY "PRINT SALES SUMMARY (Y/N)?".
017900     ACCEPT OK-TO-PROCESS.
018000     INSPECT OK-TO-PROCESS
018100       CONVERTING LOWER-ALPHA
018200       TO         UPPER-ALPHA.
018300
018400 RE-ACCEPT-OK-TO-PROCESS.
018500     DISPLAY "YOU MUST ENTER YES OR NO".
018600     PERFORM ACCEPT-OK-TO-PROCESS.
018700
018800 PROCESS-THE-FILE.
018900     PERFORM START-THE-FILE.
019000     PERFORM PRINT-ONE-REPORT.
019100     PERFORM END-THE-FILE.
019200
019300*    PERFORM GET-OK-TO-PROCESS.
019400     MOVE "N" TO OK-TO-PROCESS.
019500
019600 START-THE-FILE.
019700     PERFORM SORT-DATA-FILE.
019800     OPEN INPUT WORK-FILE.
019900
020000 END-THE-FILE.
020100     CLOSE WORK-FILE.
020200
020300 SORT-DATA-FILE.
020400     SORT SORT-FILE
020500         ON ASCENDING KEY SORT-STORE
020600            ASCENDING KEY SORT-DIVISION
020700            ASCENDING KEY SORT-DEPARTMENT
020800            ASCENDING KEY SORT-CATEGORY
020900          USING SALES-FILE
021000          GIVING WORK-FILE.
021100
021200* LEVEL 1 CONTROL BREAK
021300 PRINT-ONE-REPORT.
021400     PERFORM START-ONE-REPORT.
021500     PERFORM PROCESS-ALL-STORES
021600         UNTIL WORK-FILE-AT-END = "Y".
021700     PERFORM END-ONE-REPORT.
021800
021900 START-ONE-REPORT.
022000     PERFORM READ-FIRST-VALID-WORK.
022100     MOVE ZEROES TO GRAND-TOTAL.
022200
022300     PERFORM START-NEW-REPORT.
022400
022500 START-NEW-REPORT.
022600*    MOVE SPACE TO DETAIL-LINE.
022700     MOVE ZEROES TO LINE-COUNT PAGE-NUMBER.
022800
022900 END-ONE-REPORT.
023000     IF RECORD-COUNT = ZEROES
023100         MOVE "NO RECORDS FOUND" TO PRINTER-RECORD
023200         PERFORM WRITE-TO-PRINTER
023300     ELSE
023400         PERFORM PRINT-GRAND-TOTAL.
023500
023600     PERFORM END-LAST-PAGE.
023700
023800 PRINT-GRAND-TOTAL.
023900     MOVE SPACE TO TOTAL-LINE.
024000     MOVE GRAND-TOTAL TO PRINT-TOTAL.
024100     MOVE GRAND-TOTAL-LITERAL TO TOTAL-TYPE.
024200     MOVE "TOTAL" TO TOTAL-LITERAL.
024300     MOVE TOTAL-LINE TO PRINTER-RECORD.
024400     PERFORM WRITE-TO-PRINTER.
024500     PERFORM LINE-FEED 2 TIMES.
024600*    MOVE SPACE TO DETAIL-LINE.
024700
024800* LEVEL 2 CONTROL BREAK
024900 PROCESS-ALL-STORES.
025000     PERFORM START-ONE-STORE.
025100
025200     PERFORM PROCESS-ALL-DIVISIONS
025300         UNTIL WORK-FILE-AT-END = "Y"
025400            OR WORK-STORE NOT = CURRENT-STORE.
025500
025600     PERFORM END-ONE-STORE.
025700
025800 START-ONE-STORE.
025900     MOVE WORK-STORE TO CURRENT-STORE.
026000     MOVE ZEROES TO STORE-TOTAL.
026100     MOVE WORK-STORE TO PRINT-STORE.
026200
026300     PERFORM START-NEXT-PAGE.
026400
026500 END-ONE-STORE.
026600     PERFORM PRINT-STORE-TOTAL.
026700     ADD STORE-TOTAL TO GRAND-TOTAL.
026800
026900 PRINT-STORE-TOTAL.
027000     MOVE SPACE TO TOTAL-LINE.
027100     MOVE STORE-TOTAL TO PRINT-TOTAL.
027200     MOVE CURRENT-STORE TO TOTAL-NUMBER.
027300     MOVE STORE-TOTAL-LITERAL TO TOTAL-TYPE.
027400     MOVE "TOTAL" TO TOTAL-LITERAL.
027500     MOVE TOTAL-LINE TO PRINTER-RECORD.
027600     PERFORM WRITE-TO-PRINTER.
027700     PERFORM LINE-FEED.
027800*    MOVE SPACE TO DETAIL-LINE.
027900
028000* LEVEL 3 CONTROL BREAK
028100 PROCESS-ALL-DIVISIONS.
028200     PERFORM START-ONE-DIVISION.
028300
028400     PERFORM PROCESS-ALL-DEPARTMENTS
028500         UNTIL WORK-FILE-AT-END = "Y"
028600            OR WORK-STORE NOT = CURRENT-STORE
028700            OR WORK-DIVISION NOT = CURRENT-DIVISION.
028800
028900     PERFORM END-ONE-DIVISION.
029000
029100 START-ONE-DIVISION.
029200     MOVE WORK-DIVISION TO CURRENT-DIVISION.
029300     MOVE ZEROES TO DIVISION-TOTAL.
029400*    MOVE WORK-DIVISION TO PRINT-DIVISION.
029500
029600 END-ONE-DIVISION.
029700     PERFORM PRINT-DIVISION-TOTAL.
029800     ADD DIVISION-TOTAL TO STORE-TOTAL.
029900
030000 PRINT-DIVISION-TOTAL.
030100     MOVE SPACE TO TOTAL-LINE.
030200     MOVE DIVISION-TOTAL TO PRINT-TOTAL.
030300     MOVE CURRENT-DIVISION TO TOTAL-NUMBER.
030400     MOVE DIVISION-TOTAL-LITERAL TO TOTAL-TYPE.
030500     MOVE "TOTAL" TO TOTAL-LITERAL.
030600     MOVE TOTAL-LINE TO PRINTER-RECORD.
030700     PERFORM WRITE-TO-PRINTER.
030800     PERFORM LINE-FEED.
030900*    MOVE SPACE TO DETAIL-LINE.
031000
031100* LEVEL 4 CONTROL BREAK
031200 PROCESS-ALL-DEPARTMENTS.
031300     PERFORM START-ONE-DEPARTMENT.
031400
031500     PERFORM PROCESS-ALL-CATEGORIES
031600         UNTIL WORK-FILE-AT-END = "Y"
031700            OR WORK-STORE NOT = CURRENT-STORE
031800            OR WORK-DIVISION NOT = CURRENT-DIVISION
031900            OR WORK-DEPARTMENT NOT = CURRENT-DEPARTMENT.
032000
032100     PERFORM END-ONE-DEPARTMENT.
032200
032300 START-ONE-DEPARTMENT.
032400     MOVE WORK-DEPARTMENT TO CURRENT-DEPARTMENT.
032500     MOVE ZEROES TO DEPARTMENT-TOTAL.
032600*    MOVE WORK-DEPARTMENT TO PRINT-DEPARTMENT.
032700
032800 END-ONE-DEPARTMENT.
032900     PERFORM PRINT-DEPARTMENT-TOTAL.
033000     ADD DEPARTMENT-TOTAL TO DIVISION-TOTAL.
033100
033200 PRINT-DEPARTMENT-TOTAL.
033300     MOVE SPACE TO TOTAL-LINE.
033400     MOVE DEPARTMENT-TOTAL TO PRINT-TOTAL.
033500     MOVE CURRENT-DEPARTMENT TO TOTAL-NUMBER.
033600     MOVE DEPARTMENT-TOTAL-LITERAL TO TOTAL-TYPE.
033700     MOVE "TOTAL" TO TOTAL-LITERAL.
033800     MOVE TOTAL-LINE TO PRINTER-RECORD.
033900     PERFORM WRITE-TO-PRINTER.
034000     PERFORM LINE-FEED.
034100*    MOVE SPACE TO DETAIL-LINE.
034200
034300* PROCESS ONE RECORD LEVEL
034400 PROCESS-ALL-CATEGORIES.
034500     PERFORM PROCESS-THIS-CATEGORY.
034600     ADD WORK-AMOUNT TO DEPARTMENT-TOTAL.
034700     ADD 1 TO RECORD-COUNT.
034800     PERFORM READ-NEXT-VALID-WORK.
034900
035000 PROCESS-THIS-CATEGORY.
035100     IF LINE-COUNT > MAXIMUM-LINES
035200         PERFORM START-NEXT-PAGE.
035300*    PERFORM PRINT-THE-RECORD.
035400
035500*PRINT-THE-RECORD.
035600*    MOVE WORK-CATEGORY TO PRINT-CATEGORY.
035700*
035800*    MOVE WORK-AMOUNT TO PRINT-AMOUNT.
035900*
036000*    MOVE DETAIL-LINE TO PRINTER-RECORD.
036100*    PERFORM WRITE-TO-PRINTER.
036200*    MOVE SPACE TO DETAIL-LINE.
036300
036400* PRINTING ROUTINES
036500 WRITE-TO-PRINTER.
036600     WRITE PRINTER-RECORD BEFORE ADVANCING 1.
036700     ADD 1 TO LINE-COUNT.
036800
036900 LINE-FEED.
037000     MOVE SPACE TO PRINTER-RECORD.
037100     PERFORM WRITE-TO-PRINTER.
037200
037300 START-NEXT-PAGE.
037400     PERFORM END-LAST-PAGE.
037500     PERFORM START-NEW-PAGE.
037600
037700 START-NEW-PAGE.
037800     ADD 1 TO PAGE-NUMBER.
037900     MOVE PAGE-NUMBER TO PRINT-PAGE-NUMBER.
038000     MOVE TITLE-LINE TO PRINTER-RECORD.
038100     PERFORM WRITE-TO-PRINTER.
038200     PERFORM LINE-FEED.
038300     MOVE LEGEND-LINE TO PRINTER-RECORD.
038400     PERFORM WRITE-TO-PRINTER.
038500     PERFORM LINE-FEED.
038600*    MOVE COLUMN-LINE TO PRINTER-RECORD.
038700*    PERFORM WRITE-TO-PRINTER.
038800*    PERFORM LINE-FEED.
038900
039000 END-LAST-PAGE.
039100     IF PAGE-NUMBER > 0
039200         PERFORM FORM-FEED.
039300     MOVE ZERO TO LINE-COUNT.
039400
039500 FORM-FEED.
039600     MOVE SPACE TO PRINTER-RECORD.
039700     WRITE PRINTER-RECORD BEFORE ADVANCING PAGE.
039800
039900*---------------------------------
040000* Read first, read next routines
040100*---------------------------------
040200 READ-FIRST-VALID-WORK.
040300     PERFORM READ-NEXT-VALID-WORK.
040400
040500 READ-NEXT-VALID-WORK.
040600     PERFORM READ-NEXT-WORK-RECORD.
040700
040800 READ-NEXT-WORK-RECORD.
040900     MOVE "N" TO WORK-FILE-AT-END.
041000     READ WORK-FILE NEXT RECORD
041100         AT END MOVE "Y" TO WORK-FILE-AT-END.
041200
