     dcustDS           ds
     d  cuid                         10A   varying
     d  cuname                       25A
     C*
     C/exec sql
     C+ select trim(char(cuid)), cuname
     C+   into :custDS
     C+   from demo_sql/custmast
     C/end-exec
     C*
     C                   seton                                        lr
