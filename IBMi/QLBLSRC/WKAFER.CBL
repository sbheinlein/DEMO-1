      ****************************************************************
      *                                                              *
      * APPLICATION NAME...........: . APPLICATIONS WITH THE PF      *
      *                                BPFER                         *
      * COPY NAME..................: . WKAFER                        *
      * TYPE OF COPY...............: . DEFINITION WORKING            *
      * FUNCTION...................: . CENTURY FIELDS FOR DATES IN   *
      *         .                      FILE BPFER                    *
      * OTHER COPIES REQUIRED......: . ASSOCIATED TO SRAFERI         *
      *         .                            AND SRAFERO             *
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
       01  WK-BPFER VALUE SPACES.
      *
      *---<RECEPTION DATE>-----------------------------------------------------*
           05          WK-ERXXRC-AAMMJJ.
              10       WK-ERAARC.
                 15    WK-ERAARC-1                PIC X.
                 15    WK-ERAARC-2                PIC X.
              10       WK-ERMMRC                  PIC XX.
              10       WK-ERJJRC                  PIC XX.
      *
           05          WK-ERXXRC-SSAAMMJJ.
              10       WK-ERXXRC-SS               PIC XX.
              10       WK-ERXXRC-AAMMJJ-S.
                 15    WK-ERAARC-S.
                    20 WK-ERAARC-S-1              PIC X.
                    20 WK-ERAARC-S-2              PIC X.
                 15    WK-ERMMRC-S                PIC XX.
                 15    WK-ERJJRC-S                PIC XX.
           05    WK-ERXXRC-SSAAMMJJR REDEFINES WK-ERXXRC-SSAAMMJJ.
              10       WK-ERXXRC-SSAA-S           PIC 9(4).
              10       WK-ERXXRC-MMJJ-S           PIC 9(4).
      *
      **************************************************************************
      *
