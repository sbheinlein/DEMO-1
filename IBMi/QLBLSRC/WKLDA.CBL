      ****************************************************************
      *                                                              *
      * APPLICATION NAME...........: . ALL APPLICATIONS              *
      * COPY NAME..................: . WKLDA                         *
      * COPY TYPE..................: . DEFINITION GENERAL FIELD      *
      * FUNCTION...................: . IMAGE OF THE LDA              *
      *         .                                                    *
      * OTHER COPIES REQUIRED......: .                               *
      *         .                                                    *
      * COPY LOCATION..............: . WORKING-STORAGE               *
      *         .                                                    *
      * UTILISATION................: .                               *
      *         .  ACCEPT WKLDA FROM LDA.                            *
      *                 (LDA DESCRIBED IN SPECIAL-NAMES)             *
      ****************************************************************
       01  WKLDA.
           05        LDA-GENERAL.
      *********  TYPE DE FICHIER FOURNISSEUR     1,1
             10      LDA-FOUR           PIC X.
      *********  TYPE DE FICHIER CLIENT          2,1
             10      LDA-CLI            PIC X.
      *********  TYPE DE FICHIER ARTICLE         3,1
             10      LDA-ART            PIC X.
      *********  MODE : V=VISUEL                 4,1
             10      LDA-MODE           PIC X.
      *********  MODE : M=CONTROLE MODULO        5,1
             10      LDA-MODULO         PIC X.
      *********  TYPE TRAITEMENT : (J)our (H)ebdo (M)ens (A)n (E)xcep
      *********                                  6,1
             10      LDA-FREQ           PIC X.
      *********  TYPE PRODUIT : FR=frais PG=PGC  7,2
             10      LDA-PRODUIT        PIC XX.
      *********  MOIS                            9,2
             10      LDA-MOIS.
              15     LDA-MOIS9          PIC 99.
      *********  SEMAINE                        11,2
             10      LDA-SEM.
              15     LDA-SEM9           PIC 99.
      *********  RENSEIGNEMENTS SOCIETE         13,8
             10      LDA-NOMSOC         PIC X(3).
                 88  LDA-COURNON      VALUE "COU".
                 88  LDA-TOURS        VALUE "TOU".
                 88  LDA-EMER         VALUE "EMR".
                 88  LDA-BLANQ        VALUE "BLQ".
             10      LDA-CNUD           PIC X(3).
             10      LDA-STE            PIC X(2).
      *********  RENSEIGNEMENTS CENTRE D'ACTIVITE  21,7
             10      LDA-CID            PIC X(5).
             10      LDA-NOENTR         PIC XX.
      *  EX    ANG=ANGOULEME                       28,3
             10      LDA-NOMENT         PIC X(3).
      *  FORMAT D'EDITION DU SLIM POUR BASCULER 6->10  ' '/'X'    31,1
             10      LDA-NEWSLIM        PIC X(1).
      *  NOM DU SITE (ORDINATEUR)         32,8         ' '/'X'
             10      LDA-ORDI           PIC X(8).
      *  TYPE DE LIVRAISON : LE OU LD     40,2         LE/LD
             10      LDA-LELD           PIC X(2).
      *  ENVIRONNEMENT PROMO  ?           42,3         '   '/'PRM'
             10      LDA-PROM           PIC X(3).
      *  TYPE D'INTERFACE                 45,3         '   '/'HAD'
             10      LDA-INTERFACE      PIC X(3).
      *  SITE ASSOCIE                     48,8
             10      LDA-SITE-ASSOCIE   PIC X(8).
      *  TRIGRAMME ENTREPOT               56,3
             10      LDA-TRIG           PIC X(3).
      *  ORIGINE CODIF POUR BDLF          59,2
             10      LDA-ORIG-BDLF      PIC X(2).
      *                                   61,40
             10      FILLER             PIC X(40).
      *********  JOB AYANT LANCE UN SUBMIT        101,26
             10      LDA-JOB            PIC X(10).
             10      LDA-USER           PIC X(10).
             10      LDA-NBR            PIC X(6).
      *********  AFFICHAGE MESSAGE INTERACTIF     127,1
      *********           SI 'N' PAS D'AFFICHAGE
             10      LDA-AFFICH-INTER   PIC X(1).
      *********  PARAMETRES TEMPORELS
      *                                           128,10
      *********  ANNEE
             10      LDA-DT-AN          PIC X(2).
      *********  MOIS
             10      LDA-DT-MOIS        PIC X(2).
      *********  SEMAINE
             10      LDA-DT-SEM         PIC X(2).
      *********  QUANTIEME
             10      LDA-DT-QQQ         PIC X(3).
      *********  JOUR DANS SEMAINE
             10      LDA-DT-J           PIC X(1).
      *********  DECODIF MULTISITE O = OUI N = NON  138,1
             10      LDA-MULTISITE      PIC X(1).
      *                                           139,374
             10      FILLER             PIC X(374).
      *
