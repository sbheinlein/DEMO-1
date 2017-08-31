     dcounter          s             10i 0 inz
     C*
     C                   for       counter=1 to 10
     C*
     C/exec sql
     C+ insert into demo_sql/custmast
     C+ (cuid)
     C+ values( :counter )
     C/end-exec
     C*
     C                   endfor
     C*
     C                   seton                                        lr
