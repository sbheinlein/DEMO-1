      ****************************************************************
      * APPLICATION NAME...........: . ALL APPLICATIONS              *
      * COPY NAME..................: . SRMSGBATCH                    *
      * TYPE OF COPY...............: . SUB-ROUTINE  (PERFORM)        *
      * FUNCTION...................: . WORK WITH BATCH MESSAGES      *
      *         .                                                    *
      * OTHER REQUIRED COPIES......: . WKMSGBATCH       IN WORKING   *
      *         .                                                    *
      * COPY LOCATION..............: . PROCEDURE                     *
      *         .                                                    *
      * INPUT PARAMETERS...........: .                               *
      *         . WK-MESSAGE-NO  WK-MESSAGE-LIB                      *
      *         . WK-MESSAGE-REP   = BLANK OR "*INQ"                 *
      * OUTPUT PARAMETERS..........: .                               *
      *         . WK-MESSAGE-REP   ...... THE REPLY                  *
      ****************************************************************
      *
       AFF-MESSAGE.
           CALL     "ACLMG100"            USING   WK-MESSAGE.
           MOVE     SPACE                 TO      WK-MESSAGE-NO.
           MOVE     SPACE                 TO      WK-MESSAGE-LIB.
       AFF-MESSAGE-EXIT.
           EXIT.
      *
       TILT.
           IF WK-MESSAGE-NO = SPACE
              MOVE "XXX0101"           TO  WK-MESSAGE-NO
              MOVE SPACE               TO  WK-MESSAGE-REP.
           PERFORM AFF-MESSAGE         THRU  AFF-MESSAGE-EXIT.
           SET     SW0    TO  ON.
           STOP   RUN.
      *
