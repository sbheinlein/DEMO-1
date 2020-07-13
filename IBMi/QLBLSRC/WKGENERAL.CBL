      ****************************************************************
      *                                                              *
      * APPLICATION NAME...........: . ALL APPLICATIONS              *
      * COPY NAME..................: . WKGENERAL                     *
      * COPY TYPE..................: . GENERAL FIELD DEFINITION      *
      * FUNCTION...................: . TABLE OF GENERAL FILEDS       *
      *         .                           AND CONSTANTS            *
      * OTHER COPIES REQUIRED......: .                               *
      *         .                                                    *
      * COPY LOCATION..............: . WORKING-STORAGE               *
      *         .                                                    *
      * GLOBAL  FIELDS TOUCHED.....: .                               *
      *         .                                                    *
      * INPUT PARAMETERS...........: .                               *
      *         .                                                    *
      * OUTPUT PARAMETERS..........: .                               *
      *         .                                                    *
      *                                                              *
      ****************************************************************
      *---------------------------
      *-      ZONES   I-O        -
      *---------------------------
       01  ST                     PIC XX.
       01  FILLER VALUE SPACE.
           05  WTILT              PIC 9.
      *---------------------------
      *-    BOOLEENS GENERAUX    -
      *---------------------------
       01  VRAI                   PIC 1 VALUE B"1".
       01  FAUX                   PIC 1 VALUE B"0".
      *------------------------------
      *-    CARACTERES DUPLIQUES    -
      *------------------------------
      * PIC S9999 COMP-4 VALUE 7196 CORRESPOND A
      *     2 OCTETS DE VALEUR HEXA X"1C"
       01         DUPLIC.
           05          FILLER          PIC S9999 COMP-4 VALUE 7196.
           05          FILLER          PIC S9999 COMP-4 VALUE 7196.
           05          FILLER          PIC S9999 COMP-4 VALUE 7196.
           05          FILLER          PIC S9999 COMP-4 VALUE 7196.
           05          FILLER          PIC S9999 COMP-4 VALUE 7196.
       01         FILLER REDEFINES DUPLIC.
           05          DUPLIC10.
            07         DUPLIC9.
             09        DUPLIC8.
              11       DUPLIC7.
               13      DUPLIC6.
                15     DUPLIC5.
                 17    DUPLIC4.
                  19   DUPLIC3.
                   21  DUPLIC2.
                    23 DUPLIC1         PIC X.
                    23 FILLER          PIC X.
                   21  FILLER          PIC X.
                  19   FILLER          PIC X.
                 17    FILLER          PIC X.
                15     FILLER          PIC X.
               13      FILLER          PIC X.
              11       FILLER          PIC X.
             09        FILLER          PIC X.
            07         FILLER          PIC X.
