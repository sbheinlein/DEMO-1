      *%CSTD===========================================================*
      ** Application. : SQL SQL Demo Application                       *
      ** Component. . : ADD10                         Type: SQLRPGLE   *
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
      ** MODIFS: 01 RBERNARDI  05/14/2008 11:03  V 1.00.C MR £ 08/0055 *
      **           Test a change                                       *
      *%ECSTD==========================================================*
     dcounter          s             10i 0 inz
     dname             s             10a   inz( 'ADDSQL' )
     C*
     C                   for       counter=1 to 10
     C*
     C/exec sql
     C+ insert into demo_sql/custmast
     C+ ( cuid , cuname )
     C+ values( :counter , :name )
     C/end-exec
     C*
     C                   endfor
     C*
     C                   seton                                        lr
