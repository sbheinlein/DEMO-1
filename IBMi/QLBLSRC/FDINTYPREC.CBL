      ****************************************************************
      * APPLICATION NAME...........: . ALL APPLICATIONS              *
      * COPY NAME..................: . FDINTYPREC                    *
      * TYPE OF COPY...............: . DEFINITION GENERAL FIELD      *
      * FUNCTION...................: . DESCRIPTION INFODI            *
      *         .                        TYPE OF RECEPTION           *
      * OTHER COPIES REQUIRED......: .                               *
      *         .                                                    *
      * COPY LOCATION..............: . INPUT-OUTPUT SECTION          *
      ****************************************************************
M01?V  01  FDIN-TYPREC.
           05  FDIN-TYPREC-CLEF.
               10  FDIN-TYPREC-CLEF-GEN  PIC X(18).
               10  FDIN-TYPREC-CLEF-TYP  PIC X(2).
      *****  LIBELLE RECEPTION                                   21,20
           05  FDIN-TYPREC-LIB           PIC X(20).
      *****  LIBELLE ETAT                                        41,15
           05  FDIN-TYPREC-ETYRC         PIC X(15).
      *****  ZONES RUPTURE ?                                     56,10
           05  FDIN-TYPREC-RCIDR         PIC X(2).
           05  FDIN-TYPREC-RAPP          PIC X(2).
           05  FDIN-TYPREC-RDEP          PIC X(2).
           05  FDIN-TYPREC-RRAY          PIC X(2).
           05  FDIN-TYPREC-RSEC          PIC X(2).
      *****  LIBELLE RUPTURE                                     66,30
           05  FDIN-TYPREC-LRUPT         PIC X(30).
      *****  ZONES AFFICHAGE ?                                   96,8
           05  FDIN-TYPREC-AVIG          PIC X(2).
           05  FDIN-TYPREC-APV           PIC X(2).
           05  FDIN-TYPREC-ATME          PIC X(2).
           05  FDIN-TYPREC-ATMG          PIC X(2).
      *****  NUMERO D'ENTREPOT OU MAGASIN                       104,2
           05  FDIN-TYPREC-NOCID         PIC X(2).
      *****  LIBELLE ECRAN                                      106,8
           05  FDIN-TYPREC-STYRC         PIC X(8).
      *****  ZONES GESTION   ?                                  114,11
           05  FDIN-TYPREC-GCIDR         PIC X.
           05  FDIN-TYPREC-GNENT         PIC X.
           05  FDIN-TYPREC-GAPP          PIC X.
           05  FDIN-TYPREC-GDEP          PIC X.
           05  FDIN-TYPREC-GRAY          PIC X.
           05  FDIN-TYPREC-GSEC          PIC X.
           05  FDIN-TYPREC-GCID          PIC X.
           05  FDIN-TYPREC-GVIG          PIC X.
           05  FDIN-TYPREC-GPV           PIC X.
           05  FDIN-TYPREC-GTME          PIC X.
           05  FDIN-TYPREC-GTMG          PIC X.
      *****  NB MOIS BON                                        125,2
           05  FDIN-TYPREC-NBMMB         PIC X(2).
      *****  NB MOIS FACTURE                                    127,2
           05  FDIN-TYPREC-NBMMF         PIC X(2).
      *****  CODE TVA SUR VIGNETTE                              129,2
           05  FDIN-TYPREC-TVAVG         PIC X(2).
      *****  CODE ECART FACTURE                                 131,2
           05  FDIN-TYPREC-ECAFT         PIC X(2).
      *****  LIMITE NUMERO D'ORDRE                              133,5
           05  FDIN-TYPREC-MNORD         PIC X(5).
      *****  LIMITE LIGNE                                       138,3
           05  FDIN-TYPREC-MLIG          PIC X(3).
      *****  DEBUT DES NUMERO D'ORDRE BIDONS                    141,5
           05  FDIN-TYPREC-NORD          PIC X(5).
      *****  EDITION DES ARRONDIS                               146,2
           05  FDIN-TYPREC-ARPRT         PIC X(2).
      *****  RECEPTIONS : MOINS                                 148,2
           05  FDIN-TYPREC-MOINS         PIC X(2).
      *****  RECEPTIONS : PLUS                                  150,2
           05  FDIN-TYPREC-PLUS          PIC X(2).
      *****  RECEPTIONS : PA / PR MAXI                          152,5
           05  FDIN-TYPREC-PA-SUR-PR.
               10  FDIN-TYPREC-PA-SUR-PR9   PIC 9(3)V9(2).
      *****  RECEPTIONS : PR / PA MAXI                          157,5
           05  FDIN-TYPREC-PR-SUR-PA.
               10  FDIN-TYPREC-PR-SUR-PA9   PIC 9(3)V9(2).
      *****  RECEPTIONS : MAJ DIFFEREES                         162,1
           05  FDIN-TYPREC-DIFFERE       PIC X.
      *****  RECEPTIONS : AFFICHAGE SFL ECRAN 2                 163,1
           05  FDIN-TYPREC-AFFSFL        PIC X.
      *****  RECEPTIONS : CONFORMITE DIRECTE PAR F5             164,1
           05  FDIN-TYPREC-CONFOR        PIC X.
      *****  RECEPTIONS : CONFIRMATION DES RECEPTIONS           165,1
           05  FDIN-TYPREC-CONFIRME      PIC X.
      *****  RECEPTIONS : GESTION PAR ENTREPOT SECONDAIRE       166,1
           05  FDIN-TYPREC-GESTION-NENT  PIC X.
      *****  DEFAUT EMBALLAGES : N=NON CONSIGNES, C=CONSIGNES   167,1
           05  FDIN-TYPREC-DEFAUT-EMB    PIC X.
      *****  CONTROLE RAYON UNIQUE ?                            168,1
           05  FDIN-TYPREC-RAY-UNIQUE    PIC X.
      *****  CONTROLE RAYON EMBALLAGE ?                         169,1
           05  FDIN-TYPREC-RAY-EMBAL     PIC X.
      *****  DATE DE DATE : F SI DATE FACTURE                   170,1
           05  FDIN-TYPREC-TYPE-DATE     PIC X.
      *****  DATE DE DATE : O SI REGROUPEMENT RAYONS DIFFER.    171,1
           05  FDIN-TYPREC-REGROUPE-RAY  PIC X.
      *****  SAISIE REGIE : O SI SAISIE REGIE A LA RECEPTION    172,1
           05  FDIN-TYPREC-SAISIE-REGIE  PIC X.
      *****  RECEPTION POSSIBLE SI EMPLACEMENT = BLANC ????     173,1
           05  FDIN-TYPREC-EMPL-BLANC    PIC X.
      *****  OUTQ SPECIFIQUE A UN TYPE DE RECEPTION             174,10
           05  FDIN-TYPREC-OUTQ          PIC X(10).
      *****  LG FAMILLE  2 OU 3                                 184,1
           05  FDIN-TYPREC-LGFAM         PIC X.
      *****  CREATION DE DUPLICATAS DE SLIMS  O/N               185,1
           05  FDIN-TYPREC-DUPLIQ-SLIM   PIC X.
      *****  INTERVALLE DE DATE DE FACTURE POUR COF             186,4
           05  FDIN-TYPREC-FACT-INF      PIC X(2).
           05  FDIN-TYPREC-FACT-SUP      PIC X(2).
      *****  SAISIE DU MAGASIN LIVRE / LIGNE                    190,1
      *****     O = OBLIGATOIRE  ,  F = FACULTATIF  ,  9 = SI 9996X
      *****     6 = SI 9996X AVEC CONTROLE REGION GEO
           05  FDIN-TYPREC-MAGLIG        PIC X(1).
      *****  MONTANT MAXIMUM COMPTEUR TRANSPORT                 191,1
      *****  SI 6 MAXI = 999999F99  SINON 99999F99
           05  FDIN-TYPREC-MAXITRS       PIC X(1).
      *****  MONTANT MAXIMUM FACTURE                            192,1
      *****  SI 6 MAXI = 999999F99  SINON 99999999F99
           05  FDIN-TYPREC-MAXIFACT      PIC X(1).
      *****  GESTION DES NOUVEAUX FICHIERS COMMANDES  O/N       193,1
           05  FDIN-TYPREC-FCX           PIC X(1).
      *****  REGLEMENT MANUEL POUR FOURNISSEURS CEE   O/N       194,1
      *****       N POUR DFO (TIGRE)
           05  FDIN-TYPREC-MANCEE        PIC X(1).
      *****  SAISIE POSSIBLE A LA FAMILLE            O/N       195,1
      *****    SI = N, ON PEUT JUSTE SAISIR QTE = 1 ET PA = 0,001
      *****            POUR PAYER LE TRANSPORT ET LES TAXES
           05  FDIN-TYPREC-SAIFAM        PIC X(1).
      *****  APPEL A LA CALCULETTE POSSIBLE          O/N       196,1
           05  FDIN-TYPREC-APPEL-CALC    PIC X(1).
      *                                                        197,60
           05  FILLER                    PIC X(60).
      *
