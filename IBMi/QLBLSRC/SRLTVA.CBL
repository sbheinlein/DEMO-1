      ****************************************************************
      * APPLICATION NAME...........: . ALL APPLICATIONS              *
      * COPY NAME..................: . SRLTVA                        *
      * TYPE OF COPY...............: . SUB-ROUTINE   (PERFORM)       *
      * FUNCTION...................: . LOAD TAX RATE TABLE           *
      * OTHER COPIES REQUITRED.....: . IN WORKING WKTABTVA           *
      *         .                                 WKMESSAGE          *
      *                                                              *
      *  LAST MODIFICATION DATE.....: 05/06/97 BY JNF                *
      *  LAST MODIFICATION SUBJECT..: CORRESPONDANCE TAX CODE FOR    *
      *                                  TWO SITES                   *
      *                                                              *
      ****************************************************************
       SRL-TVA.
           MOVE WK-TVA-CLE  TO INFCLE.
           START   FINFODI  KEY   >    INFCLE    INVALID   KEY
                   STRING "ERREUR LECTURE F-INFODI CLE :"  INFCLE
                          DELIMITED BY  SIZE     INTO WK-MESSAGE-LIB
                          GO      TO             SRL-TVA-F.
       SRL-LECT-TVA.
           READ    FINFODI  NEXT  END  GO SRL-TVA-F.
           IF INF-CLE-RAC18 NOT = WK-TVA-RAC GO SRL-TVA-F.
           IF INF-CLE-SEQENR NOT NUMERIC
                MOVE "CODE TVA INVALIDE" TO WK-MESSAGE-LIB
                GO   TILT.
           IF INF-CLE-SEQENR9 NOT < WK-TVA-NBPST
                MOVE "TAILLE TABLE T.V.A. INSUFFISANTE"
                     TO WK-MESSAGE-LIB
                GO   TILT.
           SET IN-TVA TO 1
           SET IN-TVA UP BY INF-CLE-SEQENR9.
           IF FDIN-TVA-LIB = SPACE
                STRING "CODE TVA " INF-CLE-SEQENR
                       DELIMITED BY SIZE INTO FDIN-TVA-LIB.
           MOVE FDIN-TVA-LIB       TO WK-TVA-LIB   (IN-TVA).
           MOVE FDIN-TVA-TVAT      TO WK-TVA-TVAT  (IN-TVA).
           MOVE FDIN-TVA-TVATL     TO WK-TVA-TVATL (IN-TVA).
           MOVE FDIN-TVA-TVAE      TO WK-TVA-TVAE  (IN-TVA).
           MOVE FDIN-TVA-TVAM      TO WK-TVA-TVAM  (IN-TVA).
           MOVE FDIN-TVA-TVAML     TO WK-TVA-TVAML (IN-TVA).
           MOVE FDIN-TVA-TVVT      TO WK-TVA-TVVT  (IN-TVA).
           MOVE FDIN-TVA-TVVTL     TO WK-TVA-TVVTL (IN-TVA).
           MOVE FDIN-TVA-TVVE      TO WK-TVA-TVVE  (IN-TVA).
           MOVE FDIN-TVA-TVVM      TO WK-TVA-TVVM  (IN-TVA).
           MOVE FDIN-TVA-TVVML     TO WK-TVA-TVVML (IN-TVA).
           MOVE FDIN-TVA-ACTIF     TO WK-TVA-ACTIF (IN-TVA).
           MOVE FDIN-TVA-REGIE     TO WK-TVA-REGIE (IN-TVA).
           MOVE FDIN-TVA-CORRES    TO WK-TVA-CORRES (IN-TVA).
M01?V      MOVE INF-MAJ-DATE       TO WK-TVA-DATE.
           MOVE INF-MSG            TO WK-TVA-NMSG.
           GO SRL-LECT-TVA.
       SRL-TVA-F.
M01?V      IF      WK-TVA-TABLE     =   SPACE
                   MOVE "ERREUR INFODI ... TABLE TVA  VIDE"
                             TO         WK-MESSAGE-LIB
                             GO         TILT.
           SET IN-TVA TO 1.
       SRL-TVA-CONSTIT.
           IF WK-TVA-TP (IN-TVA) NOT = SPACE
                  SET INF-CLE-SEQENR9 TO IN-TVA
                  STRING WK-TVA-VMSG DELIMITED BY SPACE
                         INF-CLE-SEQENR DELIMITED BY SIZE
                     INTO WK-TVA-VMSG.
           IF IN-TVA < WK-TVA-NBPST SET IN-TVA UP BY 1
                                    GO SRL-TVA-CONSTIT.
           SET     IN-TMSG              TO  1.
           SEARCH  WK-TMSG-PST          VARYING   IN-TMSG
                   WHEN     WK-TVA-NMSG   =     WK-TMSG-NO (IN-TMSG)
                      MOVE WK-TVA-VMSG TO WK-TMSG-LIB(IN-TMSG).
       SRL-TVA-FIN.
           EXIT.
       SRL-TVA-END.
