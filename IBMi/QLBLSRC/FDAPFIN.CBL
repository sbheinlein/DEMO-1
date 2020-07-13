      ****************************************************************
      *                                                              *
      * APPLICATION NAME...........: . WAREHOUSE                     *
      * COPY NAME..................: . FDAPFIN                       *
      * TYPE OF COPY...............: . FILE DESCRIPTION              *
      * FUNCTION...................: . INFORMATION FILE GENERAL      *
      *         .                        COPY                        *
      * OTHER COPIES REQUIRED......: . UPDATE THE DDS COPY AFTER     *
      *         .                                                    *
      * COPY LOCATION..............: . FILE SECTION                  *
      *         .                                                    *
      * GLOBAL FIELDS TOUCHED......: .                               *
      *         .                                                    *
      * INPUT PARAMETERS...........: .                               *
      *         .                                                    *
      * OUTPUT PARAMETERS..........: .                               *
      *         .                                                    *
      *                                                              *
      ****************************************************************
       FD  FINFODI   LABEL RECORD STANDARD
                     RECORD 256.
M01?V  01  INF-ENR.
           05        INF-CLE.
            10       INF-CLE-RAC18.
             15      INF-CLE-APPLICATION    PIC X(2).
             15      INF-CLE-LIB1           PIC X(6).
             15      INF-CLE-LIB2           PIC X(6).
             15      INF-CLE-NUMERO         PIC X(4).
            10       FILLER REDEFINES INF-CLE-RAC18.
             15      INF-CLE-RAC1-16        PIC X(16).
             15      INF-CLE-RAC17-18.
              20     INF-CLE-RAC17-18-NUM   PIC 99.
            10       INF-CLE-SEQENR.
             15      INF-CLE-SEQENR9        PIC 9(2).
           05        INF-CORPS              PIC X(223).
M01?V      05        INF-FIN.
M01?V       10       INF-MAJ-DATE.
M01?C        15      INF-MAJ-AA             PIC XX.
             15      INF-MAJ-MM             PIC XX.
             15      INF-MAJ-JJ             PIC XX.
            10       INF-MSG                PIC X(7).
      *
