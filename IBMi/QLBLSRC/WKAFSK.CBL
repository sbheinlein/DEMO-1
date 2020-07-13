      ****************************************************************
      *                                                              *
      * APPLICATION NAME...........: . APPLICATIONS WITH THE PF BPFSK*
      * COPY NAME..................: . WKAFSK                        *
      * TYPE OF COPY...............: . DEFINITION WORKING            *
      * FUNCTION...................: . CENTURY FIELDS FOR DATES IN   *
      *         .                      FILE BPFSK                    *
      * OTHER COPIES REQUIRED......: . ASSOCIATED  TO SRAFSKI        *
      *         .                            AND SRAFSKO             *
      * COPY LOCATION..............: . WORKING-STORAGE               *
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
       01  WK-BPFSK VALUE SPACES.
      *
      *---<MODIFICATION DATE>--------------------------------------------------*
           05          WK-SKXXM-AAMMJJ.
              10       WK-SKAAM.
                 15    WK-SKAAM-1                 PIC X.
                 15    WK-SKAAM-2                 PIC X.
              10       WK-SKMMM                   PIC XX.
              10       WK-SKJJM                   PIC XX.
      *
           05          WK-SKXXM-SSAAMMJJ.
              10       WK-SKXXM-SS                PIC XX.
              10       WK-SKXXM-AAMMJJ-S.
                 15    WK-SKAAM-S.
                    20 WK-SKAAM-S-1               PIC X.
                    20 WK-SKAAM-S-2               PIC X.
                 15    WK-SKMMM-S                 PIC XX.
                 15    WK-SKJJM-S                 PIC XX.
      *
      **************************************************************************
      *
