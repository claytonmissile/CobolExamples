000100 IDENTIFICATION DIVISION.
000200 PROGRAM-ID. HELLO03.
000300 ENVIRONMENT DIVISION.
000400 DATA DIVISION.
000500
000600 WORKING-STORAGE SECTION.
000700
000800 01  THE-MESSAGE      PIC X(20).
000900 01  THE-NAME         PIC X(10).
001000 01  THE-NUMBER       PIC 99.
001100
001200 PROCEDURE DIVISION.
001300
001400 PROGRAM-BEGIN.
001500
001600     DISPLAY "Enter someone's name.".
001700
001800     ACCEPT THE-NAME.
001900
002000     MOVE "Hello" TO THE-MESSAGE.
002100
002200     MOVE 1 TO THE-NUMBER.
002300
002400     DISPLAY "Message "
002500             THE-NUMBER
002600             ": "
002700             THE-MESSAGE
002800             THE-NAME.
002900
003000     MOVE "Say Goodnight," TO THE-MESSAGE.
003100
003200     MOVE 2 TO THE-NUMBER.
003300
003400     DISPLAY "Message "
003500             THE-NUMBER
003600             ": "
003700             THE-MESSAGE
003800             THE-NAME.
003900
004000
004100 PROGRAM-DONE.
004200     STOP RUN.
004300
