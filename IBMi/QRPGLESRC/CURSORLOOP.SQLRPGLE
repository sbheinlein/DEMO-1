     d custDS          ds                  occurs(10)
     d  cuid                         10A   varying
     d  cuname                       25A
     C*
     C/exec sql
     C+ declare custCursor Cursor
     C+   for
     C+ select trim(char(cuid)), cuname
     C+   from demo_sql/custmast
     C/end-exec
     C*
     C/exec sql
     C+ open custCursor
     C/end-exec
     C*
     C/exec sql
     C+ fetch next
     C+   from custCursor
     C+   into :custDS
     C/end-exec
     C*
     C     sqlstt        dsply
     C                   dow       SQLSTT = '00000'
     C     custDS        dsply
     C*                  endfor
     C/exec sql
     C+ fetch next
     C+   from custCursor
     C+   into :custDS
     C/end-exec
     C*
     C                   enddo
     C*
     C                   seton                                        lr
