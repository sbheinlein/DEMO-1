      ****************************************************************
      *                                                              *
      * APPLICATION NAME...........: . ALL APPLICATIONS              *
      * COPY NAME..................: . WKTABTVA                      *
      * COPY TYPE..................: . DEFINITION GENERAL FIELD      *
      * FUNCTION...................: . INFORMATION FOR THE TAX RATES *
      * OTHER COPIES REQUIRED......: .                               *
      *         .                                                    *
      * COPY LOCATIONµ.............: . WORKING-STORAGE               *
      *                                                              *
      *  LAST MODIFICATION DATE.....: 05/06/97 BY JNF                *
      *  LAST MODIFICATION SUBJECT..: CORRESPONDANCE TAX CODE FOR    *
      *                                   TWO SITES                  *
      *                                                              *
      ****************************************************************
       01  WK-TVA-CLE        VALUE "XXART   TVA   0000  ".
           05  WK-TVA-RAC            PIC X(18).
           05  FILLER                PIC XX.
       01  WK-TVA-NBPST              PIC 99    VALUE  10.
M01?V  01  WK-TVA-TABLE              VALUE     SPACE.
           05  FILLER                PIC X(754).
M01?V  01  WK-TVA-TABLE-REDEF REDEFINES WK-TVA-TABLE.
           05  WK-TVA-TP             OCCURS 10 INDEXED BY IN-TVA.
               10  WK-TVA-LIB        PIC X(20).
               10  WK-TVA-TVAT       PIC S9(3)V9(2) COMP-3.
               10  WK-TVA-TVAT-CENT  REDEFINES WK-TVA-TVAT
                                     PIC S9V9(4)    COMP-3.
               10  WK-TVA-TVATL      PIC S9(2)V9(5) COMP-3.
               10  WK-TVA-TVATL-CENT REDEFINES WK-TVA-TVATL
                                     PIC SV9(7)      COMP-3.
               10  WK-TVA-TVAE       PIC X(5).
               10  WK-TVA-TVAM       PIC S9(1)V9(4) COMP-3.
               10  WK-TVA-TVAML      PIC S9(2)V9(7) COMP-3.
               10  WK-TVA-TVVT       PIC S9(3)V9(2) COMP-3.
               10  WK-TVA-TVVT-CENT  REDEFINES WK-TVA-TVVT
                                     PIC S9V9(4)    COMP-3.
               10  WK-TVA-TVVTL      PIC S9(2)V9(5) COMP-3.
               10  WK-TVA-TVVTL-CENT REDEFINES WK-TVA-TVVTL
                                     PIC SV9(7)      COMP-3.
               10  WK-TVA-TVVE       PIC X(5).
               10  WK-TVA-TVVM       PIC S9(1)V9(4) COMP-3.
               10  WK-TVA-TVVML      PIC S9(2)V9(7) COMP-3.
               10  WK-TVA-ACTIF      PIC X.
               10  WK-TVA-REGIE      PIC X.
               10  WK-TVA-CORRES     PIC X(2).
M01?C *    05  WK-TVA-DATE           PIC X(6).
M01?C      05  WK-TVA-DATE           PIC X(8).
           05  WK-TVA-NMSG           PIC X(7).
           05  WK-TVA-VMSG           PIC X(121).
      *
