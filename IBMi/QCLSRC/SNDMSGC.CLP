/********************************************************************/
/*     Title         : Send message to program message queue.       */
/*     System        : HSV Control & Tracking                       */
/*     Author        : Tim Jefford                                  */
/*     Date          : January 1999                                 */
/********************************************************************/
             PGM        PARM(&PGMID &TOPGMQ &MSGID &MSGF &MSGDTA +
                          &MSGTYPE)
 
             DCL        VAR(&PGMID) TYPE(*CHAR) LEN(10)
             DCL        VAR(&TOPGMQ) TYPE(*CHAR) LEN(5)
             DCL        VAR(&MSGID) TYPE(*CHAR) LEN(7)
             DCL        VAR(&MSGF) TYPE(*CHAR) LEN(10)
             DCL        VAR(&MSGDTA) TYPE(*CHAR) LEN(132)
             DCL        VAR(&MSGTYPE) TYPE(*CHAR) LEN(7)
 
             SNDPGMMSG  MSGID(&MSGID) MSGF(*LIBL/&MSGF) +
                          MSGDTA(&MSGDTA) TOPGMQ(&TOPGMQ) +
                          MSGTYPE(&MSGTYPE)
 
             ENDPGM
