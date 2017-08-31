     d custDS          ds                  occurs(10)
     d  cuid                         10A   varying
     d  cuname                       25A
     d*
     d x               s             10i 0 inz
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
     C+   for 10 rows
     C+   into :custDS
     C/end-exec
     C*
     C                   for       x=1 to %elem( custDS )
     C                   eval      %occur( custDS ) = x
     C     custDS        dsply
     C                   endfor
     c*
     C                   seton                                        lr
