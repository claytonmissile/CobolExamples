000100 IDENTIFICATION DIVISION.
000200 PROGRAM-ID. HELLO04.
000300
000400* This program illustrates the use of a PERFORM
000500
000600 ENVIRONMENT DIVISION.
000700 DATA DIVISION.
000800 PROCEDURE DIVISION.
000900
001000 PROGRAM-BEGIN.
001100     DISPLAY "Today's message is:".
001200     PERFORM SAY-HELLO.
001300
001400 PROGRAM-DONE.
001500     ACCEPT OMITTED. STOP RUN.
001600
001700 SAY-HELLO.
001800     DISPLAY "Hello world".
001900
