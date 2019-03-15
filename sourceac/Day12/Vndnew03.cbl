000100 IDENTIFICATION DIVISION.
000200 PROGRAM-ID. VNDNEW03.
000300*------------------------------------------------
000400* Add a record to an indexed Vendor File.
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
001900 01  VENDOR-NUMBER-FIELD                  PIC Z(5).
002000
002100 PROCEDURE DIVISION.
002200 PROGRAM-BEGIN.
002300     OPEN I-O VENDOR-FILE.
002400     PERFORM GET-NEW-VENDOR-NUMBER.
002500     PERFORM ADD-RECORDS
002600        UNTIL VENDOR-NUMBER = ZEROES.
002700     CLOSE VENDOR-FILE.
002800
002900 PROGRAM-DONE.
003000     ACCEPT OMITTED. STOP RUN.
003100
003200 GET-NEW-VENDOR-NUMBER.
003300     PERFORM INIT-VENDOR-RECORD.
003400     PERFORM ENTER-VENDOR-NUMBER.
003500
003600 INIT-VENDOR-RECORD.
003700     MOVE SPACE TO VENDOR-RECORD.
003800     MOVE ZEROES TO VENDOR-NUMBER.
003900
004000 ENTER-VENDOR-NUMBER.
004100     DISPLAY "ENTER VENDOR NUMBER (1-99999)".
004200     DISPLAY "ENTER 0 TO STOP ENTRY".
004300     ACCEPT VENDOR-NUMBER-FIELD.
004400*OR  ACCEPT VENDOR-NUMBER-FIELD WITH CONVERSION.
004500
004600     MOVE VENDOR-NUMBER-FIELD TO VENDOR-NUMBER.
004700*OR  MOVE WITH CONVERSION VENDOR-NUMBER-FIELD
004800*       TO VENDOR-NUMBER.
004900
005000 ADD-RECORDS.
005100     PERFORM ENTER-REMAINING-FIELDS.
005200     PERFORM WRITE-VENDOR-RECORD.
005300     PERFORM GET-NEW-VENDOR-NUMBER.
005400
005500 WRITE-VENDOR-RECORD.
005600     WRITE VENDOR-RECORD
005700         INVALID KEY
005800         DISPLAY "RECORD ALREADY ON FILE".
005900
006000 ENTER-REMAINING-FIELDS.
006100     PERFORM ENTER-VENDOR-NAME.
006200     PERFORM ENTER-VENDOR-ADDRESS-1.
006300     PERFORM ENTER-VENDOR-ADDRESS-2.
006400     PERFORM ENTER-VENDOR-CITY.
006500     PERFORM ENTER-VENDOR-STATE.
006600     PERFORM ENTER-VENDOR-ZIP.
006700     PERFORM ENTER-VENDOR-CONTACT.
006800     PERFORM ENTER-VENDOR-PHONE.
006900
007000 ENTER-VENDOR-NAME.
007100     DISPLAY "ENTER VENDOR NAME".
007200     ACCEPT VENDOR-NAME.
007300
007400 ENTER-VENDOR-ADDRESS-1.
007500     DISPLAY "ENTER VENDOR ADDRESS-1".
007600     ACCEPT VENDOR-ADDRESS-1.
007700
007800 ENTER-VENDOR-ADDRESS-2.
007900     DISPLAY "ENTER VENDOR ADDRESS-2".
008000     ACCEPT VENDOR-ADDRESS-2.
008100
008200 ENTER-VENDOR-CITY.
008300     DISPLAY "ENTER VENDOR CITY".
008400     ACCEPT VENDOR-CITY.
008500
008600 ENTER-VENDOR-STATE.
008700     DISPLAY "ENTER VENDOR STATE".
008800     ACCEPT VENDOR-STATE.
008900
009000 ENTER-VENDOR-ZIP.
009100     DISPLAY "ENTER VENDOR ZIP".
009200     ACCEPT VENDOR-ZIP.
009300
009400 ENTER-VENDOR-CONTACT.
009500     DISPLAY "ENTER VENDOR CONTACT".
009600     ACCEPT VENDOR-CONTACT.
009700
009800 ENTER-VENDOR-PHONE.
009900     DISPLAY "ENTER VENDOR PHONE".
010000     ACCEPT VENDOR-PHONE.
010100
