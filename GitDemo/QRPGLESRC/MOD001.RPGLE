      *%CSTD===========================================================*
      ** Application. : RWB        (DEMO)Ray Bernardi                  *
      ** Component. . : MOD001                        Type: RPGLE      *
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
      ** MODIFS: ** RBERNARDI  11/13/2015 20:38  V 1.01.N MR 15/   58  *
      **           short desc                                          *
      **         01 RBERNARDI  11/13/2015 17:25  V 1.01.M MR 15/   57  *
      **           Ray testing                                         *
      *%ECSTD==========================================================*
      /COPY MOD002_P
      /COPY MOD004_P
     DValeur           S             15P 5
     D V1              S             15P 5
     D V2              S             15P 5
     C                   eval      V1 = 15
     C                   eval      V2 = 45
     C                   eval      Valeur = addition(V1:V2)
     C     Valeur        DSPLY
     C                   eval      Valeur = Multiplica(V1:V2)
     C     Valeur        DSPLY
     C                   Move      '1'           *INLR
