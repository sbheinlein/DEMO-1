000100080507     d custDS          ds                  occurs(10)
000200080507     d  cuid                         10A   varying
000300080507     d  cuname                       25A
000400080507     d*
000500080507     d x               s             10i 0 inz
000600080507     C*
000700080507     C/exec sql
000800080507     C+ declare custCursor Cursor
000900080507     C+   for
001000080507     C+ select trim(char(cuid)), cuname
001100080507     C+   from demo_sql/custmast
001200080507     C/end-exec
001300080507     C*
001400080507     C/exec sql
001500080507     C+ open custCursor
001600080507     C/end-exec
001700080507     C*
001800080507     C/exec sql
001900080507     C+ fetch next
002000080507     C+   from custCursor
002100080507     C+   for 10 rows
002200080507     C+   into :custDS
002300080507     C/end-exec
002400080507     C*
002500080507     C                   for       x=1 to %elem( custDS )
002600080507     C                   eval      %occur( custDS ) = x
002700080507     C     custDS        dsply
002800080507     C                   endfor
002900080507     c*
003000080507     C                   seton                                        lr
