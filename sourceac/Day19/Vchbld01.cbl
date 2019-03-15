000100 IDENTIFICATION DIVISION.
000200 PROGRAM-ID. VCHBLD01.
000300*---------------------------------
000400* Create a Voucher file for the
000500* bills payment system
000600*---------------------------------
000700 ENVIRONMENT DIVISION.
000800 INPUT-OUTPUT SECTION.
000900 FILE-CONTROL.
001000
001100     COPY "SLVOUCH.CBL".
001200
001300 DATA DIVISION.
001400 FILE SECTION.
001500
001600     COPY "FDVOUCH.CBL".
001700
001800 WORKING-STORAGE SECTION.
001900
002000 PROCEDURE DIVISION.
002100 PROGRAM-BEGIN.
002200     OPEN OUTPUT VOUCHER-FILE.
002300     CLOSE VOUCHER-FILE.
002400
002500 PROGRAM-EXIT.
002600     EXIT PROGRAM.
002700
002800 PROGRAM-DONE.
002900     ACCEPT OMITTED. STOP RUN.
003000