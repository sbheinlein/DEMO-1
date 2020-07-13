     HNOMAIN
      /COPY MOD004_P
     P Multiplica      B                   EXPORT
     D                 PI            20P 5
     DFacteur1                       15P 5
     DFacteur2                       15P 5
     D*
     C                   return    Facteur1 * Facteur2
     P                 E
     P Divide          B                   EXPORT
     D                 PI            20P 5
     DFacteur1                       15P 5
     DFacteur2                       15P 5
     DRemainder                      15P 5 OPTIONS(*NOPASS)
     D*
     DResultat         S             20P 5
     DRemaind          S             15P 5
     C     Facteur1      DIV       facteur2      Resultat
     C                   MVR                     Remaind
     C                   if        %PARMS > 2
     C                   EVAL      Remainder = remaind
     C                   endif
     C                   return    Resultat
     P                 E
