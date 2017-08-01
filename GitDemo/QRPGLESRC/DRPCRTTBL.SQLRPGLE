000100080507     C*
000200080507     C* Drop Table
000300080507     C/exec sql
000400080507     C+ drop table demo_sql/custmast
000500080507     C/end-exec
000600080507     C*
000700080507     C* Create Table
000800080507     C/exec sql
000900080507     C+ create table demo_sql/custmast
001000080507     C+ ( cuid char(5) not null with default ,
001100080507     C+   cuname char(10) not null with default )
001200080507     C/end-exec
001300080507     C*
001400080507     C                   seton                                        lr
