000100080507     d custDS          ds                  occurs(10)
000200080507     d  cuid                         10A   varying
000300080507     d  cuname                       25A
000400080507     C*
000500080507     C/exec sql
000600080507     C+ declare custCursor Cursor
000700080507     C+   for
000800080507     C+ select trim(char(cuid)), cuname
000900080507     C+   from demo_sql/custmast
001000080507     C/end-exec
001100080507     C*
001200080507     C/exec sql
001300080507     C+ open custCursor
001400080507     C/end-exec
001500080507     C*
001600080507     C/exec sql
001700080507     C+ fetch next
001800080507     C+   from custCursor
001900080507     C+   into :custDS
002000080507     C/end-exec
002100080507     C*
002200080507     C     sqlstt        dsply
002300080507     C                   dow       SQLSTT = '00000'
002400080507     C     custDS        dsply
002500080507     C*                  endfor
002600080507     C/exec sql
002700080507     C+ fetch next
002800080507     C+   from custCursor
002900080507     C+   into :custDS
003000080507     C/end-exec
003100080507     C*
003200080507     C                   enddo
003300080507     C*
003400080507     C                   seton                                        lr
