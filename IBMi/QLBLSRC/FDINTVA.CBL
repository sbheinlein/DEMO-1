      ****************************************************************
      * APPLICATION NAME...........: . ALL APPLICATIONS              *
      * COPY NAME..................: . FDINTVA                       *
      * TYPE OF COPY...............: . DEFINITION GENERAL FIELD      *
      * FUNCTION...................: . DESCRIPTION INFODI            *
      *         .                        TAX RECORD                  *
      * OTHER COPIES REQUIRED......: .                               *
      *         .                                                    *
      * COPY LOCATION..............: . INPUT-OUTPUT SECTION          *
      *         .   T  = RATE                                        *
      *         .   TL = LONG RATE (+ PRECISE)                       *
      *         .   E  = EDIT                                        *
      *         .   M  = COEFFICIENT  =  1 + RATE / 100              *
      *         .   ML = COEFF LONG (+ PRECISE)                      *
      *                                                              *
      *  LAST MODIFICATION DATE. ...: 05/06/97 BY JNF                *
      *  LAST MODIFICATION REASON...: CORRESPONDANCE TAX CODE FOR    *
      *                                  TWO SITES                   *
      *                                                              *
      ****************************************************************
M01?V  01  FDIN-TVA.
           05  FDIN-TVA-CLEF.
               10  FDIN-TVA-CLEF-GEN  PIC X(18).
               10  FDIN-TVA-CLEF-VER  PIC X(2).
           05  FDIN-TVA-LIB           PIC X(20).
      ********   SUR ACHAT
           05  FDIN-TVA-TVAT          PIC S9(2)V9(2).
           05  FDIN-TVA-TVATL         PIC S9(2)V9(5).
           05  FDIN-TVA-TVAE          PIC X(5).
           05  FDIN-TVA-TVAM          PIC S9(1)V9(4).
           05  FDIN-TVA-TVAML         PIC S9(1)V9(7).
      ********   SUR VENTE
           05  FDIN-TVA-TVVT          PIC S9(2)V9(2).
           05  FDIN-TVA-TVVTL         PIC S9(2)V9(5).
           05  FDIN-TVA-TVVE          PIC X(5).
           05  FDIN-TVA-TVVM          PIC S9(1)V9(4).
           05  FDIN-TVA-TVVML         PIC S9(1)V9(7).
      *
           05  FILLER                 PIC XX.
      *
      ***** Code TVA actif        O/N        101
           05  FDIN-TVA-ACTIF         PIC X.
      ***** Code TVA avec regie   O/N        102
           05  FDIN-TVA-REGIE         PIC X.
      ***** Code TVA achat COFRADEL correspondant  Pos:103/Lg:02
           05  FDIN-TVA-COFACH           PIC X(2).
      ***** Code TVA vente COFRADEL correspondant  Pos:105/Lg:02
           05  FDIN-TVA-COFVEN           PIC X(2).
      ***** Correspondance d'un autre site         Pos:107/Lg:02
           05  FDIN-TVA-CORRES           PIC X(2).
      ***** Zone non utilisée                      Pos:109/Lg:148
           05  FILLER                 PIC X(148).
      *
