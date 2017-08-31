      *%CSTD===========================================================*
      ** Application. : RWB Ray's Demo Application                     *
      ** Component. . : DLTEMP                        Type: SQLRPGLE   *
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
      ** AUTHOR:    RBERNARDI  09/25/2008 14:45  V 8.06.V              *
      ** MODIFS: ** RBERNARDI  09/25/2008 14:45  V 8.06.V MR # 08/0107 *
      **           Raven demo                                          *
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
