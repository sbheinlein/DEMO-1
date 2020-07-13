      *%CSTD===========================================================*
      ** Application. : RWB        Rays demo app                       *
      ** Component. . : ADDEMP                        Type: SQLRPGLE   *
      **===============================================================*
      ** Sub-system . :                                                *
      ** Function . . :                                                *
      ** Sub-function :                                                *
      **%S=============================================================*
      ** Description of functions:                                     *
      **                                                               *
      **                                                               *
      **                                                               *
      **%E=============================================================*
      ** AUTHOR:                          00:00                        *
      ** MODIFS: ** RBERNARDI  07/06/2017   :    00.00.06    00/       *
      **         ** RBERNARDI  07/06/2017   :    00.00.02 MR 00/       *
      *%ECSTD==========================================================*
     dcounter          s             10i 0 inz
     C*
     C                   for       counter=1 to 10
     C*
     C*
     C/exec sql
     C+ insert into demo_sql/employee
     C+ (empno)
     C+ values( :counter )
     C/end-exec
     C*
     C                   endfor
     C*
     C                   seton                                        lr
