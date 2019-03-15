000100 IDENTIFICATION DIVISION.
000200 PROGRAM-ID. STCRPT02.
000300*---------------------------------
000400* Report on the STATE File.
000500*---------------------------------
000600 ENVIRONMENT DIVISION.
000700 INPUT-OUTPUT SECTION.
000800 FILE-CONTROL.
000900
001000     COPY "SLSTATE.CBL".
001100
001200     SELECT PRINTER-FILE
001300         ASSIGN TO PRINTER
001400         ORGANIZATION IS LINE SEQUENTIAL.
001500
001600 DATA DIVISION.
001700 FILE SECTION.
001800
001900     COPY "FDSTATE.CBL".
002000
002100 FD  PRINTER-FILE
002200     LABEL RECORDS ARE OMITTED.
002300 01  PRINTER-RECORD             PIC X(80).
002400
002500 WORKING-STORAGE SECTION.
002600
002700 01  DETAIL-LINE.
002800     05  PRINT-CODE        PIC XX.
002900     05  FILLER            PIC XXXX     VALUE SPACE.
003000     05  PRINT-NAME        PIC X(20).
003100
003200 01  COLUMN-LINE.
003300     05  FILLER         PIC X(4)  VALUE "CODE".
003400     05  FILLER         PIC X(2) VALUE SPACE.
003500     05  FILLER         PIC X(4) VALUE "NAME".
003600
003700 01  TITLE-LINE.
003800     05  FILLER              PIC X(25) VALUE SPACE.
003900     05  FILLER              PIC X(11)
004000         VALUE "STATE CODES".
004100     05  FILLER              PIC X(15) VALUE SPACE.
004200     05  FILLER              PIC X(5) VALUE "PAGE:".
004300     05  FILLER              PIC X(1) VALUE SPACE.
004400     05  PRINT-PAGE-NUMBER   PIC ZZZZ9.
004500
004600 77  FILE-AT-END             PIC X.
004700 77  LINE-COUNT              PIC 999 VALUE ZERO.
004800 77  PAGE-NUMBER             PIC 99999 VALUE ZERO.
004900 77  MAXIMUM-LINES           PIC 999 VALUE 55.
005000
005100 PROCEDURE DIVISION.
005200 PROGRAM-BEGIN.
005300
005400     PERFORM OPENING-PROCEDURE.
005500     MOVE ZEROES TO LINE-COUNT
005600                    PAGE-NUMBER.
005700
005800     PERFORM START-NEW-PAGE.
005900
006000     MOVE "N" TO FILE-AT-END.
006100     PERFORM READ-NEXT-RECORD.
006200     IF FILE-AT-END = "Y"
006300         MOVE "NO RECORDS FOUND" TO PRINTER-RECORD
006400         PERFORM WRITE-TO-PRINTER
006500     ELSE
006600         PERFORM PRINT-STATE-FIELDS
006700             UNTIL FILE-AT-END = "Y".
006800
006900     PERFORM CLOSING-PROCEDURE.
007000
007100 PROGRAM-EXIT.
007200     EXIT PROGRAM.
007300
007400 PROGRAM-DONE.
007500     STOP RUN.
007600
007700 OPENING-PROCEDURE.
007800     OPEN I-O STATE-FILE.
007900     OPEN OUTPUT PRINTER-FILE.
008000
008100 CLOSING-PROCEDURE.
008200     CLOSE STATE-FILE.
008300     PERFORM END-LAST-PAGE.
008400     CLOSE PRINTER-FILE.
008500
008600 PRINT-STATE-FIELDS.
008700     IF LINE-COUNT > MAXIMUM-LINES
008800         PERFORM START-NEXT-PAGE.
008900     PERFORM PRINT-THE-RECORD.
009000     PERFORM READ-NEXT-RECORD.
009100
009200 PRINT-THE-RECORD.
009300     MOVE SPACE TO DETAIL-LINE.
009400     MOVE STATE-CODE TO PRINT-CODE.
009500     MOVE STATE-NAME TO PRINT-NAME.
009600     MOVE DETAIL-LINE TO PRINTER-RECORD.
009700     PERFORM WRITE-TO-PRINTER.
009800
009900 READ-NEXT-RECORD.
010000     READ STATE-FILE NEXT RECORD
010100         AT END MOVE "Y" TO FILE-AT-END.
010200
010300 WRITE-TO-PRINTER.
010400     WRITE PRINTER-RECORD BEFORE ADVANCING 1.
010500     ADD 1 TO LINE-COUNT.
010600
010700 LINE-FEED.
010800     MOVE SPACE TO PRINTER-RECORD.
010900     PERFORM WRITE-TO-PRINTER.
011000
011100 START-NEXT-PAGE.
011200
011300     PERFORM END-LAST-PAGE.
011400     PERFORM START-NEW-PAGE.
011500
011600 START-NEW-PAGE.
011700     ADD 1 TO PAGE-NUMBER.
011800     MOVE PAGE-NUMBER TO PRINT-PAGE-NUMBER.
011900     MOVE TITLE-LINE TO PRINTER-RECORD.
012000     PERFORM WRITE-TO-PRINTER.
012100     PERFORM LINE-FEED.
012200     MOVE COLUMN-LINE TO PRINTER-RECORD.
012300     PERFORM WRITE-TO-PRINTER.
012400     PERFORM LINE-FEED.
012500
012600 END-LAST-PAGE.
012700     PERFORM FORM-FEED.
012800     MOVE ZERO TO LINE-COUNT.
012900
013000 FORM-FEED.
013100     MOVE SPACE TO PRINTER-RECORD.
013200     WRITE PRINTER-RECORD BEFORE ADVANCING PAGE.
013300
