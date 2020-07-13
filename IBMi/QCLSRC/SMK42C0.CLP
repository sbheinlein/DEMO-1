             PGM        PARM(&ACTION &PCKNBR &PCK1 &PCK2 &PCK3 &PCK4 +
                          &PCKRET)
             DCL        VAR(&ACTION) TYPE(*CHAR) LEN(1)
             DCL        VAR(&PCKNBR) TYPE(*DEC) LEN(5 0)
             DCL        VAR(&PCK1) TYPE(*DEC) LEN(15 5)
             DCL        VAR(&PCK2) TYPE(*DEC) LEN(15 5)
             DCL        VAR(&PCK3) TYPE(*DEC) LEN(15 5)
             DCL        VAR(&PCK4) TYPE(*DEC) LEN(15 5)
             DCL        VAR(&PCKRET) TYPE(*DEC) LEN(15 5)
 
             CALL       PGM(SMK42R0) PARM(&ACTION &PCKNBR &PCK1 +
                          &PCK2 &PCK3 &PCK4 &PCKRET)
          /* Delete Activation Group */
             RCLACTGRP  ACTGRP(TEST)
             ENDPGM
