     dcounter          s             10i 0 inz
     C*
     C/exec sql
     C+ select count(*)
     C+   into :counter
     C+   from demo_sql/custmast
     C/end-exec
     C*
     C     counter       dsply
     C                   seton                                        lr
      *%CSTD===========================================================*
      ** Application. : RWB Ray's Demo Application                     *
      ** Composant. . : MOD001                        Type: RPGLE      *
      **===============================================================*
      ** Sous-système : ACC Accounting                                 *
      ** Fonction . . :                                                *
      ** Sous-fonction:                                                *
      **%S=============================================================*
      ** Description des fonctionnalités:                              *
      **     ddddd                                                     *
      **                                                               *
      **                                                               *
      **%E=============================================================*
      ** AUTEUR:                          00:00                        *
      ** MODIFS: 23 RBERNARDI  06/05/2008 11:48  V 8.05.P FM N°08/0063 *
      **           unit of work                                        *
      **         ** RBERNARDI  06/05/2008   :    V 8.05.O    N°00/     *
      **         ** RBERNARDI  06/05/2008   :    V 8.05.M    N°00/     *
      **         ** RBERNARDI  06/05/2008   :    V 8.05.L    N°00/     *
      **         22 RBERNARDI  05/23/2008 15:53  V 8.05.K FM N°08/0058 *
      **           Make a change to Native and IFS componrents         *
      **         ** RBERNARDI  06/05/2008   :    V 8.05.I    N°00/     *
      **         21 RBERNARDI  05/06/2008 09:47  V 8.05.C FM N°08/0052 *
      **           Multi platform change demo                          *
      **         20 RBERNARDI  04/30/2008 14:37  V 8.04.Z FM N°08/0047 *
      **           2nd request                                         *
      **         ** RBERNARDI  06/05/2008   :    V 8.04.Y    N°00/     *
      **         ** RBERNARDI  06/05/2008   :    V 8.04.W    N°00/     *
      *%ECSTD==========================================================*
