      /COPY MOD002_P
      /COPY MOD004_P
     DValeur           S             15P 5
     D V1              S             15P 5
     D V2              S             15P 5
     D V3              S             15P 5
     C                   eval      V1 = 15
     C                   eval      V2 = 45
     C                   eval      Valeur = addition(V1:V2)
     C     Valeur        DSPLY
     C                   eval      V1 = 15
     C                   eval      V2 = 11
     C                   eval      Valeur = divide(V1:V2)
     C     Valeur        DSPLY
     C                   eval      Valeur = divide(V1:V2:V3)
     C     Valeur        DSPLY
     C                   Move      '1'           *INLR
