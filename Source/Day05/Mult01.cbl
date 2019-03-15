000100 IDENTIFICATION DIVISION.
000200 PROGRAM-ID. MULT01.
000300*--------------------------------------------------
000400* This program asks the user for a number for a
000500* multiplication table,
000600* and then displays a table for that number times
000700* the values 1 through 12.
000800*--------------------------------------------------
000900 ENVIRONMENT DIVISION.
001000 DATA DIVISION.
001100 WORKING-STORAGE SECTION.
001200
001300 01  THE-NUMBER         PIC 99.
001400 01  THE-MULTIPLIER     PIC 999.
001500 01  THE-PRODUCT        PIC 9999.
001600
001700 PROCEDURE DIVISION.
001800* LEVEL 1 ROUTINES
001900 PROGRAM-BEGIN.
002000     PERFORM PROGRAM-INITIALIZATION.
002100     PERFORM GET-TABLE-NUMBER.
002200     PERFORM DISPLAY-THE-TABLE.
002300
002400 PROGRAM-DONE.
002500     STOP RUN.
002600
002700* LEVEL 2 ROUTINES
002800 PROGRAM-INITIALIZATION.
002900     MOVE 0 TO THE-MULTIPLIER.
003000
003100 GET-TABLE-NUMBER.
003200     DISPLAY
003300     "Which multiplication table (01-99)?".
003400     ACCEPT THE-NUMBER.
003500
003600 DISPLAY-THE-TABLE.
003700     DISPLAY "The " THE-NUMBER "'s table is:".
003800     PERFORM CALCULATE-AND-DISPLAY.
003900
004000* LEVEL 3 ROUTINES.
004100 CALCULATE-AND-DISPLAY.
004200     ADD 1 TO THE-MULTIPLIER.
004300     COMPUTE THE-PRODUCT = THE-NUMBER * THE-MULTIPLIER.
004400     DISPLAY
004500         THE-NUMBER " * " THE-MULTIPLIER " = " THE-PRODUCT.
004600     IF THE-MULTIPLIER < 12
004700         GO TO CALCULATE-AND-DISPLAY.
004800