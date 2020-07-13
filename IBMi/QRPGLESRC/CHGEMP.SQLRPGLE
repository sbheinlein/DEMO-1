      *%CSTD===========================================================*
      ** Application. : RWB RWB Demo Application                       *
      ** Component. . : CHGEMP                        Type: SQLRPGLE   *
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
      ** MODIFS: 01 JTICKNER   04/11/2013 09:30  V 1.03.F MR # 13/0004 *
      **           test for demo                                       *
      *%ECSTD==========================================================*
     dcounter          s             10i 0 inz
     C*
     C                   for       counter=1 to 10
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
