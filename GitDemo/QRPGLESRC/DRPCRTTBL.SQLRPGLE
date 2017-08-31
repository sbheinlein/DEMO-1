     C*
     C* Drop Table
     C/exec sql
     C+ drop table demo_sql/custmast
     C/end-exec
     C*
     C* Create Table
     C/exec sql
     C+ create table demo_sql/custmast
     C+ ( cuid char(5) not null with default ,
     C+   cuname char(10) not null with default )
     C/end-exec
     C*
     C                   seton                                        lr
