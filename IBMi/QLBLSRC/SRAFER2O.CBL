      ****************************************************************
      *                                                              *
      * APPLICATION NAME...........: . APPLICATIONS WITH THE PF BPFER*
      * COPY NAME..................: . SRAFER2O                      *
      * TYPE OF COPY...............: . MODULE                        *
      * FUNCTION...................: . DATE WITH SYSTEM  HIGH VALUE  *
      *         .                      WRITING TO FILE BPFER         *
      * OTHER COPIES REQUIRED......: . WKAFER IN WORKING             *
      *         .                                                    *
      * COPY LOCATION..............: . PROCEDURE                     *
      *         .                                                    *
      * GLOBAL FIELDS TOUCHED......: .                               *
      *         .                                                    *
      * INPUT PARAMETERS...........: .                               *
      *         .                                                    *
      * OUTPUT PARAMETERS..........: .                               *
      *         .                                                    *
      *                                                              *
      ****************************************************************
      *
       SRAFER2O.
      *
      *---<RECEPTION DATE>-----------------------------------------------------*
           IF WK-ERXXRC-SS = "20"
              MOVE HIGH-VALUE    TO WK-ERAARC-1
              MOVE WK-ERAARC-S-2 TO WK-ERAARC-2
           ELSE
              MOVE WK-ERAARC-S TO WK-ERAARC
           END-IF
           MOVE WK-ERMMRC-S TO WK-ERMMRC
           MOVE WK-ERJJRC-S TO WK-ERJJRC
           MOVE WK-ERAARC TO ERAARC OF BPFER
           MOVE WK-ERMMRC TO ERMMRC OF BPFER
           MOVE WK-ERJJRC TO ERJJRC OF BPFER.
      *
       SRAFER2O-FIN.
           EXIT.
      *
