000100080507     dcounter          s             10i 0 inz
000200080507     C*
000300080507     C                   for       counter=1 to 10
000400080507     C*
000500080507     C/exec sql
000600080507     C+ insert into demo_sql/custmast
000700080507     C+ (cuid)
000800080507     C+ values( :counter )
000900080507     C/end-exec
001000080507     C*
001100080507     C                   endfor
001200080507     C*
001300080507     C                   seton                                        lr
