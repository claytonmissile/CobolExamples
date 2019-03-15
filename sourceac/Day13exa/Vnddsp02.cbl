000100 IDENTIFICATION DIVISION.
000200 PROGRAM-ID. VNDDSP02.
000300*------------------------------------------------
000400* Display records in the Vendor File.
000500*------------------------------------------------
000600 ENVIRONMENT DIVISION.
000700 INPUT-OUTPUT SECTION.
000800 FILE-CONTROL.
000900
001000     COPY "SLVND01.CBL".
001100
001200 DATA DIVISION.
001300 FILE SECTION.
001400
001500     COPY "FDVND02.CBL".
001600
001700 WORKING-STORAGE SECTION.
001800
001900 01  DETAIL-LINE.
002000     05  DISPLAY-NUMBER      PIC 9(5).
002100     05  FILLER              PIC X     VALUE SPACE.
002200     05  DISPLAY-NAME        PIC X(30).
002300     05  FILLER              PIC X     VALUE SPACE.
002400     05  DISPLAY-CONTACT     PIC X(30).
002500
002600 01  CITY-STATE-DETAIL.
002700     05  DISPLAY-CITY        PIC X(20).
002800     05  FILLER              PIC X VALUE SPACE.
002900     05  DISPLAY-STATE       PIC X(2).
003000
003100 01  COLUMN-LINE.
003200     05  FILLER         PIC X(2)  VALUE "NO".
003300     05  FILLER         PIC X(4) VALUE SPACE.
003400     05  FILLER         PIC X(12) VALUE "NAME-ADDRESS".
003500     05  FILLER         PIC X(19) VALUE SPACE.
003600     05  FILLER         PIC X(17) VALUE "CONTACT-PHONE-ZIP".
003700
003800 01  TITLE-LINE.
003900     05  FILLER              PIC X(15) VALUE SPACE.
004000     05  FILLER              PIC X(11)
004100         VALUE "VENDOR LIST".
004200     05  FILLER              PIC X(15) VALUE SPACE.
004300     05  FILLER              PIC X(5) VALUE "PAGE:".
004400     05  FILLER              PIC X(1) VALUE SPACE.
004500     05  DISPLAY-PAGE-NUMBER PIC ZZZZ9.
004600
004700 77  FILE-AT-END             PIC X.
004800 77  A-DUMMY                 PIC X.
004900 77  LINE-COUNT              PIC 999 VALUE ZERO.
005000 77  PAGE-NUMBER             PIC 99999 VALUE ZERO.
005100 77  MAXIMUM-LINES           PIC 999 VALUE 15.
005200
005300 77  DISPLAY-RECORD          PIC X(79).
005400
005500 PROCEDURE DIVISION.
005600 PROGRAM-BEGIN.
005700
005800     PERFORM OPENING-PROCEDURE.
005900     MOVE ZEROES TO LINE-COUNT
006000                    PAGE-NUMBER.
006100
006200     PERFORM START-NEW-PAGE.
006300
006400     MOVE "N" TO FILE-AT-END.
006500     PERFORM READ-NEXT-RECORD.
006600     IF FILE-AT-END = "Y"
006700         MOVE "NO RECORDS FOUND" TO DISPLAY-RECORD
006800         PERFORM WRITE-DISPLAY-RECORD
006900     ELSE
007000         PERFORM DISPLAY-VENDOR-FIELDS
007100             UNTIL FILE-AT-END = "Y".
007200
007300     PERFORM CLOSING-PROCEDURE.
007400
007500
007600 PROGRAM-DONE.
007700     ACCEPT OMITTED. STOP RUN.
007800
007900 OPENING-PROCEDURE.
008000     OPEN I-O VENDOR-FILE.
008100
008200 CLOSING-PROCEDURE.
008300     CLOSE VENDOR-FILE.
008400
008500 DISPLAY-VENDOR-FIELDS.
008600     IF LINE-COUNT > MAXIMUM-LINES
008700         PERFORM START-NEXT-PAGE.
008800     PERFORM DISPLAY-THE-RECORD.
008900     PERFORM READ-NEXT-RECORD.
009000
009100 DISPLAY-THE-RECORD.
009200     PERFORM DISPLAY-LINE-1.
009300     PERFORM DISPLAY-LINE-2.
009400     PERFORM DISPLAY-LINE-3.
009500     PERFORM DISPLAY-LINE-4.
009600     PERFORM LINE-FEED.
009700
009800 DISPLAY-LINE-1.
009900     MOVE SPACE TO DETAIL-LINE.
010000     MOVE VENDOR-NUMBER TO DISPLAY-NUMBER.
010100     MOVE VENDOR-NAME TO DISPLAY-NAME.
010200     MOVE VENDOR-CONTACT TO DISPLAY-CONTACT.
010300     MOVE DETAIL-LINE TO DISPLAY-RECORD.
010400     PERFORM WRITE-DISPLAY-RECORD.
010500
010600 DISPLAY-LINE-2.
010700     MOVE SPACE TO DETAIL-LINE.
010800     MOVE VENDOR-ADDRESS-1 TO DISPLAY-NAME.
010900     MOVE VENDOR-PHONE TO DISPLAY-CONTACT.
011000     MOVE DETAIL-LINE TO DISPLAY-RECORD.
011100     PERFORM WRITE-DISPLAY-RECORD.
011200
011300 DISPLAY-LINE-3.
011400     MOVE SPACE TO DETAIL-LINE.
011500     MOVE VENDOR-ADDRESS-2 TO DISPLAY-NAME.
011600     IF VENDOR-ADDRESS-2 NOT = SPACE
011700         MOVE DETAIL-LINE TO DISPLAY-RECORD
011800         PERFORM WRITE-DISPLAY-RECORD.
011900
012000 DISPLAY-LINE-4.
012100     MOVE SPACE TO DETAIL-LINE.
012200     MOVE VENDOR-CITY TO DISPLAY-CITY.
012300     MOVE VENDOR-STATE TO DISPLAY-STATE.
012400     MOVE CITY-STATE-DETAIL TO DISPLAY-NAME.
012500     MOVE VENDOR-ZIP TO DISPLAY-CONTACT.
012600     MOVE DETAIL-LINE TO DISPLAY-RECORD.
012700     PERFORM WRITE-DISPLAY-RECORD.
012800
012900 READ-NEXT-RECORD.
013000     READ VENDOR-FILE NEXT RECORD
013100         AT END MOVE "Y" TO FILE-AT-END.
013200
013300 WRITE-DISPLAY-RECORD.
013400     DISPLAY DISPLAY-RECORD.
013500     ADD 1 TO LINE-COUNT.
013600
013700 LINE-FEED.
013800     MOVE SPACE TO DISPLAY-RECORD.
013900     PERFORM WRITE-DISPLAY-RECORD.
014000
014100 START-NEXT-PAGE.
014200
014300     PERFORM END-LAST-PAGE.
014400     PERFORM START-NEW-PAGE.
014500
014600 START-NEW-PAGE.
014700     ADD 1 TO PAGE-NUMBER.
014800     MOVE PAGE-NUMBER TO DISPLAY-PAGE-NUMBER.
014900     MOVE TITLE-LINE TO DISPLAY-RECORD.
015000     PERFORM WRITE-DISPLAY-RECORD.
015100     PERFORM LINE-FEED.
015200     MOVE COLUMN-LINE TO DISPLAY-RECORD.
015300     PERFORM WRITE-DISPLAY-RECORD.
015400     PERFORM LINE-FEED.
015500
015600 END-LAST-PAGE.
015700     PERFORM PRESS-ENTER.
015800     MOVE ZERO TO LINE-COUNT.
015900
016000 PRESS-ENTER.
016100     DISPLAY "PRESS ENTER TO CONTINUE. . .".
016200     ACCEPT A-DUMMY.
016300
