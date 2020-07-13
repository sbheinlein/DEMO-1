      ****************************************************************
      *                                                              *
      * APPLICATION NAME...........: . ALL APPLICATIONS              *
      * COPY NAME..................: . WKMESSAGE                     *
      * COPY TYPE..................: . DEFINITION GENERAL FIELD      *
      * FUNCTION...................: . CALL PARAMETERS TO WORK       *
      *         .                        WITH BATCH MESSAGES         *
      * OTHER COPIES REQUIRED......: .                               *
      *         .                                                    *
      * COPY LOCATION..............: . WORKING-STORAGE               *
      *         .                                                    *
      * UTILISATION................: .                               *
      *         .  IF THERE ARE NO SUBSTITUTION VARIABLES, PUT       *
      *         .    SPACE     IN   WK-MESSAGE-LIB                   *
      *         .  IF IT IS NOT A QUESTION, PUT SPACE IN             *
      *         .    WK-MESSAGE-REP ELSE  "*INQ"                     *
      *         .                                                    *
      *         .  MOVE "XXX99999" TO WK-MESSAGE-NO                  *
      *         .  MOVE SPACE      TO WK-MESSAGE-LIB                 *
      *         .  MOVE SPACE      TO WK-MESSAGE-REP                 *
      *         .                                                    *
      *         .  CALL "ACLMG100" USING WK-MESSAGE                  *
      *         .                                                    *
      * PARAMETRE(S) EN ENTREE.....: .                               *
      *         . WK-MESSAGE-NO    7  NUMEROS DE MESSAGES            *
      *         . WK-MESSAGE-LIB 121  VARIABLES DE SUBSTITUTION      *
      *         . WK-MESSAGE-REP 128  SPACE OU "*INQ"                *
      * PARAMETRE(S) EN SORTIE.....: .                               *
      *         . WK-MESSAGE-REP 128  REPONSE                        *
      *                                                              *
      ****************************************************************
       01  WK-MESSAGE VALUE SPACE.
           10      WK-MESSAGE-NO        PIC X(7).
           10      WK-MESSAGE-LIB       PIC X(121).
           10      WK-MESSAGE-REP       PIC X(128).
      ****************************************************************
      * FONCTION...................: . TABLES DES MESSAGES PROGRAMME *
      ****************************************************************
       01  WK-TABLMSG.
           05      FILLER               PIC X(128) VALUE SPACE.
       01  WK-RTABLMSG  REDEFINES  WK-TABLMSG.
           05      WK-TMSG-PST          OCCURS    1 INDEXED BY IN-TMSG.
               10  WK-TMSG-NO           PIC X(7).
               10  WK-TMSG-LIB          PIC X(121).
      *
