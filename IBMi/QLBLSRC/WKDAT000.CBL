      *******************************************************************
      * WKDAT000-COMMUNICATION FILEDS SUB-PROGRAM   ACBDT000  -15/10/87 *
      *                          104 CHARACTERS                         *
      * VALIDATES A DATE AND PUTS IT INTO PRINTED FORMAT...             *
      * IF CYYMMDD=SPACES OR INVALID  -> S/P WORKS WITH DAY'S DATE      *
      * OTHERWISE                     -> S/P WORKS WITH CYYMMDD         *
      *******************************************************************
       01  WKDAT000.
      ***** DD/MM/YY HH.MM.SS.CC *****  POS=1 LG=20
           05      WDATE-HEURE-EDT VALUE "01/01/01 01:01:01:01".
      ***** DATE. FORMAT EDITED DD/MM/YY *****
            10     WJJMMAA-EDT.
             15    WJJ-EDT                        PIC X(2).
             15    FILLER                         PIC X.
             15    WMM-EDT                        PIC X(2).
             15    FILLER                         PIC X.
             15    WAA-EDT                        PIC X(2).
            10     FILLER                         PIC X.
      ***** TIME FORMAT EDITED HH.MM.SS.CC *****
            10     WHHMNSSCC-EDT.
             15    WHHMNSS-EDT.
              20   WHHMN-EDT.
               25  WHH-EDT                        PIC X(2).
               25  FILLER                         PIC X.
               25  WMN-EDT                        PIC X(2).
              20   FILLER                         PIC X.
              20   WSS-EDT                        PIC X(2).
             15    FILLER                         PIC X.
             15    WCC-EDT                        PIC X(2).
      ***** DD/MM/YY HH.MM.SS *****
           05      FILLER REDEFINES WDATE-HEURE-EDT.
            10     WDAT-HEUR-EDT                  PIC X(17).
            10     FILLER                         PIC X(3).
      ***** LEAP YEAR=0, ELSE 1,2 OR 3 *****  POS=21 LG=1
           05      WAN-BISSEX.
            10     WAN-BISSEX9                    PIC 9 VALUE ZERO.
      ** NBR DAYS IN WEEK (1=MONDAY TO 7=SUNDAY) ** POS=22 LG=1
           05      WDAY-IN-WEEK.
            10     WDAY-IN-WEEK9                  PIC 9 VALUE ZERO.
      ***** DAY/NB.DAY/MONTH/YEAR NOT IN CODE ***   POS=23 LG=26
           05      WDATE-CLAIR VALUE "MERCREDI 01 SEPTEMBRE 1901".
            10     WJOUR                          PIC X(8).
            10     FILLER                         PIC X.
            10     WNOJOUR                        PIC X(2).
            10     FILLER                         PIC X.
            10     WMOIS-AAAA.
             15    WMOIS                          PIC X(9).
             15    FILLER                         PIC X(3).
             15    WAN                            PIC X(2).
      ***** YEAR FORMAT YYYY *****
            10     FILLER REDEFINES WMOIS-AAAA.
             15    FILLER                         PIC X(10).
             15    WAAAA.
              20   WAAAA9                         PIC 9(4).
      ***** QUANTIEME. FORMAT DDD FOR YEAR *** POS=49 LG=3
           05      WJJJ.
            10     WJJJ9                          PIC 9(3) VALUE ZERO.
      ***** DATE FORM DDMM                    *** POS=52 LG=4
           05      WJJMM                          PIC X(4) VALUE "JJMM".
      ***** DATE/TIME. FORMAT YYMMDDHHMNSSCC ***  POS=56 LG=14
           05      WAAMMJJ-HHMNSSCC VALUE "AAMMJJ01010101".
      ***** DATE. FORMAT YYMMDD *****
            10     WAAMMJJ.
             15    WAAMM.
              20   WAA.
               25  WAA1-1                         PIC X.
               25  WAA2-2                         PIC X.
              20   WAA9 REDEFINES WAA             PIC 9(2).
              20   WMM.
               25  WMM9                           PIC 9(2).
             15    WAAMM9 REDEFINES WAAMM         PIC 9(4).
             15    WJJ.
              20   WJJ9                           PIC 9(2).
      ***** DATE. FORMAT YYMMDD DIGITAL *****
            10     WAAMMJJ9 REDEFINES WAAMMJJ     PIC 9(6).
      ***** TIME. FORMAT HHMNSSCC *****
            10     WHHMNSSCC.
             15    WHHMNSS.
              20   WHH.
               25  WHH9                           PIC 9(2).
              20   WMN.
               25  WMN9                           PIC 9(2).
              20   WSS.
               25  WSS9                           PIC 9(2).
             15    WCC.
              20   WCC9                           PIC 9(2).
      ***** TIME. FORMAT HHMNSSCC DIGITAL *****
            10     WHHMNSSCC9 REDEFINES WHHMNSSCC PIC 9(8).
      ***** TIME. FORMAT HHMNSS DIGITAL *****
            10     FILLER REDEFINES WHHMNSSCC.
             15    WHHMNSS9                       PIC 9(6).
             15    FILLER                         PIC X(2).
      ***** TIME. FORMAT HHMN DIGITAL *****
            10     FILLER REDEFINES WHHMNSSCC.
             15    WHHMN.
              20   WHHMN9                         PIC 9(4).
             15    FILLER                         PIC X(4).
      ***** DATE/TIME. FORMAT YYMMDDHHMNSS *****
           05      FILLER REDEFINES WAAMMJJ-HHMNSSCC.
            10     WAAMMJJ-HHMNSS.
             15    WAAMMJJ-HHMNSS9                PIC 9(12).
            10     FILLER                         PIC X(2).
      ***** DAY/DAY NBR/MONTH/NOT IN CODE ***  POS=70 LG=13
           05      WDATE-CLAIRC VALUE "JEU 01 MAR 85".
            10     WJOURC                         PIC X(3).
            10     FILLER                         PIC X.
            10     WNOJOURC                       PIC X(2).
            10     FILLER                         PIC X.
            10     WMOISC                         PIC X(3).
            10     FILLER                         PIC X.
            10     WANC                           PIC X(2).
      ***** PUBLIC HOLIDAYS *****           POS=82 LG=10
           05      WNOM-FETE                      PIC X(10) VALUE SPACE.
      ***** QUANTIEME. FORMAT DDDDD FOR THE CENTURY ** POS=93 LG=5
           05      WJJJJJ.
            10     WJJJJJ9                        PIC 9(5) VALUE ZERO.
      ***** NUMBER OF WEEK IN YEAR *** POS=98 LG=2
           05      WNO-SEMAINE.
            10     WNO-SEMAINE9                   PIC 9(2) VALUE ZERO.
      ***** NUMBER OF DAYS IN MONTH ***** POS=100 LG=2
           05      WNBJOUR-MOIS.
            10     WNBJOUR-MOIS9                  PIC 9(2) VALUE ZERO.
      ***** TRIMESTER NUMBER (1 TO 4) *** POS=102 LG=1
           05      WNO-TRIMESTRE.
            10     WNO-TRIMESTRE9                 PIC 9 VALUE ZERO.
      ***** SEMESTER NUMBER (1 OR 2) *** POS=103 LG=1
           05      WNO-SEMESTRE.
            10     WNO-SEMESTRE9                  PIC 9 VALUE ZERO.
      ***** 1=NON WORK  0=ELSE *** POS=104 LG=1
           05      WFERIE                         PIC X VALUE "0".
      ***** YEAR/QUANTIEME. FORMAT YYDDD *****
       01  FILLER REDEFINES WKDAT000.
           05      FILLER                         PIC X(46).
           05      WAAJJJ.
            10     WAAJJJ9                        PIC 9(5).
      ***** DATE. FORMAT DDMMYY *****
           05      WJJMMAA                        PIC X(6).
           05      FILLER                         PIC X(47).
      *
