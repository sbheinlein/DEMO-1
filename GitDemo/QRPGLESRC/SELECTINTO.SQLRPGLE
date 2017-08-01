000100080507     dcustDS           ds
000200080507     d  cuid                         10A   varying
000300080507     d  cuname                       25A
000400080507     C*
000500080507     C/exec sql
000600080507     C+ select trim(char(cuid)), cuname
000700080507     C+   into :custDS
000800080507     C+   from demo_sql/custmast
000900080507     C/end-exec
001000080507     C*
001100080507     C                   seton                                        lr
