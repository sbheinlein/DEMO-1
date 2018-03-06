     /*%CSTD===========================================================*      */
     /** Application. : RWB        (DEMO)Ray Bernardi                  *      */
     /** Component. . : HSC200                        Type: CLP        *      */
     /**===============================================================*      */
     /** Sub-system . :                                                *      */
     /** Function . . :                                                *      */
     /** Sub-function :                                                *      */
     /**%S=============================================================*      */
     /** Description of functions:                                     *      */
     /**                                                               *      */
     /**               change   again                                  *      */
     /**                                                               *      */
     /**%E=============================================================*      */
     /** AUTHOR:                          00:00                        *      */
     /** MODIFS: 02 RBERNARDI  11/12/2015 16:15  V 1.01.L MR 15/   57  *      */
     /**           Ray testing                                         *      */
     /**         01 GGIBSON    02/10/2015 18:53  V 1.00.I MR 15/    6  *      */
     /**           Test For Weird Characters                           *      */
     /**         ** RBERNARDI  11/12/2015   :    V 1.00.G MR 15/    6  *      */
     /*%ECSTD==========================================================*      */
/********************************************************************/
/* Program     : HSC200                                             */
/* Purpose     : Sales Order Processing.                            */
/* System      : HSV - Voucher Tracking and Control                 */
/* Date        : February 1999                                      */
/********************************************************************/

             PGM        PARM(&MODE &ORDER &TYPE &CUST &test)
             DCL        VAR(&MODE) TYPE(*CHAR) LEN(1)
             DCL        VAR(&TEST) TYPE(*CHAR) LEN(1)
             DCL        VAR(&MODEA) TYPE(*CHAR) LEN(1)
             DCL        VAR(&ORDER) TYPE(*CHAR) LEN(8)
             DCL        VAR(&CUST) TYPE(*CHAR) LEN(3)
             DCL        VAR(&TYPE) TYPE(*CHAR) LEN(8)
             DCL        VAR(&TYPS) TYPE(*CHAR) LEN(8)
             OVRDBF     FILE(ALTCUSTA) TOFILE(HSLCUSTA)
             CALL       PGM(HSR200) PARM(&MODE &ORDER &TYPE +
                          &CUST &TEST)
             DLTOVR     FILE(ALTCUSTA)
             ENDPGM
