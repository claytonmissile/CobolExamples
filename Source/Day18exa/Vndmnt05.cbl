000100 IDENTIFICATION DIVISION.
000200 PROGRAM-ID. VNDMNT05.
000300*---------------------------------
000400* Add, Change, Inquire and Delete
000500* for the Vendor File.
000600* This includes Inquire by name
000700* The vendor report, and the vendor
000800* report in name order.
000900* Added Display all records.
001000*---------------------------------
001100 ENVIRONMENT DIVISION.
001200 INPUT-OUTPUT SECTION.
001300 FILE-CONTROL.
001400
001500     COPY "SLVND02.CBL".
001600
001700     COPY "SLSTATE.CBL".
001800
001900 DATA DIVISION.
002000 FILE SECTION.
002100
002200     COPY "FDVND04.CBL".
002300
002400     COPY "FDSTATE.CBL".
002500
002600 WORKING-STORAGE SECTION.
002700
002800 77  MENU-PICK                    PIC 9.
002900     88  MENU-PICK-IS-VALID       VALUES 0 THRU 8.
003000
003100 77  THE-MODE                     PIC X(7).
003200 77  WHICH-FIELD                  PIC 9.
003300 77  OK-TO-DELETE                 PIC X.
003400 77  VENDOR-RECORD-FOUND          PIC X.
003500 77  STATE-RECORD-FOUND           PIC X.
003600 77  A-DUMMY                      PIC X.
003700
003800 77  VENDOR-NUMBER-FIELD          PIC Z(5).
003900
004000 77  ERROR-MESSAGE                PIC X(79) VALUE SPACE.
004100
004200     COPY "WSCASE01.CBL".
004300
004400 PROCEDURE DIVISION.
004500 PROGRAM-BEGIN.
004600     PERFORM OPENING-PROCEDURE.
004700     PERFORM MAIN-PROCESS.
004800     PERFORM CLOSING-PROCEDURE.
004900
005000 PROGRAM-EXIT.
005100     EXIT PROGRAM.
005200
005300 PROGRAM-DONE.
005400     STOP RUN.
005500
005600 OPENING-PROCEDURE.
005700     OPEN I-O VENDOR-FILE.
005800     OPEN I-O STATE-FILE.
005900
006000 CLOSING-PROCEDURE.
006100     CLOSE VENDOR-FILE.
006200     CLOSE STATE-FILE.
006300
006400 MAIN-PROCESS.
006500     PERFORM GET-MENU-PICK.
006600     PERFORM MAINTAIN-THE-FILE
006700         UNTIL MENU-PICK = 0.
006800
006900*---------------------------------
007000* MENU
007100*---------------------------------
007200 GET-MENU-PICK.
007300     PERFORM DISPLAY-THE-MENU.
007400     PERFORM ACCEPT-MENU-PICK.
007500     PERFORM RE-ACCEPT-MENU-PICK
007600         UNTIL MENU-PICK-IS-VALID.
007700
007800 DISPLAY-THE-MENU.
007900     PERFORM CLEAR-SCREEN.
008000     DISPLAY "    PLEASE SELECT:".
008100     DISPLAY " ".
008200     DISPLAY "          1.  ADD RECORDS".
008300     DISPLAY "          2.  CHANGE A RECORD".
008400     DISPLAY "          3.  LOOK UP A RECORD".
008500     DISPLAY "          4.  DELETE A RECORD".
008600     DISPLAY "          5.  LOOK UP BY NAME".
008700     DISPLAY "          6.  PRINT RECORDS".
008800     DISPLAY "          7.  PRINT IN NAME ORDER".
008900     DISPLAY "          8.  DISPLAY ALL RECORDS".
009000     DISPLAY " ".
009100     DISPLAY "          0.  EXIT".
009200     PERFORM SCROLL-LINE 8 TIMES.
009300
009400 ACCEPT-MENU-PICK.
009500     DISPLAY "YOUR CHOICE (0-8)?".
009600     ACCEPT MENU-PICK.
009700
009800 RE-ACCEPT-MENU-PICK.
009900     DISPLAY "INVALID SELECTION - PLEASE RE-TRY.".
010000     PERFORM ACCEPT-MENU-PICK.
010100
010200 CLEAR-SCREEN.
010300     PERFORM SCROLL-LINE 25 TIMES.
010400
010500 SCROLL-LINE.
010600     DISPLAY " ".
010700
010800 MAINTAIN-THE-FILE.
010900     PERFORM DO-THE-PICK.
011000     PERFORM GET-MENU-PICK.
011100
011200 DO-THE-PICK.
011300     IF MENU-PICK = 1
011400         PERFORM ADD-MODE
011500     ELSE
011600     IF MENU-PICK = 2
011700         PERFORM CHANGE-MODE
011800     ELSE
011900     IF MENU-PICK = 3
012000         PERFORM INQUIRE-MODE
012100     ELSE
012200     IF MENU-PICK = 4
012300         PERFORM DELETE-MODE
012400     ELSE
012500     IF MENU-PICK = 5
012600         PERFORM INQUIRE-BY-NAME
012700     ELSE
012800     IF MENU-PICK = 6
012900         PERFORM PRINT-VENDOR-REPORT
013000     ELSE
013100     IF MENU-PICK = 7
013200         PERFORM PRINT-BY-NAME
013300     ELSE
013400     IF MENU-PICK = 8
013500         PERFORM DISPLAY-ALL.
013600
013700*---------------------------------
013800* ADD
013900*---------------------------------
014000 ADD-MODE.
014100     MOVE "ADD" TO THE-MODE.
014200     PERFORM GET-NEW-RECORD-KEY.
014300     PERFORM ADD-RECORDS
014400        UNTIL VENDOR-NUMBER = ZEROES.
014500
014600 GET-NEW-RECORD-KEY.
014700     PERFORM ACCEPT-NEW-RECORD-KEY.
014800     PERFORM RE-ACCEPT-NEW-RECORD-KEY
014900         UNTIL VENDOR-RECORD-FOUND = "N" OR
015000               VENDOR-NUMBER = ZEROES.
015100
015200 ACCEPT-NEW-RECORD-KEY.
015300     PERFORM INIT-VENDOR-RECORD.
015400     PERFORM ENTER-VENDOR-NUMBER.
015500     IF VENDOR-NUMBER NOT = ZEROES
015600         PERFORM READ-VENDOR-RECORD.
015700
015800 RE-ACCEPT-NEW-RECORD-KEY.
015900     DISPLAY "RECORD ALREADY ON FILE"
016000     PERFORM ACCEPT-NEW-RECORD-KEY.
016100
016200 ADD-RECORDS.
016300     PERFORM ENTER-REMAINING-FIELDS.
016400     PERFORM WRITE-VENDOR-RECORD.
016500     PERFORM GET-NEW-RECORD-KEY.
016600
016700 ENTER-REMAINING-FIELDS.
016800     PERFORM ENTER-VENDOR-NAME.
016900     PERFORM ENTER-VENDOR-ADDRESS-1.
017000     PERFORM ENTER-VENDOR-ADDRESS-2.
017100     PERFORM ENTER-VENDOR-CITY.
017200     PERFORM ENTER-VENDOR-STATE.
017300     PERFORM ENTER-VENDOR-ZIP.
017400     PERFORM ENTER-VENDOR-CONTACT.
017500     PERFORM ENTER-VENDOR-PHONE.
017600
017700*---------------------------------
017800* CHANGE
017900*---------------------------------
018000 CHANGE-MODE.
018100     MOVE "CHANGE" TO THE-MODE.
018200     PERFORM GET-EXISTING-RECORD.
018300     PERFORM CHANGE-RECORDS
018400        UNTIL VENDOR-NUMBER = ZEROES.
018500
018600 CHANGE-RECORDS.
018700     PERFORM GET-FIELD-TO-CHANGE.
018800     PERFORM CHANGE-ONE-FIELD
018900         UNTIL WHICH-FIELD = ZERO.
019000     PERFORM GET-EXISTING-RECORD.
019100
019200 GET-FIELD-TO-CHANGE.
019300     PERFORM DISPLAY-ALL-FIELDS.
019400     PERFORM ASK-WHICH-FIELD.
019500
019600 ASK-WHICH-FIELD.
019700     PERFORM ACCEPT-WHICH-FIELD.
019800     PERFORM RE-ACCEPT-WHICH-FIELD
019900         UNTIL WHICH-FIELD < 9.
020000
020100 ACCEPT-WHICH-FIELD.
020200     DISPLAY "ENTER THE NUMBER OF THE FIELD".
020300     DISPLAY "TO CHANGE (1-8) OR 0 TO EXIT".
020400     ACCEPT WHICH-FIELD.
020500
020600 RE-ACCEPT-WHICH-FIELD.
020700     DISPLAY "INVALID ENTRY".
020800     PERFORM ACCEPT-WHICH-FIELD.
020900
021000 CHANGE-ONE-FIELD.
021100     PERFORM CHANGE-THIS-FIELD.
021200     PERFORM GET-FIELD-TO-CHANGE.
021300
021400 CHANGE-THIS-FIELD.
021500     IF WHICH-FIELD = 1
021600         PERFORM ENTER-VENDOR-NAME.
021700     IF WHICH-FIELD = 2
021800         PERFORM ENTER-VENDOR-ADDRESS-1.
021900     IF WHICH-FIELD = 3
022000         PERFORM ENTER-VENDOR-ADDRESS-2.
022100     IF WHICH-FIELD = 4
022200         PERFORM ENTER-VENDOR-CITY.
022300     IF WHICH-FIELD = 5
022400         PERFORM ENTER-VENDOR-STATE.
022500     IF WHICH-FIELD = 6
022600         PERFORM ENTER-VENDOR-ZIP.
022700     IF WHICH-FIELD = 7
022800         PERFORM ENTER-VENDOR-CONTACT.
022900     IF WHICH-FIELD = 8
023000         PERFORM ENTER-VENDOR-PHONE.
023100
023200     PERFORM REWRITE-VENDOR-RECORD.
023300
023400*---------------------------------
023500* INQUIRE
023600*---------------------------------
023700 INQUIRE-MODE.
023800     MOVE "DISPLAY" TO THE-MODE.
023900     PERFORM GET-EXISTING-RECORD.
024000     PERFORM INQUIRE-RECORDS
024100        UNTIL VENDOR-NUMBER = ZEROES.
024200
024300 INQUIRE-RECORDS.
024400     PERFORM DISPLAY-ALL-FIELDS.
024500     PERFORM GET-EXISTING-RECORD.
024600
024700*---------------------------------
024800* DELETE
024900*---------------------------------
025000 DELETE-MODE.
025100     MOVE "DELETE" TO THE-MODE.
025200     PERFORM GET-EXISTING-RECORD.
025300     PERFORM DELETE-RECORDS
025400        UNTIL VENDOR-NUMBER = ZEROES.
025500
025600 DELETE-RECORDS.
025700     PERFORM DISPLAY-ALL-FIELDS.
025800
025900     PERFORM ASK-OK-TO-DELETE.
026000
026100     IF OK-TO-DELETE = "Y"
026200         PERFORM DELETE-VENDOR-RECORD.
026300
026400     PERFORM GET-EXISTING-RECORD.
026500
026600 ASK-OK-TO-DELETE.
026700     PERFORM ACCEPT-OK-TO-DELETE.
026800
026900     PERFORM RE-ACCEPT-OK-TO-DELETE
027000        UNTIL OK-TO-DELETE = "Y" OR "N".
027100
027200 ACCEPT-OK-TO-DELETE.
027300     DISPLAY "DELETE THIS RECORD (Y/N)?".
027400     ACCEPT OK-TO-DELETE.
027500     INSPECT OK-TO-DELETE
027600      CONVERTING LOWER-ALPHA TO UPPER-ALPHA.
027700
027800 RE-ACCEPT-OK-TO-DELETE.
027900     DISPLAY "YOU MUST ENTER YES OR NO".
028000     PERFORM ACCEPT-OK-TO-DELETE.
028100
028200*---------------------------------
028300* Routines shared by all modes
028400*---------------------------------
028500 INIT-VENDOR-RECORD.
028600     MOVE SPACE TO VENDOR-RECORD.
028700     MOVE ZEROES TO VENDOR-NUMBER.
028800
028900 ENTER-VENDOR-NUMBER.
029000     DISPLAY " ".
029100     DISPLAY "ENTER VENDOR NUMBER OF THE VENDOR" .
029200     DISPLAY "TO " THE-MODE " (1-99999)".
029300     DISPLAY "ENTER 0 TO STOP ENTRY".
029400     ACCEPT VENDOR-NUMBER-FIELD.
029500*OR  ACCEPT VENDOR-NUMBER-FIELD WITH CONVERSION.
029600
029700     MOVE VENDOR-NUMBER-FIELD TO VENDOR-NUMBER.
029800
029900*---------------------------------
030000* INQUIRE BY NAME
030100*---------------------------------
030200 INQUIRE-BY-NAME.
030300     PERFORM CLOSING-PROCEDURE.
030400     CALL "VNINNM03".
030500     PERFORM OPENING-PROCEDURE.
030600
030700*---------------------------------
030800* PRINT
030900*---------------------------------
031000 PRINT-VENDOR-REPORT.
031100     PERFORM CLOSING-PROCEDURE.
031200     DISPLAY "VENDOR REPORT IN PROGRESS".
031300     CALL "VNDRPT04".
031400     PERFORM OPENING-PROCEDURE.
031500
031600*---------------------------------
031700* PRINT BY NAME
031800*---------------------------------
031900 PRINT-BY-NAME.
032000     PERFORM CLOSING-PROCEDURE.
032100     DISPLAY " REPORT BY NAME IN PROGRESS".
032200     CALL "VNBYNM02".
032300     PERFORM OPENING-PROCEDURE.
032400
032500*---------------------------------
032600* DISPLAY ALL
032700*---------------------------------
032800 DISPLAY-ALL.
032900     PERFORM CLOSING-PROCEDURE.
033000     CALL "VNDDSP03".
033100     DISPLAY "DISPLAY COMPLETE".
033200     DISPLAY "PRESS ENTER TO CONTINUE".
033300     ACCEPT A-DUMMY.
033400     PERFORM OPENING-PROCEDURE.
033500
033600*---------------------------------
033700* Routines shared Add and Change
033800*---------------------------------
033900 ENTER-VENDOR-NAME.
034000     PERFORM ACCEPT-VENDOR-NAME.
034100     PERFORM RE-ACCEPT-VENDOR-NAME
034200         UNTIL VENDOR-NAME NOT = SPACE.
034300
034400 ACCEPT-VENDOR-NAME.
034500     DISPLAY "ENTER VENDOR NAME".
034600     ACCEPT VENDOR-NAME.
034700     INSPECT VENDOR-NAME
034800         CONVERTING LOWER-ALPHA
034900         TO         UPPER-ALPHA.
035000
035100 RE-ACCEPT-VENDOR-NAME.
035200     DISPLAY "VENDOR NAME MUST BE ENTERED".
035300     PERFORM ACCEPT-VENDOR-NAME.
035400
035500 ENTER-VENDOR-ADDRESS-1.
035600     PERFORM ACCEPT-VENDOR-ADDRESS-1.
035700     PERFORM RE-ACCEPT-VENDOR-ADDRESS-1
035800         UNTIL VENDOR-ADDRESS-1 NOT = SPACE.
035900
036000 ACCEPT-VENDOR-ADDRESS-1.
036100     DISPLAY "ENTER VENDOR ADDRESS-1".
036200     ACCEPT VENDOR-ADDRESS-1.
036300     INSPECT VENDOR-ADDRESS-1
036400         CONVERTING LOWER-ALPHA
036500         TO         UPPER-ALPHA.
036600
036700 RE-ACCEPT-VENDOR-ADDRESS-1.
036800     DISPLAY "VENDOR ADDRESS-1 MUST BE ENTERED".
036900     PERFORM ACCEPT-VENDOR-ADDRESS-1.
037000
037100 ENTER-VENDOR-ADDRESS-2.
037200     DISPLAY "ENTER VENDOR ADDRESS-2".
037300     ACCEPT VENDOR-ADDRESS-2.
037400     INSPECT VENDOR-ADDRESS-2
037500         CONVERTING LOWER-ALPHA
037600         TO         UPPER-ALPHA.
037700
037800 ENTER-VENDOR-CITY.
037900     PERFORM ACCEPT-VENDOR-CITY.
038000     PERFORM RE-ACCEPT-VENDOR-CITY
038100         UNTIL VENDOR-CITY NOT = SPACE.
038200
038300 ACCEPT-VENDOR-CITY.
038400     DISPLAY "ENTER VENDOR CITY".
038500     ACCEPT VENDOR-CITY.
038600     INSPECT VENDOR-CITY
038700         CONVERTING LOWER-ALPHA
038800         TO         UPPER-ALPHA.
038900
039000 RE-ACCEPT-VENDOR-CITY.
039100     DISPLAY "VENDOR CITY MUST BE ENTERED".
039200     PERFORM ACCEPT-VENDOR-CITY.
039300
039400 ENTER-VENDOR-STATE.
039500     PERFORM ACCEPT-VENDOR-STATE.
039600     PERFORM RE-ACCEPT-VENDOR-STATE
039700         UNTIL VENDOR-STATE NOT = SPACES AND
039800               STATE-RECORD-FOUND = "Y".
039900
040000 ACCEPT-VENDOR-STATE.
040100     DISPLAY "ENTER VENDOR STATE".
040200     ACCEPT VENDOR-STATE.
040300     PERFORM EDIT-CHECK-VENDOR-STATE.
040400
040500 RE-ACCEPT-VENDOR-STATE.
040600     DISPLAY ERROR-MESSAGE.
040700     PERFORM ACCEPT-VENDOR-STATE.
040800
040900 EDIT-CHECK-VENDOR-STATE.
041000     PERFORM EDIT-VENDOR-STATE.
041100     PERFORM CHECK-VENDOR-STATE.
041200
041300 EDIT-VENDOR-STATE.
041400     INSPECT VENDOR-STATE
041500         CONVERTING LOWER-ALPHA
041600         TO         UPPER-ALPHA.
041700
041800 CHECK-VENDOR-STATE.
041900     PERFORM VENDOR-STATE-REQUIRED.
042000     IF VENDOR-STATE NOT = SPACES
042100         PERFORM VENDOR-STATE-ON-FILE.
042200
042300 VENDOR-STATE-REQUIRED.
042400     IF VENDOR-STATE = SPACE
042500         MOVE "VENDOR STATE MUST BE ENTERED"
042600           TO ERROR-MESSAGE.
042700
042800 VENDOR-STATE-ON-FILE.
042900     MOVE VENDOR-STATE TO STATE-CODE.
043000     PERFORM READ-STATE-RECORD.
043100     IF STATE-RECORD-FOUND = "N"
043200         MOVE "STATE CODE NOT FOUND IN CODES FILE"
043300           TO ERROR-MESSAGE.
043400
043500 ENTER-VENDOR-ZIP.
043600     PERFORM ACCEPT-VENDOR-ZIP.
043700     PERFORM RE-ACCEPT-VENDOR-ZIP
043800         UNTIL VENDOR-ZIP NOT = SPACE.
043900
044000 ACCEPT-VENDOR-ZIP.
044100     DISPLAY "ENTER VENDOR ZIP".
044200     ACCEPT VENDOR-ZIP.
044300     INSPECT VENDOR-ZIP
044400         CONVERTING LOWER-ALPHA
044500         TO         UPPER-ALPHA.
044600
044700 RE-ACCEPT-VENDOR-ZIP.
044800     DISPLAY "VENDOR ZIP MUST BE ENTERED".
044900     PERFORM ACCEPT-VENDOR-ZIP.
045000
045100 ENTER-VENDOR-CONTACT.
045200     DISPLAY "ENTER VENDOR CONTACT".
045300     ACCEPT VENDOR-CONTACT.
045400     INSPECT VENDOR-CONTACT
045500         CONVERTING LOWER-ALPHA
045600         TO         UPPER-ALPHA.
045700
045800 ENTER-VENDOR-PHONE.
045900     PERFORM ACCEPT-VENDOR-PHONE.
046000     PERFORM RE-ACCEPT-VENDOR-PHONE
046100         UNTIL VENDOR-PHONE NOT = SPACE.
046200
046300 ACCEPT-VENDOR-PHONE.
046400     DISPLAY "ENTER VENDOR PHONE".
046500     ACCEPT VENDOR-PHONE.
046600     INSPECT VENDOR-PHONE
046700         CONVERTING LOWER-ALPHA
046800         TO         UPPER-ALPHA.
046900
047000 RE-ACCEPT-VENDOR-PHONE.
047100     DISPLAY "VENDOR PHONE MUST BE ENTERED".
047200     PERFORM ACCEPT-VENDOR-PHONE.
047300
047400*---------------------------------
047500* Routines shared by Change,
047600* Inquire and Delete
047700*---------------------------------
047800 GET-EXISTING-RECORD.
047900     PERFORM ACCEPT-EXISTING-KEY.
048000     PERFORM RE-ACCEPT-EXISTING-KEY
048100         UNTIL VENDOR-RECORD-FOUND = "Y" OR
048200               VENDOR-NUMBER = ZEROES.
048300
048400 ACCEPT-EXISTING-KEY.
048500     PERFORM INIT-VENDOR-RECORD.
048600     PERFORM ENTER-VENDOR-NUMBER.
048700     IF VENDOR-NUMBER NOT = ZEROES
048800         PERFORM READ-VENDOR-RECORD.
048900
049000 RE-ACCEPT-EXISTING-KEY.
049100     DISPLAY "RECORD NOT FOUND"
049200     PERFORM ACCEPT-EXISTING-KEY.
049300
049400 DISPLAY-ALL-FIELDS.
049500     DISPLAY " ".
049600     PERFORM DISPLAY-VENDOR-NUMBER.
049700     PERFORM DISPLAY-VENDOR-NAME.
049800     PERFORM DISPLAY-VENDOR-ADDRESS-1.
049900     PERFORM DISPLAY-VENDOR-ADDRESS-2.
050000     PERFORM DISPLAY-VENDOR-CITY.
050100     PERFORM DISPLAY-VENDOR-STATE.
050200     PERFORM DISPLAY-VENDOR-ZIP.
050300     PERFORM DISPLAY-VENDOR-CONTACT.
050400     PERFORM DISPLAY-VENDOR-PHONE.
050500     DISPLAY " ".
050600
050700 DISPLAY-VENDOR-NUMBER.
050800     DISPLAY "   VENDOR NUMBER: " VENDOR-NUMBER.
050900
051000 DISPLAY-VENDOR-NAME.
051100     DISPLAY "1. VENDOR NAME: " VENDOR-NAME.
051200
051300 DISPLAY-VENDOR-ADDRESS-1.
051400     DISPLAY "2. VENDOR ADDRESS-1: " VENDOR-ADDRESS-1.
051500
051600 DISPLAY-VENDOR-ADDRESS-2.
051700     DISPLAY "3. VENDOR ADDRESS-2: " VENDOR-ADDRESS-2.
051800
051900 DISPLAY-VENDOR-CITY.
052000     DISPLAY "4. VENDOR CITY: " VENDOR-CITY.
052100
052200 DISPLAY-VENDOR-STATE.
052300     PERFORM VENDOR-STATE-ON-FILE.
052400     IF STATE-RECORD-FOUND = "N"
052500         MOVE "**Not found**" TO STATE-NAME.
052600     DISPLAY "5. VENDOR STATE: "
052700             VENDOR-STATE " "
052800             STATE-NAME.
052900
053000 DISPLAY-VENDOR-ZIP.
053100     DISPLAY "6. VENDOR ZIP: " VENDOR-ZIP.
053200
053300 DISPLAY-VENDOR-CONTACT.
053400     DISPLAY "7. VENDOR CONTACT: " VENDOR-CONTACT.
053500
053600 DISPLAY-VENDOR-PHONE.
053700     DISPLAY "8. VENDOR PHONE: " VENDOR-PHONE.
053800
053900*---------------------------------
054000* File I-O Routines
054100*---------------------------------
054200 READ-VENDOR-RECORD.
054300     MOVE "Y" TO VENDOR-RECORD-FOUND.
054400     READ VENDOR-FILE RECORD
054500       INVALID KEY
054600          MOVE "N" TO VENDOR-RECORD-FOUND.
054700
054800*or  READ VENDOR-FILE RECORD WITH LOCK
054900*      INVALID KEY
055000*         MOVE "N" TO VENDOR-RECORD-FOUND.
055100
055200*or  READ VENDOR-FILE RECORD WITH HOLD
055300*      INVALID KEY
055400*         MOVE "N" TO VENDOR-RECORD-FOUND.
055500
055600 WRITE-VENDOR-RECORD.
055700     WRITE VENDOR-RECORD
055800         INVALID KEY
055900         DISPLAY "RECORD ALREADY ON FILE".
056000
056100 REWRITE-VENDOR-RECORD.
056200     REWRITE VENDOR-RECORD
056300         INVALID KEY
056400         DISPLAY "ERROR REWRITING VENDOR RECORD".
056500
056600 DELETE-VENDOR-RECORD.
056700     DELETE VENDOR-FILE RECORD
056800         INVALID KEY
056900         DISPLAY "ERROR DELETING VENDOR RECORD".
057000
057100 READ-STATE-RECORD.
057200     MOVE "Y" TO STATE-RECORD-FOUND.
057300     READ STATE-FILE RECORD
057400       INVALID KEY
057500          MOVE "N" TO STATE-RECORD-FOUND.
