000100990202/********************************************************************/
000200990202/* Program     : HSC731                                             */
000300990202/* Purpose     : Create OPNQRYF for Voucher Control file HSLVCTLA   */
000400990202/* System      : HSV - Voucher Tracking and Control                 */
000500990202/* Date        : January 1999                                       */
000600990202/********************************************************************/
000700990202
000800000728             PGM        PARM(&XPROD &XPROD1 &XPGMID &XUSRID &XJOBNO)
000900000728             DCL        VAR(&XPROD) TYPE(*CHAR) LEN(13)
001000000728             DCL        VAR(&XPROD1) TYPE(*CHAR) LEN(13)
001100000728             DCL        VAR(&XPGMID) TYPE(*CHAR) LEN(10)
001200000728             DCL        VAR(&XUSRID) TYPE(*CHAR) LEN(10)
001300000728             DCL        VAR(&XJOBNO) TYPE(*CHAR) LEN(10)
001400990202             OVRDBF     FILE(HSLVCTLA) SHARE(*YES)
001500990202             OPNQRYF    FILE((HSLVCTLA)) QRYSLT('(''BPROD *GE ''" +
001600000728                          *CAT ''&XPROD1'' *CAT "'' '')') +
001700990202                          KEYFLD((BPROD)) SEQONLY(*NO) +
001800990202                          OPTIMIZE(*FIRSTIO 12)
001900990202   /*        OPNQRYF    FILE((HSLVCTLA)) QRYSLT('BPROD = %RANGE(' || + */
002000990202 /*              "'&£PROD'" |> "'&£PROD1'" || ')') KEYFLD((BPROD)) +   */
002100990202 /*                       SEQONLY(*NO) OPTIMIZE(*FIRSTIO 12)           */
002200990202             CPYFRMQRYF FROMOPNID(HSLVCTLA) TOFILE(*PRINT)
002300000728             CALL       PGM(HSR735) PARM(&XPROD &XPROD1 &XPGMID +
002400000728                          &XUSRID &XJOBNO)
002500990202             DLTOVR     FILE(HSLVCTLA)
002600990202             CLOF       OPNID(HSLVCTLA)
002700990202                          ENDPGM
