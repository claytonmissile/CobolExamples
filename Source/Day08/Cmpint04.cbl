000100 IDENTIFICATION DIVISION.
000200 PROGRAM-ID. CMPINT04.
000300*------------------------------------------------
000400* Calculates compound interest
000500*------------------------------------------------
000600 ENVIRONMENT DIVISION.
000700 DATA DIVISION.
000800 WORKING-STORAGE SECTION.
000900
001000 01  SOME-FLAGS.
001100     05  YES-NO                       PIC X.
001200     05  ENTRY-OK                     PIC X.
001300
001400 01  CALCULATION-FIELDS.
001500     05  THE-INTEREST                 PIC 99V9.
001600     05  INTEREST-AS-DECIMAL          PIC V999.
001700     05  THE-PRINCIPAL                PIC 9(9)V99.
001800     05  WORKING-PRINCIPAL            PIC 9(9)V99.
001900     05  THE-NEW-VALUE                PIC 9(9)V99.
002000     05  EARNED-INTEREST              PIC 9(9)V99.
002100     05  THE-PERIOD                   PIC 9999.
002200     05  NO-OF-PERIODS                PIC 999.
002300
002400 01  ENTRY-FIELD                  PIC ZZZ,ZZZ,ZZZ.ZZ.
002500
002600 01  THE-WHOLE-MESSAGE.
002700     05  DISPLAY-PRINCIPAL        PIC ZZZ,ZZZ,ZZ9.99.
002800     05  MESSAGE-PART-01          PIC X(4) VALUE " at ".
002900     05  DISPLAY-INTEREST         PIC Z9.9.
003000     05  MESSAGE-PART-02          PIC X(6) VALUE "% for ".
003100     05  DISPLAY-PERIODS          PIC ZZ9.
003200     05  MESSAGE-PART-03          PIC X(16)
003300         VALUE " periods yields ".
003400     05  DISPLAY-VALUE            PIC ZZZ,ZZZ,ZZ9.99.
003500
003600 PROCEDURE DIVISION.
003700 PROGRAM-BEGIN.
003800
003900     MOVE "Y" TO YES-NO.
004000     PERFORM GET-AND-DISPLAY-RESULT
004100         UNTIL YES-NO = "N".
004200
004300 PROGRAM-DONE.
004400     STOP RUN.
004500
004600 GET-AND-DISPLAY-RESULT.
004700     PERFORM GET-THE-PRINCIPAL.
004800     PERFORM GET-THE-INTEREST.
004900     PERFORM GET-THE-PERIODS.
005000     PERFORM CALCULATE-THE-RESULT.
005100     PERFORM DISPLAY-THE-RESULT.
005200     PERFORM GO-AGAIN.
005300
005400 GET-THE-PRINCIPAL.
005500     MOVE "N" TO ENTRY-OK.
005600     PERFORM ENTER-THE-PRINCIPAL
005700         UNTIL ENTRY-OK = "Y".
005800
005900 ENTER-THE-PRINCIPAL.
006000     DISPLAY "Principal (.01 TO 999999.99)?".
006100     ACCEPT ENTRY-FIELD WITH CONVERSION.
006200     MOVE ENTRY-FIELD TO THE-PRINCIPAL.
006300     IF THE-PRINCIPAL < .01 OR
006400        THE-PRINCIPAL > 999999.99
006500         DISPLAY "INVALID ENTRY"
006600     ELSE
006700         MOVE "Y" TO ENTRY-OK.
006800
006900 GET-THE-INTEREST.
007000     MOVE "N" TO ENTRY-OK.
007100     PERFORM ENTER-THE-INTEREST
007200         UNTIL ENTRY-OK = "Y".
007300
007400 ENTER-THE-INTEREST.
007500     DISPLAY "Interest (.1% TO 99.9%)?".
007600     ACCEPT ENTRY-FIELD WITH CONVERSION.
007700     MOVE ENTRY-FIELD TO THE-INTEREST.
007800     IF THE-INTEREST < .1 OR
007900        THE-INTEREST > 99.9
008000         DISPLAY "INVALID ENTRY"
008100     ELSE
008200         MOVE "Y" TO ENTRY-OK
008300         COMPUTE INTEREST-AS-DECIMAL =
008400                 THE-INTEREST / 100.
008500
008600 GET-THE-PERIODS.
008700     MOVE "N" TO ENTRY-OK.
008800     PERFORM ENTER-THE-PERIODS
008900         UNTIL ENTRY-OK = "Y".
009000
009100 ENTER-THE-PERIODS.
009200     DISPLAY "Number of periods (1 TO 999)?".
009300     ACCEPT ENTRY-FIELD WITH CONVERSION.
009400     MOVE ENTRY-FIELD TO NO-OF-PERIODS.
009500     IF NO-OF-PERIODS < 1 OR
009600        NO-OF-PERIODS > 999
009700         DISPLAY "INVALID ENTRY"
009800     ELSE
009900         MOVE "Y" TO ENTRY-OK.
010000
010100 CALCULATE-THE-RESULT.
010200     MOVE THE-PRINCIPAL TO WORKING-PRINCIPAL.
010300     PERFORM CALCULATE-ONE-PERIOD
010400         VARYING THE-PERIOD FROM 1 BY 1
010500          UNTIL THE-PERIOD > NO-OF-PERIODS.
010600
010700 CALCULATE-ONE-PERIOD.
010800     COMPUTE EARNED-INTEREST ROUNDED =
010900         WORKING-PRINCIPAL * INTEREST-AS-DECIMAL.
011000     COMPUTE THE-NEW-VALUE =
011100             WORKING-PRINCIPAL + EARNED-INTEREST.
011200     MOVE THE-NEW-VALUE TO WORKING-PRINCIPAL.
011300
011400 GO-AGAIN.
011500     DISPLAY "GO AGAIN?".
011600     ACCEPT YES-NO.
011700     IF YES-NO = "y"
011800         MOVE "Y" TO YES-NO.
011900     IF YES-NO NOT = "Y"
012000         MOVE "N" TO YES-NO.
012100
012200 DISPLAY-THE-RESULT.
012300     MOVE THE-PRINCIPAL TO DISPLAY-PRINCIPAL.
012400     MOVE THE-INTEREST  TO DISPLAY-INTEREST.
012500     MOVE NO-OF-PERIODS TO DISPLAY-PERIODS.
012600     MOVE THE-NEW-VALUE TO DISPLAY-VALUE.
012700     DISPLAY THE-WHOLE-MESSAGE.
012800
