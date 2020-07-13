      ****************************************************************
      *                                                              *
      * APPLICATION NAME...........: . APPLICATIONS WITH THE PF BPFSK*
      * COPY NAME..................: . SRAFSKO                       *
      * COPY TYPE..................: . MODULE                        *
      * FUNCTION...................: . DATE WITH SYSTEM HIGH VALUE   *
      *         .                      IN WRITING FOR FILE BPFSK     *
      * OTHER COPIES REQUIRED......: . WKAFSK IN WORKING             *
      *         .                                                    *
      * COPY LOCATION..............: . PROCEDURE                     *
      *         .                                                    *
      * GLOBAL FILEDS TOUCHED......: .                               *
      *         .                                                    *
      * INPUT PARAMETERS...........: .                               *
      *         .                                                    *
      * OUTPUT PARAMETERS..........: .                               *
      *         .                                                    *
      *                                                              *
      ****************************************************************
      *
       SRAFSK2O.
      *
      *---<MODIFICATION DATE>--------------------------------------------------*
           IF WK-SKXXM-SS = "20"
              MOVE HIGH-VALUE    TO WK-SKAAM-1
              MOVE WK-SKAAM-S-2 TO WK-SKAAM-2
           ELSE
              MOVE WK-SKAAM-S TO WK-SKAAM
           END-IF
           MOVE WK-SKMMM-S TO WK-SKMMM
           MOVE WK-SKJJM-S TO WK-SKJJM
           MOVE WK-SKAAM TO SKAAM OF SK-ENR-DDS
           MOVE WK-SKMMM TO SKMMM OF SK-ENR-DDS
           MOVE WK-SKJJM TO SKJJM OF SK-ENR-DDS.
       SRAFSK2O-FIN.
           EXIT.
      *
      *
      *
