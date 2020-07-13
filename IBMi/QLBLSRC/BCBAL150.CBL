       IDENTIFICATION DIVISION.
       PROGRAM-ID. BCBAL150.
      /
      ***********************
       ENVIRONMENT DIVISION.
      ***********************
      *
       CONFIGURATION SECTION.
      ***********************
      *
       SOURCE-COMPUTER. IBM-S38.
       OBJECT-COMPUTER. IBM-S38.
       COPY WSPECNAMES.
      *
       INPUT-OUTPUT SECTION.
       FILE-CONTROL.
           SELECT  BPFALZA
                   ASSIGN       TO DATABASE-BLFALZA1
                   ORGANIZATION IS INDEXED
                   ACCESS       IS DYNAMIC
                   RECORD KEY   IS EXTERNALLY-DESCRIBED-KEY
                   WITH DUPLICATES
                   FILE STATUS  IS ST.
      *
           SELECT  APFCC
                   ASSIGN       TO DATABASE-APFCC
                   ORGANIZATION IS INDEXED
                   ACCESS       IS DYNAMIC
                   RECORD KEY   IS EXTERNALLY-DESCRIBED-KEY
                   FILE STATUS  IS ST.
      *
           SELECT  ZPFFR
                   ASSIGN       TO DATABASE-ZPFFR
                   ORGANIZATION IS INDEXED
                   ACCESS       IS DYNAMIC
                   RECORD KEY   IS EXTERNALLY-DESCRIBED-KEY
                   FILE STATUS  IS ST.
      *
           SELECT  BPFAR100
                   ASSIGN       TO DATABASE-BPFAR100
                   ORGANIZATION IS INDEXED
                   ACCESS       IS DYNAMIC
                   RECORD KEY   IS EXTERNALLY-DESCRIBED-KEY
                   FILE STATUS  IS ST.
      *
           SELECT  BPFERM61
                   ASSIGN       TO DATABASE-BPFERM61
                   ORGANIZATION IS INDEXED
                   ACCESS       IS DYNAMIC
                   RECORD KEY   IS EXTERNALLY-DESCRIBED-KEY
                   FILE STATUS  IS ST.
      *
           SELECT  BPFER
                   ASSIGN       TO DATABASE-BPFER
                   ORGANIZATION IS INDEXED
                   ACCESS       IS DYNAMIC
                   RECORD KEY   IS EXTERNALLY-DESCRIBED-KEY
                   FILE STATUS  IS ST.
      *
           SELECT  BPFDR
                   ASSIGN       TO DATABASE-BPFDR
                   ORGANIZATION IS INDEXED
                   ACCESS       IS DYNAMIC
                   RECORD KEY   IS EXTERNALLY-DESCRIBED-KEY
                             WITH DUPLICATES
                   FILE STATUS  IS ST.
      *
           SELECT  BPFSK
                   ASSIGN       TO DATABASE-BPFSK
                   ORGANIZATION IS INDEXED
                   ACCESS       IS DYNAMIC
                   RECORD KEY   IS EXTERNALLY-DESCRIBED-KEY
                                   WITH DUPLICATES
                   FILE STATUS  IS ST.
      *
           SELECT  FINFODI
                   ASSIGN       TO DATABASE-ALFIN1
                   ORGANIZATION IS INDEXED
                   ACCESS       IS DYNAMIC
                   RECORD KEY   IS EXTERNALLY-DESCRIBED-KEY
                   FILE STATUS  IS ST.
      *
           SELECT  BPFALANO
                   ASSIGN       TO DATABASE-BPFALAAO
                   ORGANIZATION IS SEQUENTIAL
                   ACCESS       IS SEQUENTIAL
                   FILE STATUS  IS ST.
      *
      /
       DATA    DIVISION.
       FILE    SECTION.
      *
       FD  BPFALZA   LABEL RECORD STANDARD.
       01  AZ-ENR-DDS.
           COPY DDS-ALL-FORMAT OF BLFALZA1.
      *
       FD  APFCC     LABEL RECORD STANDARD.
       01  CC-ENR-DDS.
           COPY DDS-ALL-FORMAT OF APFCC.
      *
       FD  ZPFFR     LABEL RECORD STANDARD.
       01  FR-ENR-DDS.
           COPY DDS-ALL-FORMAT OF ZPFFR.
      *
       FD  BPFAR100  LABEL RECORD STANDARD.
       01  AR-ENR-DDS.
           COPY DDS-ALL-FORMAT OF BPFAR100.
      *
       FD  BPFERM61  LABEL RECORD STANDARD.
       01  ER61-ENR-DDS.
           COPY DDS-ALL-FORMAT OF BPFERM61.
      *
       FD  BPFER     LABEL RECORD STANDARD.
       01  ER-ENR-DDS.
           COPY DDS-ALL-FORMAT OF BPFER.
      *
       FD  BPFDR     LABEL RECORD STANDARD.
       01  DR-ENR-DDS.
           COPY DDS-ALL-FORMAT OF BPFDR.
      *
       FD  BPFSK  LABEL RECORD STANDARD.
       01   SK-ENR-DDS.
           COPY DDS-ALL-FORMAT OF BPFSK.
      *
           COPY FDAPFIN.
           COPY    FDINTVA.
           COPY    FDINTYPREC.
       01  INPG-ENR-DDS.
           05  FILLER          PIC X(61).
           05  INPG-DEST       PIC X(50).
           05  FILLER          PIC X(145).
       01  IN-ENR-DDS.
           COPY    DDS-ALL-FORMATS  OF  ALFIN1.
      *
       FD  BPFALANO  LABEL RECORD STANDARD.
       01  ALA-ENR-DDS.
           COPY DDS-ALL-FORMAT OF BPFALAAO.
      /
       WORKING-STORAGE SECTION.
       77  CPT-LUS           PIC 9(6) VALUE ZERO.
       77  CPT-ECR           PIC 9(6) VALUE ZERO.
       77  CPT-ANO           PIC 9(6) VALUE ZERO.
       77  DR-QT                  PIC S9(8)V9(3) COMP-3.
       77  DR-PR                  PIC S9(6)V9(3) COMP-3.
       77  TOP-ENTERR        PIC 1    VALUE B"0".
      *
       77  NEG-STK                PIC S9(8)V9(3) COMP-3.
       77  OLD-ARSTK              PIC S9(8)V9(3) COMP-3.
       77  OLD-STK                PIC S9(8)V9(3) COMP-3.
       77  NEW-STK                PIC S9(8)V9(3) COMP-3.
       77  CAL-PRX                PIC S9(10)V9(5) COMP-3.
       77  WSTAT-AN               PIC XX.
       77  WSTAT-MOIS             PIC XX.
      *
       01  WCIDD             PIC X(5) VALUE SPACES.
       01  WCIDL             PIC X(5) VALUE SPACES.
       01  WERCMD            PIC X(8) VALUE SPACES.
       01  WCNUF             PIC X(6) VALUE SPACES.
       01  WKNORD.
           05  WKNORD9       PIC 9(5) VALUE ZERO.
      *
       01  IDENT-ER VALUE SPACES.
           05  WERCNUF       PIC X(6).
           05  WERAAL        PIC XX.
           05  WERMML        PIC XX.
           05  WERJJL        PIC XX.
           05  WERCAPP       PIC XXX.
           05  WERNORD       PIC X(5).
      *
       01  IDENT-DR VALUE SPACES.
           05  WRAC-DR         PIC X(6).
           05  WCCC-DR         PIC X.
           05  WVPV-DR         PIC XX.
      *
       01  WARART VALUE SPACES.
           05  WARRAC          PIC X(6).
           05  WARCCC          PIC X.
           05  WARVPV          PIC XX.
      *
       01  RESART VALUE SPACES.
           05  RESRAC          PIC X(6).
           05  RESCCC          PIC X.
           05  RESVPV          PIC XX.
      *
       01  WECRAN.
           05  FILLER          PIC X(9).
           05  TOP-MAJ         PIC X.
      *
       01  WTVA-FIC.
           05  WTVA-FIC9                 PIC 9(2).
      *
       01  WCALCULS.
           05  WQTE              PIC S9(6)V9(3)   COMP-3.
           05  WMPA              PIC S9(8)V9(3)   COMP-3.
           05  WMPAB             PIC S9(8)V9(3)   COMP-3.
           05  WMPR              PIC S9(8)V9(3)   COMP-3.
           05  WMTVA             PIC S9(8)V9(3)   COMP-3.
           05  WMVIG             PIC S9(9)V9(2)   COMP-3.
           05  WMPA-RF           PIC S9(8)V9(3)   COMP-3.
           05  WMRF              PIC S9(8)V9(3)   COMP-3.
           05  WMRIS             PIC S9(8)V9(3)   COMP-3.
           05  WMCOO             PIC S9(8)V9(3)   COMP-3.
           05  WMNEG             PIC S9(8)V9(3)   COMP-3.
           05  WMRGD             PIC S9(8)V9(3)   COMP-3.
           05  WMTRS             PIC S9(8)V9(3)   COMP-3.
           05  WMTVT             PIC S9(8)V9(3)   COMP-3.
      *
           COPY    WKTABTVA.
           COPY    WKREFPGM         REPLACING SPACE BY "BCBAL150*A".
           COPY    WKGENERAL.
           COPY    WKMESSAGE.
           COPY    WKLDA.
      *
       01  DATE-JOUR   VALUE SPACES.
           05  AN          PIC XX.
           05  MOI         PIC XX.
           05  JOUR        PIC XX.
      *
       01  HEURE-JOUR  VALUE SPACES.
           05  HH          PIC XX.
           05  MN          PIC XX.
           05  SS          PIC XX.
           05  CC          PIC XX.
      *
           COPY  WKDAT000.
      *
       01  WKAA.
           COPY  DDS-ALL-FORMAT OF BPFALZA.
       01  WKAR.
           COPY  DDS-ALL-FORMAT OF BPFAR100.
       01  SAVE-SK-ENR-DDS.
           COPY  DDS-ALL-FORMAT OF BPFSK.
       01  WKCCD.
           COPY  DDS-ALL-FORMAT OF APFCC.
      *
      /
      *
      *DEBUT AF0*
           COPY WKAFER.
           COPY WKAFSK.
      *FIN   AF0*
      *
      ********************
       PROCEDURE DIVISION.
      ********************
       DEBUT-PROG.
      ***** MESSAGE DE DEBUT
           MOVE    SPACE       TO  WK-MESSAGE-LIB.
           STRING " DEBUT ---> " REF-PGM
                   DELIMITED  BY SIZE
                   INTO  WK-MESSAGE-LIB.
           PERFORM AFF-MESSAGE  THRU  AFF-MESSAGE-EXIT.
           ACCEPT   DATE-JOUR  FROM  DATE.
           ACCEPT   HEURE-JOUR FROM  TIME.
      *
           MOVE     SPACE  TO  WAAMMJJ.
           CALL     "ACBDT000" USING WKDAT000.
      *
           ACCEPT   WKLDA  FROM  LDA.
      *
           OPEN INPUT  FINFODI.
           COPY SRLTVA.
           CLOSE FINFODI WITH LOCK.
      *
      ***** RECUPERATION AN MOIS STAT.
           CALL  "BCLRC530" USING WSTAT-AN WSTAT-MOIS.
      *
           OPEN INPUT  BPFALZA
                       APFCC
                       ZPFFR
                       BPFERM61
                I-O    BPFDR
                       BPFER
                       BPFAR100
                       BPFSK
                OUTPUT BPFALANO.
      *
           PERFORM  LECT  THRU  F-CONT-LECT.
           IF   BLRALZA1 OF AZ-ENR-DDS = HIGH-VALUE GO  TO  VIDE.
      *
       INIT-RUPT-ENTETE.
           PERFORM  CONT-ENT-REC THRU CONT-ENT-REC-EXIT.
           IF   TOP-ENTERR = VRAI      GO  TO  LECT1.
      *
           MOVE AZCNFE OF AZ-ENR-DDS  TO  WERCNUF.
           MOVE AZAALV OF AZ-ENR-DDS  TO  WERAAL.
           MOVE AZMMLV OF AZ-ENR-DDS  TO  WERMML.
           MOVE AZJJLV OF AZ-ENR-DDS  TO  WERJJL.
           MOVE AZCAPP OF AZ-ENR-DDS  TO  WERCAPP.
           MOVE AZNORD OF AZ-ENR-DDS  TO  WERNORD.
      *
       INIT-RUPT-ARTICLE.
           MOVE ZERO    TO  DR-QT.
      *    MOVE AR-ENR-DDS    TO     WKAR.
           MOVE WARRAC        TO  WRAC-DR.
           MOVE WARCCC        TO  WCCC-DR.
           MOVE WARVPV        TO  WVPV-DR.
           MOVE BLRALZA1 OF AZ-ENR-DDS  TO  WKAA.
      *
       TRAIT-DETAIL.
           ADD  AZQT  OF AZ-ENR-DDS  TO  DR-QT.
           MOVE AZPA  OF AZ-ENR-DDS  TO  DR-PR.
      *
       LECT1.
           PERFORM      LECT  THRU  F-CONT-LECT.
      *
           IF   AZCNFE OF AZ-ENR-DDS  =   WERCNUF AND
                AZAALV OF AZ-ENR-DDS  =   WERAAL  AND
                AZMMLV OF AZ-ENR-DDS  =   WERMML  AND
                AZJJLV OF AZ-ENR-DDS  =   WERJJL  AND
                AZCAPP OF AZ-ENR-DDS  =   WERCAPP AND
                AZNORD OF AZ-ENR-DDS  =   WERNORD AND
                WARRAC                =   WRAC-DR AND
                WARCCC                =   WCCC-DR AND
                WARVPV                =   WVPV-DR
                GO  TO  TRAIT-DETAIL.
      *
           IF  DR-QT NOT = ZERO
               PERFORM  VALID-RECEP  THRU  VALID-RECEP-EXIT.
      *
           IF   AZCNFE OF AZ-ENR-DDS  =   WERCNUF AND
                AZAALV OF AZ-ENR-DDS  =   WERAAL  AND
                AZMMLV OF AZ-ENR-DDS  =   WERMML  AND
                AZJJLV OF AZ-ENR-DDS  =   WERJJL  AND
                AZCAPP OF AZ-ENR-DDS  =   WERCAPP AND
                AZNORD OF AZ-ENR-DDS  =   WERNORD
                          GO  TO  INIT-RUPT-ARTICLE.
      *
           IF  ERNLIG OF ER-ENR-DDS  NOT = ZERO
               PERFORM  MAJ-ENT-REC  THRU  MAJ-ENT-REC-EXIT.
      *
           IF  BLRALZA1 OF AZ-ENR-DDS NOT = HIGH-VALUE
                          GO  TO  INIT-RUPT-ENTETE.
      *
       VIDE.
      *
           CLOSE  BPFALZA ZPFFR  APFCC
                  BPFAR100 BPFSK BPFDR BPFERM61 BPFER
                  BPFALANO.
      *
           MOVE SPACE TO WK-MESSAGE-LIB.
           STRING  "   LUS : " CPT-LUS
                   "   ECR : " CPT-ECR
                   "   ANO : " CPT-ANO
                   DELIMITED BY SIZE  INTO WK-MESSAGE-LIB.
           PERFORM AFF-MESSAGE        THRU    AFF-MESSAGE-EXIT.
      *
           MOVE    SPACE       TO  WK-MESSAGE-LIB.
           STRING "  FIN  ---> " REF-PGM
                   DELIMITED  BY SIZE
                   INTO  WK-MESSAGE-LIB.
           PERFORM AFF-MESSAGE  THRU  AFF-MESSAGE-EXIT.
           STOP    RUN.
      *
       COPY SRMSGBATCH.
      /
       LECT.
           READ BPFALZA NEXT AT END
                        MOVE HIGH-VALUE TO BLRALZA1 OF AZ-ENR-DDS
                        GO  TO   F-CONT-LECT.
      *
           ADD  1       TO  CPT-LUS.
      ******* TEST SI VA = "0 " VA = "  " ****************
           IF   AZVA OF AZ-ENR-DDS = "0 " OR AZVA OF AZ-ENR-DDS = "00"
                MOVE "  "  TO AZVA OF AZ-ENR-DDS.
      *
           IF   AZNORD OF AZ-ENR-DDS  = SPACES
                MOVE   "00001"        TO  AZNORD OF AZ-ENR-DDS.
      *
      **** INITIALISATION ANOMALIE
      *
           MOVE BLRALZA1 OF AZ-ENR-DDS TO  BPRAAO.
      *
      **** CONTROLE FOURNISSEUR
      *
           IF   AZCNFE OF AZ-ENR-DDS = WCNUF GO  TO  CONT-CLI.
           MOVE AZCNFE OF AZ-ENR-DDS TO  FRCNUF.
           READ ZPFFR INVALID KEY MOVE "01"  TO  AAANO
                                  MOVE "FOURNISSEUR INCONNU" TO AALANO
                                  PERFORM    ECR-ANO THRU ECR-ANO-EXIT
                                  GO  TO     LECT.
      *
           MOVE AZCNFE OF AZ-ENR-DDS TO  WCNUF.
      *
      **** CONTROLE CLIENT
      *
       CONT-CLI.
      *
           IF   AZCIDL OF AZ-ENR-DDS = WCIDL   GO  TO   CONT-ART.
      *
           MOVE AZCIDL OF AZ-ENR-DDS  TO  CCID OF CC-ENR-DDS.
           READ APFCC INVALID KEY
                     MOVE    SPACE       TO  WK-MESSAGE-LIB
                     STRING " CLIENT INCONNU " REF-PGM
                             DELIMITED  BY SIZE
                             INTO  WK-MESSAGE-LIB
                     PERFORM AFF-MESSAGE  THRU  AFF-MESSAGE-EXIT
                     GO  TO  TILT.
      *
           IF   CCATM  OF CC-ENR-DDS = "08"
                          MOVE   CCID OF CC-ENR-DDS  TO  WCIDL
                          MOVE   CC-ENR-DDS          TO  WKCCD
                          GO  TO  CONT-ART.
      *
           MOVE "03"  TO  AAANO.
           MOVE "CAT. CLIENT.NON PREVU " TO AALANO
           PERFORM    ECR-ANO THRU ECR-ANO-EXIT
           GO  TO     LECT.
      *
      **** CONTROLE ARTICLE
      *
       CONT-ART.
      *
           MOVE AZRAC OF AZ-ENR-DDS TO  ARRAC OF AR-ENR-DDS.
           MOVE AZCCC OF AZ-ENR-DDS TO  ARCCC OF AR-ENR-DDS.
           MOVE AZVPV OF AZ-ENR-DDS TO  ARVPV OF AR-ENR-DDS.
      *
           READ BPFAR100  INVALID KEY  MOVE "06"  TO  AAANO
                          MOVE "ARTICLE INCONNU" TO AALANO
                          PERFORM    ECR-ANO THRU ECR-ANO-EXIT
                          GO  TO     VALID-RECEP-EXIT.
      *
           MOVE AZRAC OF AZ-ENR-DDS TO  WARRAC.
           MOVE AZCCC OF AZ-ENR-DDS TO  WARCCC.
           MOVE AZVPV OF AZ-ENR-DDS TO  WARVPV.
       F-CONT-LECT.
           EXIT.
      /
       ECR-ANO.
           WRITE ALA-ENR-DDS.
           ADD  1       TO  CPT-ANO.
       ECR-ANO-EXIT.
           EXIT.
      /
       CONT-ENT-REC.
      *****  LECTURE ENTETE RECEPTION
           MOVE FAUX TO TOP-ENTERR.
      *
           MOVE AZNORD OF AZ-ENR-DDS  TO  WKNORD.
           PERFORM INIT-ER-CLE THRU INIT-ER-CLE-EXIT.
           READ BPFER INVALID GO CONTR-ENT-ER-INEX.
      *
           MOVE VRAI  TO  TOP-ENTERR.
           MOVE ZERO  TO  ERNLIG OF ER-ENR-DDS
                          DR-QT.
           MOVE "09"                     TO AAANO.
           MOVE "RECEPT. DEJA EXISTANTE" TO AALANO.
           PERFORM ECR-ANO THRU ECR-ANO-EXIT.
           GO   TO    CONT-ENT-REC-EXIT.
      *
       CONTR-ENT-ER-INEX.
           PERFORM INIT-ER-CLE THRU INIT-ER-CLE-EXIT.
           MOVE ER-ENR-DDS TO ER61-ENR-DDS.
           READ BPFERM61 NOT INVALID
               MOVE VRAI TO TOP-ENTERR
               MOVE ZERO TO ERNLIG OF ER-ENR-DDS
                            DR-QT
               MOVE "09"                     TO AAANO
               MOVE "RECEPT. MENSUELLE EXISTANTE" TO AALANO
               PERFORM ECR-ANO THRU ECR-ANO-EXIT
               GO CONT-ENT-REC-EXIT.
           PERFORM INIT-ER THRU INIT-ER-EXIT.
       CONT-ENT-REC-EXIT.
           EXIT.
      /
      ****************************************************************
      ******* SOUS-ROUTINE INITIALISATION DE BPFER
      ****************************************************************
       INIT-ER.
           PERFORM INIT-ER-CLE THRU INIT-ER-CLE-EXIT.
           MOVE SPACES    TO ERNCMD  OF ER-ENR-DDS.
           MOVE ARCIF OF AR-ENR-DDS    TO ERCIFC  OF ER-ENR-DDS
                                          ERCIFR  OF ER-ENR-DDS.
           MOVE FRNSF   OF ZPRFR   TO ERNSL   OF ER-ENR-DDS.
           MOVE 1                  TO ERNTRT  OF ER-ENR-DDS.
           MOVE ZERO               TO ERTME   OF ER-ENR-DDS
                                      ERTMG   OF ER-ENR-DDS.
           MOVE "01"               TO ERNTRC  OF ER-ENR-DDS.
           MOVE CCNUD OF WKCCD     TO ERCNUD  OF ER-ENR-DDS.
           MOVE CSOCG OF WKCCD     TO ERSTE   OF ER-ENR-DDS.
           MOVE CCATM OF WKCCD     TO ERCATR  OF ER-ENR-DDS
                                      ERCATM  OF ER-ENR-DDS.
           MOVE FRRIST  OF ZPRFR   TO ERTRIS  OF ER-ENR-DDS.
           MOVE FRCOOP  OF ZPRFR   TO ERTCOO  OF ER-ENR-DDS.
           MOVE ZERO               TO ERTREM  OF ER-ENR-DDS.
           MOVE FRFONC  OF ZPRFR   TO ERTRF   OF ER-ENR-DDS.
           MOVE ARDEP OF AR-ENR-DDS TO ERDEP   OF ER-ENR-DDS.
           MOVE ARRAY OF AR-ENR-DDS TO ERRAY   OF ER-ENR-DDS.
           MOVE AN                 TO ERAAC   OF ER-ENR-DDS.
           MOVE MOI                TO ERMMC   OF ER-ENR-DDS.
           MOVE JOUR               TO ERJJC   OF ER-ENR-DDS.
           MOVE AN                 TO ERAAM   OF ER-ENR-DDS.
           MOVE MOI                TO ERMMM   OF ER-ENR-DDS.
           MOVE JOUR               TO ERJJM   OF ER-ENR-DDS.
           MOVE WNO-SEMAINE        TO ERTOP1  OF ER-ENR-DDS.
           MOVE ARNENT OF AR-ENR-DDS TO ERTOP3  OF ER-ENR-DDS.
           MOVE ZERO               TO ERFPA   OF ER-ENR-DDS
                                      ERFPV   OF ER-ENR-DDS
                                      ERFTVA  OF ER-ENR-DDS
                                      ERFVIG  OF ER-ENR-DDS
                                      ERFTRS  OF ER-ENR-DDS
                                      ERFTVT  OF ER-ENR-DDS
                                      ERFPAR  OF ER-ENR-DDS
                                      ERFTX1  OF ER-ENR-DDS
                                      ERFTX2  OF ER-ENR-DDS
           MOVE ZERO               TO ERARPA  OF ER-ENR-DDS
                                      ERARTV  OF ER-ENR-DDS.
           MOVE "00"               TO ERDIFF  OF ER-ENR-DDS.
           MOVE ZERO               TO ERMPA   OF ER-ENR-DDS
                                      ERMPV   OF ER-ENR-DDS
                                      ERMTVA  OF ER-ENR-DDS
                                      ERMVIG  OF ER-ENR-DDS
                                      ERNLIG  OF ER-ENR-DDS
                                      ERMTVV  OF ER-ENR-DDS
                                      ERMAVD  OF ER-ENR-DDS
                                      ERMRIS  OF ER-ENR-DDS
                                      ERMCOO  OF ER-ENR-DDS
                                      ERMNEG  OF ER-ENR-DDS
                                      ERMRGD  OF ER-ENR-DDS
                                      ERMEMB  OF ER-ENR-DDS
                                      ERMRF   OF ER-ENR-DDS
                                      ERMTRS  OF ER-ENR-DDS
                                      ERMTRS  OF ER-ENR-DDS
                                      ERMTVT  OF ER-ENR-DDS
                                      ERMTX1  OF ER-ENR-DDS
                                      ERMTX2  OF ER-ENR-DDS.
       INIT-ER-EXIT.
           EXIT.
 
      ****************************************************************
      ******* SOUS-ROUTINE MAJ CLEF DE BPFER
      ****************************************************************
       INIT-ER-CLE.
           MOVE SPACE                 TO ER-ENR-DDS.
           MOVE "01"                  TO ERTYRC OF ER-ENR-DDS.
           MOVE CCID  OF WKCCD        TO ERCIDR OF ER-ENR-DDS.
           MOVE AZCAPP OF AZ-ENR-DDS  TO ERKAPP OF ER-ENR-DDS.
           MOVE SPACE                 TO ERKDEP OF ER-ENR-DDS.
           MOVE SPACE                 TO ERKRAY OF ER-ENR-DDS.
           MOVE SPACE                 TO ERKSEC OF ER-ENR-DDS.
           MOVE AZCNFE OF AZ-ENR-DDS  TO ERCNUL OF ER-ENR-DDS.
           MOVE "01"                  TO ERNENT OF ER-ENR-DDS.
           MOVE SPACE                 TO ERCID  OF ER-ENR-DDS.
      *DEBUT AF0*
      *    MOVE AZAALV OF AZ-ENR-DDS  TO ERAARC OF ER-ENR-DDS.
      *    MOVE AZMMLV OF AZ-ENR-DDS  TO ERMMRC OF ER-ENR-DDS.
      *    MOVE AZJJLV OF AZ-ENR-DDS  TO ERJJRC OF ER-ENR-DDS.
           IF AZAALV OF AZ-ENR-DDS  > "50"
              MOVE "19"               TO WK-ERXXRC-SS
           ELSE
              MOVE "20"               TO WK-ERXXRC-SS
           END-IF
           MOVE AZAALV OF AZ-ENR-DDS  TO WK-ERAARC-S.
           MOVE AZMMLV OF AZ-ENR-DDS  TO WK-ERMMRC-S.
           MOVE AZJJLV OF AZ-ENR-DDS  TO WK-ERJJRC-S.
           PERFORM SRAFER2O
      *FIN   AF0*
           MOVE WKNORD                TO ERNORD OF ER-ENR-DDS.
       INIT-ER-CLE-EXIT.
           EXIT.
      /
       VALID-RECEP.
           MOVE WRAC-DR  TO  ARRAC OF AR-ENR-DDS.
           MOVE WCCC-DR  TO  ARCCC OF AR-ENR-DDS.
           MOVE WVPV-DR  TO  ARVPV OF AR-ENR-DDS.
      *
           READ BPFAR100  INVALID KEY  MOVE "06"  TO  AAANO
                          MOVE "ARTICLE INCONNU" TO AALANO
                          PERFORM    ECR-ANO THRU ECR-ANO-EXIT
                          GO  TO     VALID-RECEP-EXIT.
      *
      ******* Sauvegarde des stocks et prx anciens
           MOVE ARSTK  OF AR-ENR-DDS TO OLD-STK.
      ******* Cumul sur compteur quantité reçue
           IF WERAAL   NOT = ARRCAA OF AR-ENR-DDS OR
              WERMML   NOT = ARRCMM OF AR-ENR-DDS OR
              WERJJL   NOT = ARRCJJ OF AR-ENR-DDS
              MOVE ZERO     TO ARRCQT OF AR-ENR-DDS
              MOVE WERAAL   TO ARRCAA OF AR-ENR-DDS
              MOVE WERMML   TO ARRCMM OF AR-ENR-DDS
              MOVE WERJJL   TO ARRCJJ OF AR-ENR-DDS.
           ADD DR-QT                 TO ARRCQT OF AR-ENR-DDS.
           MOVE ZERO  TO  NEG-STK.
      ******* Mise à jour des stocks et des PRX SI PAS FICTIF
           IF ARSTKE OF AR-ENR-DDS NOT = "F"
              MOVE ARSTK OF AR-ENR-DDS   TO OLD-ARSTK
              ADD DR-QT                  TO ARSTK OF AR-ENR-DDS
              IF ARSTK OF AR-ENR-DDS < 0
                   MOVE ARSTK OF AR-ENR-DDS TO NEG-STK
                   MOVE ZERO TO ARSTK OF AR-ENR-DDS
              END-IF
              IF (ARSTK OF AR-ENR-DDS + ARSTPP OF AR-ENR-DDS
                + ARSTKB OF AR-ENR-DDS) > 0
                COMPUTE CAL-PRX =
                   ( (ARPRX OF AR-ENR-DDS *
                      (OLD-ARSTK + ARSTPP OF AR-ENR-DDS
                                 + ARSTKB OF AR-ENR-DDS) )  +
                   ( DR-PR               * DR-QT                 ) ) /
                   ( ARSTK OF AR-ENR-DDS + ARSTPP OF AR-ENR-DDS
                                         + ARSTKB OF AR-ENR-DDS )
                COMPUTE ARPRX OF AR-ENR-DDS ROUNDED = CAL-PRX.
           IF ARPRX OF AR-ENR-DDS = ZERO AND
              (ARSTK  OF AR-ENR-DDS > ZERO OR
               ARSTPP OF AR-ENR-DDS > ZERO OR
               ARSTKB OF AR-ENR-DDS > ZERO)
                    MOVE ARPR OF AR-ENR-DDS TO ARPRX OF AR-ENR-DDS.
           IF ARPRX OF AR-ENR-DDS < ZERO
                    MOVE ARPR OF AR-ENR-DDS TO ARPRX OF AR-ENR-DDS.
 
           MOVE ARSTK  OF AR-ENR-DDS TO NEW-STK.
 
           IF ARSTK OF AR-ENR-DDS  = ZERO AND
              ARSTKE OF AR-ENR-DDS = SPACE
                     MOVE  "M" TO ARSTKE OF  AR-ENR-DDS.
           IF ARSTK OF AR-ENR-DDS  NOT = ZERO AND
              ARSTKE OF AR-ENR-DDS = "M"
                     MOVE  SPACE TO ARSTKE OF  AR-ENR-DDS.
 
      ******* Constitution Fichier mouvement de stock
           MOVE ARRAC  OF AR-ENR-DDS  TO SKRAC  OF SK-ENR-DDS.
           MOVE ARCCC  OF AR-ENR-DDS  TO SKCCC  OF SK-ENR-DDS.
           MOVE ARVPV  OF AR-ENR-DDS  TO SKVPV  OF SK-ENR-DDS.
           MOVE ARMOD  OF AR-ENR-DDS  TO SKMOD  OF SK-ENR-DDS.
      *DEBUT AF0*
      *    MOVE AZAACR OF WKAA        TO SKAAM  OF SK-ENR-DDS.
      *    MOVE AZMMCR OF WKAA        TO SKMMM  OF SK-ENR-DDS.
      *    MOVE AZJJCR OF WKAA        TO SKJJM  OF SK-ENR-DDS.
           IF AZAACR OF WKAA > "50"
              MOVE "19"               TO WK-SKXXM-SS
           ELSE
              MOVE "20"               TO WK-SKXXM-SS
           END-IF
           MOVE AZAACR OF WKAA        TO WK-SKAAM-S.
           MOVE AZMMCR OF WKAA        TO WK-SKMMM-S.
           MOVE AZJJCR OF WKAA        TO WK-SKJJM-S.
      *FIN   AF0*
           MOVE AZHHCR OF WKAA        TO SKHHM  OF SK-ENR-DDS.
           MOVE AZMNCR OF WKAA        TO SKMNM  OF SK-ENR-DDS.
           MOVE AZSSCR OF WKAA        TO SKSSM  OF SK-ENR-DDS.
           MOVE WSTAT-AN              TO SKAN   OF SK-ENR-DDS.
           MOVE WSTAT-MOIS            TO SKMOIS OF SK-ENR-DDS.
           MOVE ZERO                  TO SKSTKO OF SK-ENR-DDS.
           MOVE "0"                   TO SKNATO OF SK-ENR-DDS.
           MOVE OLD-STK               TO SKSTKD OF SK-ENR-DDS.
           MOVE "1"                   TO SKNATD OF SK-ENR-DDS.
           COMPUTE SKSTKV OF SK-ENR-DDS = NEW-STK - OLD-STK.
           MOVE "01"                  TO SKTYPE OF SK-ENR-DDS.
           MOVE "11"                  TO SKMOTF OF SK-ENR-DDS.
           MOVE ERNORD OF ER-ENR-DDS  TO SKCID  OF SK-ENR-DDS.
           MOVE SPACES                TO SKNFAC OF SK-ENR-DDS.
           MOVE ZERO                  TO SKNPLT OF SK-ENR-DDS.
           MOVE AZAALV OF WKAA        TO SKFTAA OF SK-ENR-DDS.
           MOVE AZMMLV OF WKAA        TO SKFTMM OF SK-ENR-DDS.
           MOVE AZJJLV OF WKAA        TO SKFTJJ OF SK-ENR-DDS.
 
      ******* Mise à jour article
           REWRITE AR-ENR-DDS INVALID
               MOVE "15"                       TO AAANO
               MOVE "MISE A JOUR ARTICLE IMPOSSIBLE"
                                          TO AALANO
               PERFORM ECR-ANO THRU ECR-ANO-EXIT
               GO VALID-RECEP-EXIT.
 
      ******* Ecriture mise à jour de stock   erreur = moindre mal
           IF ARSTKE OF AR-ENR-DDS NOT = "F"
      *DEBUT AF0*
              PERFORM SRAFSK2O
      *FIN   AF0*
              MOVE SK-ENR-DDS TO SAVE-SK-ENR-DDS
              WRITE SK-ENR-DDS
              END-WRITE
              IF NEG-STK NOT = ZERO
                 MOVE SAVE-SK-ENR-DDS    TO SK-ENR-DDS
                 MOVE "02"     TO SKTYPE OF SK-ENR-DDS
                 COMPUTE SKSTKO OF SK-ENR-DDS = NEG-STK * -1
                 MOVE ZERO     TO SKSTKD OF SK-ENR-DDS
                 MOVE ZERO     TO SKSTKV OF SK-ENR-DDS
                 WRITE SK-ENR-DDS.
 
      ******* Constitution BPFDR et écriture
           PERFORM INIT-DR THRU INIT-DR-EXIT.
           WRITE DR-ENR-DDS INVALID
               MOVE "16"                       TO AAANO
               MOVE "ECRITURE LIGNE RECEPTION IMPOSSIBLE"
                                          TO AALANO
               PERFORM ECR-ANO THRU ECR-ANO-EXIT
               GO VALID-RECEP-EXIT.
      *
           ADD   1   TO   CPT-ECR.
      *
           PERFORM   MAJ-ER   THRU    MAJ-ER-EXIT.
      *
       VALID-RECEP-EXIT.
           EXIT.
      /***************************************************************
      ******* SOUS-ROUTINE INITIALISATION DE BPFDR
      ****************************************************************
       INIT-DR.
           MOVE SPACE               TO DR-ENR-DDS.
           MOVE ERTYRC OF ER-ENR-DDS TO DRTYRC OF DR-ENR-DDS.
           MOVE ERCIDR OF ER-ENR-DDS TO DRCIDR OF DR-ENR-DDS.
           MOVE ERKAPP OF ER-ENR-DDS TO DRKAPP OF DR-ENR-DDS.
           MOVE ERKDEP OF ER-ENR-DDS TO DRKDEP OF DR-ENR-DDS.
           MOVE ERKRAY OF ER-ENR-DDS TO DRKRAY OF DR-ENR-DDS.
           MOVE ERKSEC OF ER-ENR-DDS TO DRKSEC OF DR-ENR-DDS.
           MOVE ERCNUL OF ER-ENR-DDS TO DRCNUL OF DR-ENR-DDS.
           MOVE ERNENT OF ER-ENR-DDS TO DRNENT OF DR-ENR-DDS.
           MOVE ERCID  OF ER-ENR-DDS TO DRCID  OF DR-ENR-DDS.
           MOVE ERAARC OF ER-ENR-DDS TO DRAARC OF DR-ENR-DDS.
           MOVE ERMMRC OF ER-ENR-DDS TO DRMMRC OF DR-ENR-DDS.
           MOVE ERJJRC OF ER-ENR-DDS TO DRJJRC OF DR-ENR-DDS.
           MOVE ERNORD OF ER-ENR-DDS TO DRNORD OF DR-ENR-DDS.
           STRING "0" ARRAC OF AR-ENR-DDS
                 DELIMITED BY SIZE INTO DRSLIM OF DR-ENR-DDS.
           MOVE ARMOD  OF AR-ENR-DDS TO DRMOD  OF DR-ENR-DDS.
           MOVE DR-QT                TO DRQTE  OF DR-ENR-DDS.
           MOVE ARPA   OF AR-ENR-DDS TO DRPA   OF DR-ENR-DDS.
           MOVE ZERO                 TO DRPV   OF DR-ENR-DDS.
           MOVE ARTVA OF AR-ENR-DDS  TO WTVA-FIC.
           IF WTVA-FIC NOT NUMERIC
                       MOVE "00" TO ARTVA OF AR-ENR-DDS
                       SET IN-TVA TO 1
           ELSE SET IN-TVA TO 1
                SET IN-TVA UP BY WTVA-FIC9
                IF WK-TVA-TP (IN-TVA) = SPACE
                       MOVE "00" TO ARTVA OF AR-ENR-DDS
                       SET IN-TVA TO 1.
           MOVE ARTVA OF AR-ENR-DDS  TO DRTVA  OF DR-ENR-DDS.
           IF DR-QT < 0
                MOVE "02"             TO DRRET  OF DR-ENR-DDS
           ELSE MOVE "01"             TO DRRET  OF DR-ENR-DDS.
           MOVE ARRGVI OF AR-ENR-DDS  TO DRRGVI OF DR-ENR-DDS.
           MOVE ARRGDR OF AR-ENR-DDS  TO DRRGDR OF DR-ENR-DDS.
           MOVE ARCNUF OF AR-ENR-DDS  TO DRCNUF OF DR-ENR-DDS.
           MOVE ARCIP  OF AR-ENR-DDS  TO DRCIP  OF DR-ENR-DDS.
           MOVE ARVA   OF AR-ENR-DDS  TO DRVA   OF DR-ENR-DDS.
           MOVE ARPCB  OF AR-ENR-DDS  TO DRPCB  OF DR-ENR-DDS.
           MOVE ARFAM  OF AR-ENR-DDS  TO DRFAM  OF DR-ENR-DDS.
           MOVE ARSFA  OF AR-ENR-DDS  TO DRSFA  OF DR-ENR-DDS.
           MOVE ARCAT  OF AR-ENR-DDS  TO DRCAT  OF DR-ENR-DDS.
           MOVE "01"                  TO DRGST  OF DR-ENR-DDS.
           MOVE ARTYAR OF AR-ENR-DDS  TO DRTART OF DR-ENR-DDS.
           MOVE ARLCON OF AR-ENR-DDS  TO DRLCON OF DR-ENR-DDS.
           MOVE ARRIST OF AR-ENR-DDS  TO DRRIST OF DR-ENR-DDS.
           MOVE ARCRIS OF AR-ENR-DDS  TO DRCRIS OF DR-ENR-DDS.
           MOVE ARCOOP OF AR-ENR-DDS  TO DRCOOP OF DR-ENR-DDS.
           MOVE ARCCOO OF AR-ENR-DDS  TO DRCCOO OF DR-ENR-DDS.
           MOVE ZERO                  TO DRNEG  OF DR-ENR-DDS.
           MOVE SPACE                 TO DRCNEG OF DR-ENR-DDS.
           IF FRCODR OF ZPRFR = "0"
                MOVE ZERO             TO DRRF   OF DR-ENR-DDS
                MOVE SPACE            TO DRCRF  OF DR-ENR-DDS
           ELSE IF FRCODR OF ZPRFR = "2"
                MOVE FRFONC OF ZPRFR  TO DRRF   OF DR-ENR-DDS
                MOVE SPACE            TO DRCRF  OF DR-ENR-DDS
           ELSE MOVE ARRF  OF AR-ENR-DDS  TO DRRF  OF DR-ENR-DDS
                MOVE ARCRF OF AR-ENR-DDS  TO DRCRF OF DR-ENR-DDS.
           IF ARPANT OF AR-ENR-DDS NUMERIC
                STRING "0" ARPANT OF AR-ENR-DDS DELIMITED BY SIZE
                                        INTO DRAVDF OF DR-ENR-DDS
           ELSE MOVE ZEROES TO DRAVDF OF DR-ENR-DDS.
           MOVE ARPAB OF AR-ENR-DDS   TO DRTAX1 OF DR-ENR-DDS.
           MOVE ARPR  OF AR-ENR-DDS   TO DRTAX2 OF DR-ENR-DDS.
           MOVE ARTRS OF AR-ENR-DDS   TO DRTRSP OF DR-ENR-DDS.
           MOVE WNO-SEMAINE           TO DRTOP1 OF DR-ENR-DDS.
           MOVE ARNENT OF AR-ENR-DDS  TO DRTOP3 OF DR-ENR-DDS.
           MOVE ARTOP3 OF AR-ENR-DDS  TO DRTOP4 OF DR-ENR-DDS.
           COMPUTE WQTE  ROUNDED = DRQTE  OF DR-ENR-DDS.
           COMPUTE WMPA  ROUNDED = DRPA   OF DR-ENR-DDS * WQTE.
           COMPUTE WMPAB ROUNDED = DRTAX1 OF DR-ENR-DDS * WQTE.
           COMPUTE WMPR  ROUNDED = DRTAX2 OF DR-ENR-DDS * WQTE.
           COMPUTE WMTVA ROUNDED = WMPA * WK-TVA-TVATL-CENT (IN-TVA).
           MOVE WMTVA                 TO DRTAX  OF DR-ENR-DDS.
           COMPUTE WMVIG ROUNDED = DRRGVI OF DR-ENR-DDS * WQTE.
      ****** SI PAS EMBALLAGES
           IF DRFAM OF DR-ENR-DDS NOT = "099"
              IF DRCRF  OF DR-ENR-DDS = SPACE
                 COMPUTE WMRF  ROUNDED = DRRF   OF DR-ENR-DDS * WMPA
                                        / 100
              ELSE
                 COMPUTE WMRF  ROUNDED = DRRF   OF DR-ENR-DDS * WQTE
              END-IF
              COMPUTE WMPA-RF ROUNDED = WMPA - WMRF
              IF DRCRIS OF DR-ENR-DDS = SPACE
                 COMPUTE WMRIS ROUNDED = DRRIST OF DR-ENR-DDS * WMPA-RF
                                        / 100
              ELSE
                 COMPUTE WMRIS ROUNDED = DRRIST OF DR-ENR-DDS * WQTE
              END-IF
              IF DRCCOO OF DR-ENR-DDS = SPACE
                 COMPUTE WMCOO ROUNDED = DRCOOP OF DR-ENR-DDS * WMPA-RF
                                        / 100
              ELSE
                 COMPUTE WMCOO ROUNDED = DRCOOP OF DR-ENR-DDS * WQTE
              END-IF
              IF DRCNEG OF DR-ENR-DDS = SPACE
                 COMPUTE WMNEG ROUNDED = DRNEG  OF DR-ENR-DDS * WMPA-RF
                                        / 100
              ELSE
                 COMPUTE WMNEG ROUNDED = DRNEG  OF DR-ENR-DDS * WQTE
              END-IF.
           COMPUTE WMRGD ROUNDED = DRRGDR OF DR-ENR-DDS * WQTE.
           COMPUTE WMTRS ROUNDED = DRTRSP OF DR-ENR-DDS * WQTE.
           COMPUTE WMTVT ROUNDED = WMTRS * WK-TVA-TVATL-CENT (IN-TVA).
       INIT-DR-EXIT.
           EXIT.
      /
      ****************************************************************
      ******* SOUS-ROUTINE MAJ DES CUMULS DANS BPFER
      ****************************************************************
       MAJ-ER.
           ADD 1                      TO ERNLIG OF ER-ENR-DDS.
           ADD WMPA                   TO ERMPA  OF ER-ENR-DDS.
           ADD WMPAB                  TO ERMTX1 OF ER-ENR-DDS.
           ADD WMPR                   TO ERMTX2 OF ER-ENR-DDS.
           ADD WMTVA                  TO ERMTVA OF ER-ENR-DDS.
           ADD WMVIG                  TO ERMVIG OF ER-ENR-DDS.
      ****** CAS DES EMBALLAGES
           IF DRFAM OF DR-ENR-DDS = "099"
                    ADD WMPA          TO ERMEMB OF ER-ENR-DDS
           ELSE
                    ADD WMCOO         TO ERMCOO OF ER-ENR-DDS
                                         ERMAVD OF ER-ENR-DDS
                    ADD WMRIS         TO ERMRIS OF ER-ENR-DDS
                                         ERMAVD OF ER-ENR-DDS
                    ADD WMNEG         TO ERMNEG OF ER-ENR-DDS
                                         ERMAVD OF ER-ENR-DDS
                    ADD WMRF          TO ERMRF  OF ER-ENR-DDS.
           ADD WMRGD                  TO ERMRGD OF ER-ENR-DDS.
           ADD WMTRS                  TO ERMTRS OF ER-ENR-DDS.
           ADD WMTVT                  TO ERMTVT OF ER-ENR-DDS.
       MAJ-ER-EXIT.
           EXIT.
      /
       MAJ-ENT-REC.
           WRITE ER-ENR-DDS INVALID
               MOVE VRAI TO TOP-ENTERR
               MOVE "11"                          TO AAANO
               MOVE "ERREUR ECRITURE ENT. RECEP." TO AALANO
               PERFORM ECR-ANO THRU ECR-ANO-EXIT.
       MAJ-ENT-REC-EXIT.
           EXIT.
      *
      *DEBUT AF0*
           COPY SRAFER2O.
           COPY SRAFSK2O.
      *FIN   AF0*
      *
 
