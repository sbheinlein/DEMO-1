      *%CSTD===========================================================*
      ** Application. : RWB Ray's Demo Application                     *
      ** Component. . : SQLEXMPL                      Type: SQLRPGLE   *
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
      ** AUTHOR:    RBERNARDI  03/05/2008 11:28  V 8.03.W              *
      ** MODIFS: ** RBERNARDI  03/05/2008 11:36  V 8.03.X MR £ 07/0058 *
      **           CR 07/0015 Show IFS capabilities                    *
      **         ** RBERNARDI  03/05/2008 11:28  V 8.03.W MR £ 08/0006 *
      **           cambiar                                             *
      *%ECSTD==========================================================*
     D********************
     D empno           S              5P 0
     D emplnm          S             25A
     D STMT            S            500A   INZ('SELECT emplnm          -
     D                                     FROM employee WHERE         -
     D                                     empno > 0')
     C/exec sql
     C+ prepare s1 from :stmt
     C/end-exec
     C*
     C/exec sql
     C+ DECLARE C1 CURSOR FOR S1
     C/end-exec
     C*
     C                   eval      empno=  1
     C*
     C/exec sql
     C+ open c1 using :empno
     C/end-exec
     C*
     C/exec sql
     C+ fetch c1 into :emplnm
     C/end-exec
     C*
     C/exec sql
     C+ close c1
     C/end-exec
     C*
     C                   seton                                        lr
