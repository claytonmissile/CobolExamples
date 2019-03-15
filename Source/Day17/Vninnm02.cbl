000100 IDENTIFICATION DIVISION.
000200 PROGRAM-ID. VNINNM02.
000300*---------------------------------
000400* Inquire for the Vendor File
000500* using vendor name.
000600*---------------------------------
000700 ENVIRONMENT DIVISION.
000800 INPUT-OUTPUT SECTION.
000900 FILE-CONTROL.
001000
001100     COPY "SLVND02.CBL".
001200
001300     COPY "SLSTATE.CBL".
001400
001500 DATA DIVISION.
001600 FILE SECTION.
001700
001800     COPY "FDVND04.CBL".
001900
002000     COPY "FDSTATE.CBL".
002100
002200 WORKING-STORAGE SECTION.
002300
002400 77  VENDOR-FILE-AT-END           PIC X.
002500 77  STATE-RECORD-FOUND           PIC X.
002600
002700 77  SEE-NEXT-RECORD             PIC X.
002800
002900 77  VENDOR-NAME-FIELD            PIC X(30).
003000
003100     COPY "WSCASE01.CBL".
003200
003300 PROCEDURE DIVISION.
003400 PROGRAM-BEGIN.
003500     PERFORM OPENING-PROCEDURE.
003600     PERFORM MAIN-PROCESS.
003700     PERFORM CLOSING-PROCEDURE.
003800
003900 PROGRAM-DONE.
004000     STOP RUN.
004100
004200 OPENING-PROCEDURE.
004300     OPEN I-O VENDOR-FILE.
004400     OPEN I-O STATE-FILE.
004500
004600 CLOSING-PROCEDURE.
004700     CLOSE VENDOR-FILE.
004800     CLOSE STATE-FILE.
004900
005000 MAIN-PROCESS.
005100     PERFORM INQUIRE-BY-NAME.
005200*---------------------------------
005300* INQUIRE
005400*---------------------------------
005500 INQUIRE-BY-NAME.
005600     PERFORM GET-EXISTING-RECORD.
005700     PERFORM INQUIRE-RECORDS
005800        UNTIL VENDOR-NAME = SPACES.
005900
006000 INQUIRE-RECORDS.
006100     PERFORM SHOW-THIS-RECORD.
006200     PERFORM SHOW-NEXT-RECORD
006300        UNTIL SEE-NEXT-RECORD = "N" OR
006400              VENDOR-FILE-AT-END = "Y".
006500
006600     PERFORM GET-EXISTING-RECORD.
006700
006800
006900*---------------------------------
007000* Show records one by one
007100*---------------------------------
007200 SHOW-THIS-RECORD.
007300     PERFORM DISPLAY-ALL-FIELDS.
007400     PERFORM GET-SEE-NEXT-RECORD.
007500
007600 SHOW-NEXT-RECORD.
007700     PERFORM READ-NEXT-VENDOR-RECORD.
007800     IF VENDOR-FILE-AT-END NOT = "Y"
007900         PERFORM SHOW-THIS-RECORD.
008000
008100*---------------------------------
008200* Get valid record logic
008300*---------------------------------
008400 GET-EXISTING-RECORD.
008500     PERFORM ACCEPT-EXISTING-KEY.
008600     PERFORM RE-ACCEPT-EXISTING-KEY
008700         UNTIL VENDOR-FILE-AT-END NOT = "Y".
008800
008900 ACCEPT-EXISTING-KEY.
009000     PERFORM INIT-FOR-KEY-ENTRY.
009100     PERFORM ENTER-VENDOR-NAME.
009200     IF VENDOR-NAME NOT = SPACES
009300         PERFORM READ-FIRST-VENDOR-RECORD.
009400
009500 RE-ACCEPT-EXISTING-KEY.
009600     DISPLAY "RECORD NOT FOUND"
009700     PERFORM ACCEPT-EXISTING-KEY.
009800
009900*---------------------------------
010000* Field Entry logic
010100*---------------------------------
010200 ENTER-VENDOR-NAME.
010300     PERFORM ACCEPT-VENDOR-NAME.
010400
010500 ACCEPT-VENDOR-NAME.
010600     DISPLAY "ENTER VENDOR NAME".
010700     ACCEPT VENDOR-NAME.
010800     INSPECT VENDOR-NAME
010900         CONVERTING LOWER-ALPHA
011000         TO         UPPER-ALPHA.
011100
011200 GET-SEE-NEXT-RECORD.
011300     PERFORM ACCEPT-SEE-NEXT-RECORD.
011400     PERFORM RE-ACCEPT-SEE-NEXT-RECORD
011500         UNTIL SEE-NEXT-RECORD = "Y" OR "N".
011600
011700 ACCEPT-SEE-NEXT-RECORD.
011800     DISPLAY "DISPLAY NEXT RECORD (Y/N)?".
011900     ACCEPT SEE-NEXT-RECORD.
012000
012100     IF SEE-NEXT-RECORD = SPACE
012200         MOVE "Y" TO SEE-NEXT-RECORD.
012300
012400     INSPECT SEE-NEXT-RECORD
012500       CONVERTING LOWER-ALPHA
012600       TO         UPPER-ALPHA.
012700
012800 RE-ACCEPT-SEE-NEXT-RECORD.
012900     DISPLAY "MUST ENTER YES OR NO".
013000     PERFORM ACCEPT-SEE-NEXT-RECORD.
013100
013200*---------------------------------
013300* Display logic
013400*---------------------------------
013500 DISPLAY-ALL-FIELDS.
013600     DISPLAY " ".
013700     PERFORM DISPLAY-VENDOR-NUMBER.
013800     PERFORM DISPLAY-VENDOR-NAME.
013900     PERFORM DISPLAY-VENDOR-ADDRESS-1.
014000     PERFORM DISPLAY-VENDOR-ADDRESS-2.
014100     PERFORM DISPLAY-VENDOR-CITY.
014200     PERFORM DISPLAY-VENDOR-STATE.
014300     PERFORM DISPLAY-VENDOR-ZIP.
014400     PERFORM DISPLAY-VENDOR-CONTACT.
014500     PERFORM DISPLAY-VENDOR-PHONE.
014600     DISPLAY " ".
014700
014800 DISPLAY-VENDOR-NUMBER.
014900     DISPLAY "   VENDOR NUMBER: " VENDOR-NUMBER.
015000
015100 DISPLAY-VENDOR-NAME.
015200     DISPLAY "1. VENDOR NAME: " VENDOR-NAME.
015300
015400 DISPLAY-VENDOR-ADDRESS-1.
015500     DISPLAY "2. VENDOR ADDRESS-1: " VENDOR-ADDRESS-1.
015600
015700 DISPLAY-VENDOR-ADDRESS-2.
015800     DISPLAY "3. VENDOR ADDRESS-2: " VENDOR-ADDRESS-2.
015900
016000 DISPLAY-VENDOR-CITY.
016100     DISPLAY "4. VENDOR CITY: " VENDOR-CITY.
016200
016300 DISPLAY-VENDOR-STATE.
016400     MOVE VENDOR-STATE TO STATE-CODE.
016500     PERFORM READ-STATE-RECORD.
016600     IF STATE-RECORD-FOUND = "N"
016700         MOVE "**Not found**" TO STATE-NAME.
016800     DISPLAY "5. VENDOR STATE: "
016900             VENDOR-STATE " "
017000             STATE-NAME.
017100
017200 DISPLAY-VENDOR-ZIP.
017300     DISPLAY "6. VENDOR ZIP: " VENDOR-ZIP.
017400
017500 DISPLAY-VENDOR-CONTACT.
017600     DISPLAY "7. VENDOR CONTACT: " VENDOR-CONTACT.
017700
017800 DISPLAY-VENDOR-PHONE.
017900     DISPLAY "8. VENDOR PHONE: " VENDOR-PHONE.
018000
018100*---------------------------------
018200* File Related Routines
018300*---------------------------------
018400 INIT-FOR-KEY-ENTRY.
018500     MOVE SPACE TO VENDOR-RECORD.
018600     MOVE ZEROES TO VENDOR-NUMBER.
018700     MOVE "N" TO VENDOR-FILE-AT-END.
018800
018900 READ-FIRST-VENDOR-RECORD.
019000     MOVE "N" TO VENDOR-FILE-AT-END.
019100     START VENDOR-FILE
019200        KEY NOT < VENDOR-NAME
019300         INVALID KEY
019400          MOVE "Y" TO VENDOR-FILE-AT-END.
019500
019600     IF VENDOR-FILE-AT-END NOT = "Y"
019700         PERFORM READ-NEXT-VENDOR-RECORD.
019800
019900 READ-NEXT-VENDOR-RECORD.
020000     READ VENDOR-FILE NEXT RECORD
020100       AT END
020200          MOVE "Y" TO VENDOR-FILE-AT-END.
020300
020400 READ-STATE-RECORD.
020500     MOVE "Y" TO STATE-RECORD-FOUND.
020600     READ STATE-FILE RECORD
020700       INVALID KEY
020800          MOVE "N" TO STATE-RECORD-FOUND.
020900
