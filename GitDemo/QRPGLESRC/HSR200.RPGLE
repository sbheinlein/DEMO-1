000100170425      *%CSTD===========================================================*
000200170425      ** Application. : SAM        Arcad Sample Application            *
000300170425      ** Component. . : HSR200                        Type: RPGLE      *
000400170425      **===============================================================*
000500170425      ** Sub-system . :                                                *
000600170425      ** Function . . :                                                *
000700170425      ** Sub-function :                                                *
000800170425      **%S=============================================================*
000900170425      ** Description of functions:                                     *
001000170425      **                                                               *
001100170425      **                                                               *
001200170425      **                                                               *
001300170425      **%E=============================================================*
001400170425      ** AUTHOR:                          00:00                        *
001500170425      ** MODIFS: 02 MMARREL    12/01/2016 15:41  01.00.09 MR 16/   72  *
001600170425      **           bi                                                  *
001700170425      **         02 MMARREL    12/06/2016 12:52  01.00.08 MR 16/   73  *
001800170425      **           avivasa                                             *
001900170425      **         01 ARCAD_PGMR 06/26/2015 11:13  01.00.01 MR 16/   73  *
002000170425      *%ECSTD==========================================================*
002100170425      *%EXEC OVRDBF INTFILE EXTFILE
002200170425      * %ATTR TGTRLS(*CURRENT)
002300170425      */TITLE Sales Order Entry / Maintenance / Inquiry
002400170425      *
002500170425      * System        : HSV Control & Tracking
002600170425      * Author        : Bob Lee (Intec Systems)
002700170425      * Date          : January 1999
002800170425      *
002900170425      *================================================================
003000170425      * Indicator usage:
003100170425      *  20 - Order Valid for Despatch
003200170425      *  30 - 45 Input fields- DSPATR.
003300170425      *  62 - Control display/non-display of F10-Update.
003400170425      *  75 - 78 Program mode - Dispatch/Entry/Inquiry/Maintenance
003500170425      *  79 - MSGSFL (SFLCLR ETC...).
003600170425      *  99 - General CHAIN/SETLL result.
003700170425      *
003800170425      *================================================================
003900170425      * Maintenance   :
004000170425      * Fix/Chg Ref. Date       Description.
004100170425      * ------------ ---------- -----------------------------------
004200170425      *================================================================
004300170425      *
004400170425     H DATEDIT(*YMD)
004500170425     FHSLCUSTB  IF   E           K DISK
004600170425     F                                     RENAME(HSFCUST:HSFCUSTB)
004700170425      * Customer Master by Post Code.
004800170425      *
004900170425     FHSLCUSTA  IF   E           K DISK
005000170425      * Customer Master by Customer Account.
005100170425      *
005200170425     F*LTCUSTAIF  E           K        DISK
005300170425     F*           HSFCUST                           KRENAMEALTCUSTF
005400170425      * Customer Master by Customer Account.
005500170425      *
005600170425     FHSLORDPA  IF   E           K DISK
005700170425      * Sales Order Parameters.
005800170425      *
005900170425     FHSLTRACB  UF   E           K DISK
006000170425      * Voucher Tracking by Product/Series/Serial No./Element No.
006100170425      *
006200170425     FHSLEXPAA  UF A E           K DISK    USROPN
006300170425      * Unbanded Order line file by Product/Series/Serial No.
006400170425      *
006500170425     FHSLVCTLA  UF   E           K DISK
006600170425      * Voucher Control.
006700170425      *
006800170425     FHSLVXRFB  IF   E           K DISK
006900170425      * Agency Product Cross-Reference.
007000170425      *
007100170425     FHSLORDHA  UF A E           K DISK
007200170425      * Sales Order Header.
007300170425      *
007400170425     FHSLORDDB  UF A E           K DISK
007500170425      * Sales Order Detail.
007600170425      *
007700170425     FHSLODELA  UF A E           K DISK
007800170425      * Sales Order Delivery Detail.
007900170425      *
008000170425     FHSLSHPOA  IF   E           K DISK
008100170425      * Ship Only.
008200170425      *
008300170425     FHSLINVMA  UF   E           K DISK
008400170425      * Inventory Master.
008500170425      *
008600170425     FHSLWHSEA  IF   E           K DISK
008700170425      * Warehouse Master.
008800170425      *
008900170425     FHSLCOMPA  IF   E           K DISK
009000170425      * Company Master.
009100170425      *
009200170425     FHSLPRODA  IF   E           K DISK
009300170425      * Product Master.
009400170425      *
009500170425     FHSLDISCA  IF   E           K DISK
009600170425      * Customer Discount File
009700170425      *
009800170425BL   FHSPINVT   UF A E           K DISK
009900170425      * Inventory Transactions.
010000170425      *
010100170425BL   FARTICLE   IF   E           K DISK
010200170425      * FOR ARTCILE XREF
010300170425      *
010400170425     FHSS200    CF   E             WORKSTN INFDS(INFDS)
010500170425     F                                     SFILE(HSS200C:RRNX)
010600170425      * Screen file.
010700170425      *================================================================
010800170425      * Arrays.
010900170425      *
011000170425      * Days in Month for date validation.
011100170425     D DIM             S              2  0 DIM(12) CTDATA PERRCD(12)
011200170425      *================================================================
011300170425      * Data Structures.
011400170425      *
011500170425      * Screen Information DS.
011600170425     D INFDS           DS
011700170425     D  KEY                  369    369
011800170425     D  CSRLOC               370    371B 0
011900170425      *
012000170425     D XXXSDS         SDS           429
012100170425     D  XPGMID           *PROC
012200170425     D  XJOBNO               244    253
012300170425     D  XUSRID               254    263
012400170425      *
012500170425      * General DDMMCCYY date format.
012600170425     D                 DS
012700170425     D  DD                     1      2  0 INZ
012800170425     D  MM                     3      4  0 INZ
012900170425     D  CC                     5      6  0 INZ
013000170425     D  YY                     7      8  0 INZ
013100170425     D  DMCY                   1      8  0
013200170425      *
013300170425      * General CCYYMMDD date format.
013400170425     D                 DS
013500170425     D  CCC                    1      2  0 INZ
013600170425     D  YYY                    3      4  0 INZ
013700170425     D  MMM                    5      6  0 INZ
013800170425     D  DDD                    7      8  0 INZ
013900170425     D  CYMD                   1      8  0
014000170425      *
014100170425      * Input order date format.
014200170425     D                 DS
014300170425     D  JDD                    1      2  0 INZ
014400170425     D  JMM                    3      4  0 INZ
014500170425     D  JCC                    5      6  0 INZ
014600170425     D  JYY                    7      8  0 INZ
014700170425     D  XJORDD                 1      8  0
014800170425      *
014900170425      * Output order date format.
015000170425     D                 DS
015100170425     D  WKC                    1      2  0 INZ
015200170425     D  WKY                    3      4  0 INZ
015300170425     D  WKM                    5      6  0 INZ
015400170425     D  WKD                    7      8  0 INZ
015500170425     D  WKORDD                 1      8  0
015600170425      *
015700170425      *----------------------------------------------------------------
015800170425      * Constants.
015900170425      *
016000170425      * Named hexidecimal constants for function keys.
016100170425     D F03             C                   CONST(X'33')
016200170425     D F04             C                   CONST(X'34')
016300170425     D F06             C                   CONST(X'36')
016400170425     D F07             C                   CONST(X'37')
016500170425     D F10             C                   CONST(X'3A')
016600170425     D F11             C                   CONST(X'3B')
016700170425     D F12             C                   CONST(X'3C')
016800170425      *
016900170425      * Zeros to "SETOF" error indicators.
017000170425     D XZEROS          C                   CONST('0000000000000000000')
017100170425      *
017200170425      *================================================================
017300170425      * M A I N L I N E
017400170425      *================================================================
017500170425      *
017600170425      * Dispatch mode
017700170425     C     YMODE         IFEQ      'D'
017800170425     C                   MOVEL     *ON           *IN75
017900170425     C                   MOVEL     *OFF          *IN79
018000170425     C                   ELSE
018100170425     C                   MOVEL     *OFF          *IN75
018200170425     C                   ENDIF
018300170425     C                   READ      ARTICLE                                99
018400170425      *
018500170425      * Entry mode
018600170425     C     YMODE         IFEQ      'E'
018700170425     C                   MOVEL     *ON           *IN76
018800170425     C                   ELSE
018900170425     C                   MOVEL     *OFF          *IN76
019000170425     C                   ENDIF
019100170425      *
019200170425      * Inquiry mode
019300170425     C     YMODE         IFEQ      'I'
019400170425     C                   MOVEL     *ON           *IN77
019500170425     C                   ELSE
019600170425     C                   MOVEL     *OFF          *IN77
019700170425     C                   ENDIF
019800170425      *
019900170425      * Maintenance mode       changesfordemo
020000170425     C     YMODE         IFEQ      'M'
020100170425     C                   MOVEL     *ON           *IN78
020200170425     C                   ELSE
020300170425     C                   MOVEL     *OFF          *IN78
020400170425     C                   ENDIF
020500170425      *
020600170425      * Program mode
020700170425     C     START         TAG
020800170425     C     YMODE         IFEQ      'I'
020900170425     C     YMODE         OREQ      'D'
021000170425     C     YMODE         OREQ      'M'
021100170425     C     YORDNO        IFNE      *BLANKS
021200170425     C                   MOVEL     YORDNO        XJSORD
021300170425     C                   MOVEL     YORDNO        WKORDN            8 0
021400170425     C     WKORDN        CHAIN     HSLORDHA                           99
021500170425     C                   ENDIF
021600170425     C                   ENDIF
021700170425      *
021800170425     C     YMODE         IFEQ      'D'
021900170425     C                   MOVE      JTYPE         XJTYPE
022000170425     C                   MOVE      JCUST         XJCUST
022100170425     C                   Z-ADD     JORDD         WKORDD
022200170425     C                   Z-ADD     WKC           JCC
022300170425     C                   Z-ADD     WKY           JYY
022400170425     C                   Z-ADD     WKM           JMM
022500170425     C                   Z-ADD     WKD           JDD
022600170425     C                   MOVE      JORDR         XJORDR
022700170425     C                   MOVE      JSORD         XJSORD
022800170425     C     JSTAT         IFEQ      'A'
022900170425     C     JSTAT         OREQ      ' '
023000170425     C                   MOVE      *ON           *IN20
023100170425     C                   ELSE
023200170425     C                   MOVE      *OFF          *IN20
023300170425     C                   MOVEL     'HSV2015'     P0MSID
023400170425     C                   EXSR      YSNDMG
023500170425     C                   ENDIF
023600170425     C     JCUST         CHAIN     HSLCUSTA                           13
023700170425     C                   MOVE      EPCDE         XJPCDE
023800170425     C                   MOVE      ENAM1         XENAM1
023900170425     C     JSORD         SETLL     HSLORDDB
024000170425     C     JSORD         READE     HSLORDDB                               99
024100170425     C     *IN99         DOWEQ     *OFF
024200170425     C                   ADD       KQTYN         XVQTY
024300170425     C     JSORD         READE     HSLORDDB                               99
024400170425     C                   ENDDO
024500170425     C                   Z-ADD     KDISP         XJDISP
024600170425     C                   ELSE
024700170425     C                   EXSR      YCLRSC
024800170425     C                   ENDIF
024900170425      *
025000170425      * Dispatch mode.
025100170425XXX  C     YMODE         IFEQ      'D'
025200170425XXX  C     JSORD         CHAIN     HSLODELA                           99
025300170425XXX  C     VNAM1         IFEQ      *BLANKS
025400170425XXX  C                   MOVEL(P)  ENAM1         XXNAM1
025500170425XXX  C                   MOVEL(P)  ENAM2         XXNAM2
025600170425XXX  C                   MOVEL(P)  EADR1         XXADR1
025700170425XXX  C                   MOVEL(P)  EADR2         XXADR2
025800170425XXX  C                   ELSE
025900170425XXX  C                   MOVEL(P)  VNAM1         XXNAM1
026000170425XXX  C                   MOVE      *BLANKS       XXNAM2
026100170425XXX  C                   MOVEL(P)  VADR1         XXADR1
026200170425XXX  C                   MOVEL(P)  VADR2         XXADR2
026300170425XXX  C                   ENDIF
026400170425XXX  C                   ENDIF
026500170425      *
026600170425      *
026700170425      * Dispatch, or Inquiry, or Maintenance mode.
026800170425XXX  C     YMODE         IFEQ      'I'
026900170425XXX  C     YMODE         OREQ      'D'
027000170425XXX  C     YMODE         OREQ      'M'
027100170425XXX  C                   MOVEL     YCUST         XJCUST
027200170425XXX  C                   MOVEL     YTYPE         XJTYPE
027300170425XXX  C                   ENDIF
027400170425     C     HDR           TAG
027500170425XXX  C                   MOVE      *OFF          *IN47
027600170425      * Display screen to receive Customer No. until F03/F10
027700170425     C     KEY           DOUEQ     F03
027800170425     C     KEY           OREQ      F10
027900170425     C     XERROR        ANDEQ     XNO
028000170425      *
028100170425      * Exit if F03 pressed.
028200170425     C     KEY           IFEQ      F03
028300170425     C                   MOVE      *ON           *INLR
028400170425     C                   LEAVE
028500170425     C                   ENDIF
028600170425      *
028700170425      * Display messages.
028800170425     C                   WRITE     MSGCTL
028900170425      *
029000170425     C                   TIME                    XXTME
029100170425     C                   EXFMT     HSS200A
029200170425      *
029300170425ZZZ  C     XJTYPE        CHAIN     HSLORDPA                           99
029400170425ZZZ  C     MSALE         IFEQ      'C'
029500170425ZZZ  C                   MOVE      *ON           *IN30
029600170425ZZZ  C                   MOVE      XYES          XERROR
029700170425ZZZ  C                   MOVEL     'HSV2027'     P0MSID
029800170425ZZZ  C                   EXSR      YSNDMG
029900170425ZZZ  C                   ITER
030000170425ZZZ  C                   ENDIF
030100170425      *
030200170425XXX  C                   CLEAR                   XVQTY
030300170425XXX  C     *IN20         IFEQ      *OFF
030400170425XXX  C     YMODE         ANDEQ     'D'
030500170425XXX  C                   ITER
030600170425XXX  C                   ENDIF
030700170425      *
030800170425BL   C                   Z-ADD     1             RCDNBR
030900170425      *
031000170425      * Clear messages.
031100170425     C                   EXSR      YCLRMG
031200170425      *
031300170425      * Process the various function keys available on the screen.
031400170425      *
031500170425      * Process Despatch if F07 pressed.
031600170425     C     KEY           IFEQ      F07
031700170425      *
031800170425      * Validate that Order Type is a valid Type.
031900170425     C     XJTYPE        CHAIN     HSLORDPA                           99
032000170425     C     *IN99         IFEQ      *ON
032100170425     C                   MOVE      *ON           *IN30
032200170425     C                   MOVE      XYES          XERROR
032300170425     C                   MOVEL     'HSV2001'     P0MSID
032400170425     C                   EXSR      YSNDMG
032500170425     C                   GOTO      START
032600170425     C                   ENDIF
032700170425     C                   ENDIF
032800170425      *
032900170425     C     YMODE         IFEQ      'D'
033000170425     C     WKORDN        ANDNE     XJSORD
033100170425     C                   MOVEL     XJSORD        WKORDN            8 0
033200170425     C     XJSORD        CHAIN     HSLORDHA                           99
033300170425     C     *IN99         IFEQ      *ON
033400170425     C                   MOVE      *OFF          *IN20
033500170425     C                   MOVEL     'HSV2017'     P0MSID
033600170425     C                   EXSR      YSNDMG
033700170425     C                   ELSE
033800170425     C                   MOVE      JTYPE         XJTYPE
033900170425     C                   MOVE      JCUST         XJCUST
034000170425     C                   Z-ADD     JORDD         WKORDD
034100170425     C                   Z-ADD     WKC           JCC
034200170425     C                   Z-ADD     WKY           JYY
034300170425     C                   Z-ADD     WKM           JMM
034400170425     C                   Z-ADD     WKD           JDD
034500170425     C                   MOVE      JORDR         XJORDR
034600170425     C                   MOVE      JSORD         XJSORD
034700170425     C     JSTAT         IFEQ      'A'
034800170425     C     JSTAT         OREQ      ' '
034900170425     C                   MOVE      *ON           *IN20
035000170425     C                   ELSE
035100170425     C                   MOVE      *OFF          *IN20
035200170425     C                   MOVEL     'HSV2015'     P0MSID
035300170425     C                   EXSR      YSNDMG
035400170425     C                   ENDIF
035500170425     C                   ENDIF
035600170425     C     JCUST         CHAIN     HSLCUSTA                           13
035700170425     C                   MOVE      EPCDE         XJPCDE
035800170425     C                   MOVE      ENAM1         XENAM1
035900170425     C     JSORD         SETLL     HSLORDDB
036000170425     C     JSORD         READE     HSLORDDB                               99
036100170425     C     *IN99         DOWEQ     *OFF
036200170425     C                   ADD       KQTYN         XVQTY
036300170425     C     JSORD         READE     HSLORDDB                               99
036400170425     C                   ENDDO
036500170425     C                   Z-ADD     KDISP         XJDISP
036600170425     C                   GOTO      HDR
036700170425     C                   ENDIF
036800170425      *
036900170425      * Program in inquiry, dispatch or maintenance mode
037000170425     C     YMODE         IFEQ      'I'
037100170425     C     YMODE         OREQ      'M'
037200170425     C     YMODE         OREQ      'D'
037300170425      *
037400170425      * Initialise subfile
037500170425     C                   MOVEA     '1001'        *IN(70)
037600170425     C                   WRITE     HSS200B
037700170425     C     XJSORD        IFNE      0
037800170425     C                   Z-ADD     0             RRNX
037900170425     C     XJSORD        SETLL     HSLORDDB
038000170425     C     *IN97         DOUEQ     *ON
038100170425     C     XJSORD        READE     HSLORDDB                               97
038200170425      *
038300170425      * Build subfile from existing order.
038400170425     C     *IN97         IFEQ      *OFF
038500170425     C                   ADD       1             RRNX
038600170425     C     RRNX          CHAIN     HSS200C                            99
038700170425     C                   Z-ADD     KLINE         XOLIN
038800170425     C                   MOVEL     KLTYP         XSELC
038900170425     C                   MOVEL     KPROD         XKPROD
039000170425     C                   MOVEL     KDESC         XNDESC
039100170425     C                   MOVEL     KSERC         XKSERC
039200170425     C                   Z-ADD     KSERNF        XKSERF
039300170425     C                   Z-ADD     KSERNT        XKSERT
039400170425     C                   Z-ADD     KQTYN         XKQTYN
039500170425     C                   Z-ADD     KPRIC         XKPRIC
039600170425     C                   Z-ADD     KVALU         XKVALU
039700170425XXX  C                   MOVE      XKQTYN        XXQTYN
039800170425BL    *
039900170425BL    * Ship Only - set line value to zero.
040000170425BL   C     SHONLY        IFEQ      'Y'
040100170425BL   C     XSELC         ANDEQ     'S'
040200170425BL   C                   Z-ADD     0             XKVALU
040300170425BL   C                   ENDIF
040400170425BL    *
040500170425BL   C*          #KVALU    MULT MVATP     #KVATA
040600170425      *
040700170425      * Extended value
040800170425     C     XSELC         IFEQ      'S'
040900170425     C     XSELC         OREQ      'N'
041000170425     C     XKPRIC        MULT      XKQTYN        XKVALU
041100170425BL    *
041200170425BL    * Ship Only - set line value to zero.
041300170425BL   C     SHONLY        IFEQ      'Y'
041400170425BL   C     XSELC         ANDEQ     'S'
041500170425BL   C                   Z-ADD     0             XKVALU
041600170425BL   C                   ENDIF
041700170425BL    *
041800170425BL   C*          #KVALU    MULT MVATP     #KVATA
041900170425      *
042000170425     C                   ENDIF
042100170425      *
042200170425      * Write subfile record.
042300170425     C     *IN99         IFEQ      *OFF
042400170425     C                   UPDATE    HSS200C
042500170425     C                   ELSE
042600170425     C                   WRITE     HSS200C
042700170425     C                   ENDIF
042800170425     C                   ENDIF
042900170425     C                   ENDDO
043000170425     C                   ENDIF
043100170425     C                   LEAVE
043200170425     C                   ENDIF
043300170425      *
043400170425      * Program mode - Entry
043500170425     C     YMODE         IFEQ      'E'
043600170425      *
043700170425      * Execute search if F04 pressed.
043800170425     C     KEY           IFEQ      F04
043900170425     C                   EXSR      YSERCH
044000170425XXX  C                   ITER
044100170425XXX  C                   EXSR      YCLRMG
044200170425     C                   ENDIF
044300170425      *
044400170425      * Validate header screen fields.
044500170425     C                   EXSR      VALIDH
044600170425      *
044700170425      * Validate ship only requirements.
044800170425     C                   EXSR      SHPONL
044900170425      *
045000170425     C                   ENDIF
045100170425      *
045200170425      * Process Despatch if F07 pressed.
045300170425RT   C     KEY           IFEQ      F07
045400170425      *
045500170425RT   C                   LEAVE
045600170425RT   C                   ENDIF
045700170425      *
045800170425      * End of DO loops for F03/F10 key checks.
045900170425     C                   ENDDO
046000170425     C                   MOVE      *OFF          *IN61
046100170425      *
046200170425      * Clear messages.
046300170425     C                   EXSR      YCLRMG
046400170425      *
046500170425      * Exit if F03 pressed.
046600170425     C     KEY           IFEQ      F03
046700170425      * Exit program.
046800170425     C                   MOVE      *ON           *INLR
046900170425     C                   RETURN
047000170425     C                   ENDIF
047100170425      *
047200170425      *-------------------------------------------------------
047300170425      *
047400170425      * Program mode - Entry
047500170425      * Retrieve order number.
047600170425     C     YMODE         IFEQ      'E'
047700170425     C     *DTAARA       DEFINE    HSAORDERNO    ORDERX            8 0
047800170425     C     *LOCK         IN        ORDERX
047900170425     C                   ADD       1             ORDERX
048000170425     C                   OUT       ORDERX
048100170425     C                   Z-ADD     ORDERX        XJSORD
048200170425     C                   ENDIF
048300170425      *
048400170425      * Display screen to receive Order Details until F10/F12
048500170425     C     DET           TAG
048600170425      *
048700170425      * Program in inquiry, or dispatch, or maintenance mode
048800170425     C     YMODE         IFEQ      'I'
048900170425     C     YMODE         OREQ      'M'
049000170425     C     YMODE         OREQ      'D'
049100170425     C     KEY           OREQ      F12
049200170425     C                   MOVEL     *OFF          *IN73
049300170425     C                   ELSE
049400170425     C                   MOVEL     *ON           *IN73
049500170425     C                   ENDIF
049600170425      *
049700170425     C     KEY           DOUEQ     F10
049800170425     C     XERROR        ANDEQ     XNO
049900170425     C     KEY           OREQ      F12
050000170425      *
050100170425      * Display messages.
050200170425     C                   WRITE     MSGCTL
050300170425      *
050400170425      * Read subfile to accumulate order value.
050500170425     C     RRNX          IFGT      0
050600170425     C                   Z-ADD     1             RRNVAL
050700170425     C                   Z-ADD     0             XKTVAL
050800170425     C     *IN98         DOUEQ     *ON
050900170425BL   C     RRNVAL        OREQ      100
051000170425BL   C     XSELC         OREQ      *BLANK
051100170425     C     RRNVAL        CHAIN     HSS200C                            98
051200170425     C     XSELC         IFNE      *BLANK
051300170425     C     XKPROD        ANDNE     *BLANK
051400170425     C     *IN98         ANDEQ     *OFF
051500170425     C     XSELC         ORNE      *BLANK
051600170425     C     XNDESC        ANDNE     *BLANK
051700170425     C     *IN98         ANDEQ     *OFF
051800170425     C                   ADD       XKVALU        XKTVAL
051900170425     C                   ENDIF
052000170425     C                   ADD       1             RRNVAL
052100170425     C                   ENDDO
052200170425     C                   ENDIF
052300170425      *
052400170425      * Dispatch mode.
052500170425XXX  C     YMODE         IFEQ      'D'
052600170425XXX  C     XJCUST        CHAIN     HSLCUSTA                           99
052700170425XXX   * ...load Customer record into screen 2 fields.
052800170425XXX  C                   MOVEL     ENAM1         XJNAM1                         Name 1
052900170425XXX  C                   MOVEL     ENAM2         XJNAM2                         Name 2
053000170425XXX  C                   MOVEL     EADR1         XJADR1                         Address 1
053100170425XXX  C                   MOVEL     EADR2         XJADR2                         Address 2
053200170425XXX  C                   ENDIF
053300170425      *
053400170425      *
053500170425      * Display footer.
053600170425RT   C     KEY           IFNE      F07
053700170425     C                   WRITE     HSS200E
053800170425RT   C                   ENDIF
053900170425      *
054000170425     C                   TIME                    XXTME
054100170425     C                   MOVEA     '011'         *IN(70)
054200170425      *
054300170425RT   C     KEY           IFNE      F07
054400170425     C                   EXFMT     HSS200B
054500170425XXX  C                   MOVE      XNO           XJUMP1
054600170425      *
054700170425     C     KEY           IFNE      F10
054800170425     C                   EXSR      YDELT
054900170425     C                   ENDIF
055000170425      *
055100170425RT   C                   ENDIF
055200170425      *
055300170425     C                   MOVEL     *OFF          *IN73
055400170425     C                   MOVEL     *OFF          *IN86
055500170425      *
055600170425OWE   * Clear messages (Only if an error has not been repeated)
055700170425      *
055800170425OWE  C     XERROR        IFEQ      XNO
055900170425      * Clear messages.
056000170425     C                   EXSR      YCLRMG
056100170425OWE  C                   ENDIF
056200170425      *
056300170425      * Process the various function keys available on the screen.
056400170425      *
056500170425      * Exit if F12 pressed.
056600170425     C     KEY           IFEQ      F12
056700170425     C                   GOTO      HDR
056800170425     C                   ENDIF
056900170425      *
057000170425      * Execute search if F04 pressed.
057100170425     C     KEY           IFEQ      F04
057200170425     C                   EXSR      YSERSF
057300170425     C                   ITER
057400170425     C                   ENDIF
057500170425      *
057600170425      * Check for agency cross-references.
057700170425BL   C     MXREF         IFEQ      'Y'
057800170425     C                   EXSR      AGXREF
057900170425BL   C                   ENDIF
058000170425      *
058100170425OWE   * Validate order detail screen fields (only re-validate data
058200170425OWE   * if it has been changed. Otherwise re-display error message).
058300170425OWE  C     XERROR        IFEQ      XYES
058400170425OWE  C     RRNS          CHAIN     HSS200C                            98
058500170425OWE  C     XSELC         IFNE      TSELC
058600170425OWE  C     XKPROD        ORNE      TPROD
058700170425OWE  C     XKPRIC        ORNE      TPRIC
058800170425OWE  C     XKQTYN        ORNE      TQTYN
058900170425OWE  C     XNDESC        ORNE      TDESC
059000170425OWE  C                   MOVE      *ON           *IN93
059100170425OWE  C                   ENDIF
059200170425OWE  C                   ENDIF
059300170425      *
059400170425OWE  C     *IN93         IFEQ      *ON
059500170425     C     XERROR        OREQ      XNO
059600170425      *
059700170425      * Validate order detail screen fields.
059800170425     C                   EXSR      VALIDD
059900170425OWE  C                   ENDIF
060000170425      *
060100170425      * Discount retrieval.
060200170425     C                   EXSR      DISCNT
060300170425      *
060400170425      * Stock allocation preview
060500170425      *                 - with banded allocation and manual allocation.
060600170425BL   C*          MSALE     IFEQ 'S'
060700170425     C*                    EXSR ALLOCS
060800170425BL   C*                    ENDIF
060900170425      *
061000170425      * Process Dispatch if F07 pressed.
061100170425RT   C     KEY           IFEQ      F07
061200170425      *
061300170425RT   C                   LEAVE
061400170425RT   C                   ENDIF
061500170425      *
061600170425      * End of DO loops for F10/F12 key checks.
061700170425     C                   ENDDO
061800170425      *
061900170425      *-------------------------------------------------------
062000170425      * Confirm order - prompt for delivery details.
062100170425      *               - file updates when F10 pressed.
062200170425     C     KEY           DOUEQ     F10
062300170425     C     XERROR        ANDEQ     XNO
062400170425     C     KEY           OREQ      F12
062500170425      *
062600170425      * Clear messages.
062700170425     C                   EXSR      YCLRMG
062800170425      *
062900170425      * Process the various function keys available on the screen.
063000170425      *
063100170425      * Exit if F12 pressed.
063200170425OOO  C*          KEY       IFEQ F12
063300170425OOO  C*                    GOTO DET
063400170425OOO  C*                    ENDIF
063500170425      *
063600170425      * Check for minimum order value.
063700170425RT   C     KEY           IFNE      F07
063800170425     C     MORDV         IFGT      0
063900170425     C                   EXSR      MINVAL
064000170425     C                   ENDIF
064100170425      *
064200170425XXX   * Credit limit check.... Warning only.
064300170425XXX  C     XKTVAL        ADD       XJTYSL        TOT              20 5
064400170425XXX  C     TOT           IFGT      XJCLIM
064500170425XXX  C                   MOVE      *ON           *IN46
064600170425XXX  C                   MOVEL     'HSV2019'     P0MSID
064700170425XXX  C                   EXSR      YSNDMG
064800170425XXX  C                   ENDIF
064900170425RT   C                   ENDIF
065000170425      *
065100170425      * Display messages.
065200170425     C                   WRITE     MSGCTL
065300170425      *
065400170425      * Display key text footer.
065500170425XXXM C*                    WRITEHSS200E
065600170425RT   C     KEY           IFNE      F07
065700170425XXXM C                   WRITE     HSS200F
065800170425RT   C                   ENDIF
065900170425      *
066000170425      * Delivery address prompt screen.
066100170425     C                   TIME                    XXTME
066200170425      *
066300170425      * Program in inquiry, dispatch or maintenance mode
066400170425     C     YMODE         IFEQ      'I'
066500170425     C     YMODE         OREQ      'M'
066600170425     C     YMODE         OREQ      'D'
066700170425     C     WKORDN        CHAIN     HSLODELA                           99
066800170425      *
066900170425      * Write fields for order delivery detail record.
067000170425     C     *IN99         IFEQ      *OFF
067100170425     C                   MOVEL     VNAM1         XVNAM1
067200170425     C                   MOVEL     VADR1         XVADR1
067300170425     C                   MOVEL     VADR2         XVADR2
067400170425     C                   MOVEL     VADR3         XVADR3
067500170425     C                   MOVEL     VPCDE         XVPCDE
067600170425     C                   MOVEL     VDIN1         XVDIN1
067700170425     C                   MOVEL     VDIN2         XVDIN2
067800170425     C                   MOVEL     VDIN3         XVDIN3
067900170425     C                   ENDIF
068000170425     C                   ENDIF
068100170425      *
068200170425      * Write order delivery details record.
068300170425RT   C     KEY           IFNE      F07
068400170425     C                   EXFMT     HSS200D
068500170425RT   C                   ENDIF
068600170425      *
068700170425OWE   * Exit if F12 pressed.
068800170425OWE  C     KEY           IFEQ      F12
068900170425     C                   EXSR      YDELT
069000170425OWE  C                   GOTO      DET
069100170425OWE  C                   ENDIF
069200170425      *
069300170425      * Clear messages.
069400170425XXX  C     *IN47         IFEQ      *OFF
069500170425     C                   EXSR      YCLRMG
069600170425XXX  C                   ENDIF
069700170425      *
069800170425      * Update all files, if no errors exist.
069900170425     C     KEY           IFEQ      F10
070000170425     C     XERROR        ANDEQ     XNO
070100170425RT   C     KEY           OREQ      F07
070200170425     C                   Z-ADD     1             RRNX
070300170425     C     *IN98         DOUEQ     *ON
070400170425BL   C     RRNX          OREQ      100
070500170425BL   C     XSELC         OREQ      *BLANK
070600170425     C     RRNX          CHAIN     HSS200C                            98
070700170425     C     XSELC         IFNE      *BLANK
070800170425     C     XKPROD        ANDNE     *BLANK
070900170425     C     *IN98         ANDEQ     *OFF
071000170425     C     XSELC         ORNE      *BLANK
071100170425     C     XNDESC        ANDNE     *BLANK
071200170425     C     *IN98         ANDEQ     *OFF
071300170425      *
071400170425      * Save RRN for current order line.
071500170425     C                   Z-ADD     RRNX          RRNLIN
071600170425      *
071700170425OWE   * Update Voucher Control if in entry mode....
071800170425OWE  C     YMODE         IFEQ      'E'
071900170425BL   C     MSALE         ANDEQ     'S'
072000170425OWE  C                   EXSR      UPPVCT
072100170425OWE  C                   ENDIF
072200170425      *
072300170425      * Re-position to required subfile line
072400170425     C                   Z-ADD     RRNLIN        RRNX
072500170425     C     RRNX          CHAIN     HSS200C                            98
072600170425      *
072700170425BL    * Create/Update order details if in Entry,Maint,or Dispatch mode.
072800170425BL   C     YMODE         IFEQ      'E'
072900170425BL   C     YMODE         OREQ      'D'
073000170425BL   C     YMODE         OREQ      'M'
073100170425     C                   EXSR      UPORDD
073200170425BL   C                   ENDIF
073300170425      *
073400170425BL    * Update voucher tracking if in Entry or Dispatch mode.
073500170425BL    * Stock lines only.
073600170425     C     YMODE         IFEQ      'E'
073700170425     C     XSELC         ANDEQ     'S'
073800170425BL   C     YMODE         OREQ      'D'
073900170425BL   C     XSELC         ANDEQ     'S'
074000170425     C                   EXSR      UPTRAC
074100170425BL   C                   ENDIF
074200170425      *
074300170425BL    * Allocate inventory if in Entry mode.
074400170425BL    * Stock lines only.
074500170425BL   C     YMODE         IFEQ      'E'
074600170425BL   C     XSELC         ANDEQ     'S'
074700170425      * Update inventory allocations.
074800170425     C                   EXSR      UPINVA
074900170425     C                   ENDIF
075000170425      *
075100170425BL    * Sell inventory if in Dispatch mode.
075200170425BL    * Stock lines only.
075300170425BL   C     YMODE         IFEQ      'D'
075400170425BL   C     XSELC         ANDEQ     'S'
075500170425      * Update inventory sales.
075600170425BL   C                   EXSR      UPINVS
075700170425      *
075800170425      * Create inventory sales transaction.
075900170425     C                   EXSR      UPINVT
076000170425     C                   ENDIF
076100170425     C                   ENDIF
076200170425     C                   ADD       1             RRNX
076300170425     C                   ENDDO
076400170425      *
076500170425BL    * Create/Update order header if in Entry,Maint,or Dispatch mode.
076600170425BL   C     YMODE         IFEQ      'E'
076700170425BL   C     YMODE         OREQ      'D'
076800170425BL   C     YMODE         OREQ      'M'
076900170425     C                   EXSR      UPORDH
077000170425      *
077100170425      * Create/update delivery record if in Entry,Maint or Dispat.mode.
077200170425     C                   EXSR      UPODEL
077300170425BL   C                   ENDIF
077400170425      *
077500170425BL    * Ship to all delivery points if in Entry mode.
077600170425BL   C     YMODE         IFEQ      'E'
077700170425BL   C     MALLP         ANDEQ     'Y'
077800170425     C                   EXSR      SHPALL
077900170425BL   C                   ENDIF
078000170425      *
078100170425BL    * Print delivery note if in Entry mode, and charges only not set.
078200170425BL   C     YMODE         IFEQ      'E'
078300170425BL   C     MINVC         ANDNE     'Y'
078400170425     C                   EXSR      PRTDEL
078500170425BL   C                   ENDIF
078600170425      *
078700170425BL    * Print Invoice if in Entry mode, and Immediate print required.
078800170425BL   C     YMODE         IFEQ      'E'
078900170425BL   C     MINVP         ANDEQ     'I'
079000170425     C                   EXSR      PRTINV
079100170425BL   C                   ENDIF
079200170425      *
079300170425     C                   ENDIF
079400170425      * Process Despatch if F07 pressed.
079500170425RT   C     KEY           IFEQ      F07
079600170425     C                   EXSR      YCLRSC
079700170425      *
079800170425RT   C                   LEAVE
079900170425RT   C                   ENDIF
080000170425      *
080100170425      * End of Confirmation.
080200170425     C                   ENDDO
080300170425      *
080400170425      * Return to order details if F12 pressed.
080500170425     C     KEY           IFEQ      F12
080600170425     C                   GOTO      DET
080700170425     C                   ENDIF
080800170425      *
080900170425      * Clear Subfile
081000170425     C                   MOVEA     '1000'        *IN(70)
081100170425     C                   WRITE     HSS200B
081200170425      *
081300170425      * Clear contents of HSPEXPA.
081400170425     C                   EXSR      YDELT
081500170425      *
081600170425      * Return to order header.
081700170425     C                   GOTO      HDR
081800170425      *
081900170425      *****************************************************************
082000170425      *----------------------------------------------------------------
082100170425      * @CLRSC - Clear screen fields.
082200170425      *----------------------------------------------------------------
082300170425      *
082400170425     C     YCLRSC        BEGSR
082500170425      *
082600170425BL    * Clear header screen fields.
082700170425BL   C     YMODE         IFNE      'E'
082800170425     C                   CLEAR                   XJTYPE
082900170425BL   C                   ENDIF
083000170425BL   C     YMODE         IFEQ      'D'
083100170425     C                   CLEAR                   XJSORD
083200170425     C                   CLEAR                   XENAM1
083300170425     C                   CLEAR                   XVQTY
083400170425BL   C                   ENDIF
083500170425     C                   CLEAR                   XJCOMP
083600170425     C                   CLEAR                   XJWHSE
083700170425     C                   CLEAR                   XJPCDE
083800170425     C                   CLEAR                   XJCUST
083900170425     C                   CLEAR                   XJDISP
084000170425     C                   CLEAR                   XJORDD
084100170425     C                   CLEAR                   XJORDR
084200170425      *
084300170425BL    * Clear delivery screen fields.
084400170425BL   C                   CLEAR                   XVNAM1
084500170425BL   C                   CLEAR                   XVADR1
084600170425BL   C                   CLEAR                   XVADR2
084700170425BL   C                   CLEAR                   XVADR3
084800170425BL   C                   CLEAR                   XVPCDE
084900170425BL   C                   CLEAR                   XVDIN1
085000170425BL   C                   CLEAR                   XVDIN2
085100170425BL   C                   CLEAR                   XVDIN3
085200170425     C                   ENDSR
085300170425      *
085400170425      *----------------------------------------------------------------
085500170425      * SHPONL - Validate ship only requirements.
085600170425      *----------------------------------------------------------------
085700170425     C     SHPONL        BEGSR
085800170425      *
085900170425      * Check if a ship only record exists for this customer
086000170425     C     XJCUST        CHAIN     HSLSHPOA                           99
086100170425     C     *IN99         IFEQ      *OFF
086200170425     C                   MOVEL     'Y'           SHONLY            1
086300170425BL   C                   ELSE
086400170425BL   C                   MOVEL     ' '           SHONLY
086500170425     C                   ENDIF
086600170425     C                   ENDSR
086700170425      *
086800170425      *----------------------------------------------------------------
086900170425      * AGXREF - Check for agency cross-references.
087000170425      *----------------------------------------------------------------
087100170425     C     AGXREF        BEGSR
087200170425     C     KEYXRF        CHAIN     HSLVXRFB                           99
087300170425     C     *IN99         IFEQ      *OFF
087400170425     C                   MOVEL     HPROD         KPROD
087500170425     C                   MOVEL     HPROD         XKPROD
087600170425     C                   ENDIF
087700170425     C                   ENDSR
087800170425      *
087900170425      *----------------------------------------------------------------
088000170425      * VALIDD - Validate order detail screen fields.
088100170425      *----------------------------------------------------------------
088200170425     C     VALIDD        BEGSR
088300170425      *
088400170425      * Order Detail validation:
088500170425      *
088600170425      * Reset work values.
088700170425     C*                    Z-ADD0         RRN#
088800170425OWEM C                   Z-ADD     0             RRNS              5 0
088900170425OWE  C                   Z-ADD     1             RRNT              5 0
089000170425     C                   RESET                   XERROR
089100170425     C                   MOVE      *OFF          *IN61                          Hide F10/F11
089200170425      *
089300170425      * Reset error indicators.
089400170425     C                   MOVEA     XZEROS        *IN(30)
089500170425      *
089600170425      * Read all Records from subfile and validate contents.
089700170425     C     *IN99         DOUEQ     *ON                                          ..Do1
089800170425OWE   *
089900170425OWE   * Process the subfile in one of two modes depending on whether
090000170425OWE   * a previous change to the subfile has been made....
090100170425OWE   *
090200170425OWE  C     *IN82         IFEQ      *OFF
090300170425OWE  C                   READC     HSS200C                                99
090400170425OWE  C                   Z-ADD     RRNX          RRNT
090500170425OWE  C                   ADD       1             RRNT
090600170425OWE  C                   ELSE
090700170425OWE  C     RRNT          IFEQ      101
090800170425OWE  C                   LEAVE
090900170425OWE  C                   ENDIF
091000170425OWE  C     RRNT          CHAIN     HSS200C                            99
091100170425OWE  C                   ADD       1             RRNT
091200170425OWE  C                   ENDIF
091300170425      *
091400170425     C*                    READCHSS200C                  99
091500170425      * Retrieve subfile record.
091600170425     C     *IN99         IFEQ      *OFF                                         ...If2
091700170425OWE  C                   MOVE      XKPROD        TPROD1           13
091800170425OWE  C                   MOVE      XKQTYN        TQTYN1           15 0
091900170425OWE  C                   MOVE      *ON           *IN82
092000170425      *
092100170425      * Reset subfile error indicators.
092200170425     C                   MOVEA     '00000000'    *IN(36)
092300170425      *
092400170425     C     XSELC         IFNE      *BLANK                                       ....If3
092500170425     C     XKPROD        ORNE      *BLANK                                       ....If3
092600170425     C     XNDESC        ORNE      *BLANK                                       ....If3
092700170425     C     XKPRIC        ORNE      *ZEROS                                       ....If3
092800170425     C     XKQTYN        ORNE      *ZEROS                                       ....If3
092900170425     C     XKVALU        ORNE      *ZEROS                                       ....If3
093000170425     C     XKVATA        ORNE      *ZEROS                                       ....If3
093100170425     C     XKSERC        ORNE      *BLANKS                                      ....If3
093200170425     C     XKSERF        ORNE      *ZEROS                                       ....If3
093300170425     C     XKSERT        ORNE      *ZEROS                                       ....If3
093400170425      *
093500170425      * Count active subfile records.
093600170425OWE  C*                    ADD  1         RRN#
093700170425OWE  C                   ADD       1             RRNS
093800170425      *
093900170425      * Validate Selection code.
094000170425     C     XSELC         IFNE      'S'
094100170425     C     XSELC         ANDNE     'N'
094200170425     C     XSELC         ANDNE     'T'
094300170425      *
094400170425      * Validate Selection code / Product code / Text combination
094500170425     C     XSELC         OREQ      *BLANK
094600170425     C     XKPROD        ANDNE     *BLANKS
094700170425     C     XSELC         OREQ      *BLANK
094800170425     C     XNDESC        ANDNE     *BLANKS
094900170425     C     XSELC         OREQ      *BLANK
095000170425     C     XKPRIC        ANDNE     0
095100170425     C     XSELC         OREQ      *BLANK
095200170425     C     XKQTYN        ANDNE     0
095300170425     C     XSELC         OREQ      'T'
095400170425     C     XKPROD        ANDNE     *BLANKS
095500170425     C     XSELC         OREQ      'T'
095600170425     C     XKPRIC        ANDNE     0
095700170425     C     XSELC         OREQ      'T'
095800170425     C     XKQTYN        ANDNE     0
095900170425     C     XSELC         OREQ      'T'
096000170425     C     XKSERC        ANDNE     *BLANKS
096100170425     C     XSELC         OREQ      'T'
096200170425     C     XKSERF        ANDNE     0
096300170425     C     XSELC         OREQ      'T'
096400170425     C     XKSERT        ANDNE     0
096500170425     C     XSELC         OREQ      'S'
096600170425     C     XKQTYN        ANDEQ     0
096700170425     C*          #SELC     OREQ 'S'
096800170425     C*          #KPRIC    ANDEQ0
096900170425     C     XSELC         OREQ      'N'
097000170425     C     XKQTYN        ANDEQ     0
097100170425     C     XSELC         OREQ      'N'
097200170425     C     XKPRIC        ANDEQ     0
097300170425     C                   MOVE      *ON           *IN36
097400170425     C                   MOVE      XYES          XERROR
097500170425     C                   MOVEL     'HSV2006'     P0MSID
097600170425     C                   EXSR      YSNDMG
097700170425     C                   ENDIF
097800170425      *
097900170425      * Validate Selection code for Invoice Charge Only order type.
098000170425     C     XSELC         IFEQ      'S'
098100170425     C     MINVC         ANDEQ     'Y'
098200170425     C                   MOVE      *ON           *IN36
098300170425     C                   MOVE      XYES          XERROR
098400170425     C                   MOVEL     'HSV2014'     P0MSID
098500170425     C                   EXSR      YSNDMG
098600170425     C                   ENDIF
098700170425      *
098800170425XXX  C     YMODE         IFEQ      'D'
098900170425XXX  C     XKQTYN        ANDGT     XXQTYN
099000170425XXX  C                   MOVE      XYES          XERROR
099100170425XXX  C                   MOVEL     'HSV2020'     P0MSID
099200170425XXX  C                   EXSR      YSNDMG
099300170425XXX  C                   LEAVE
099400170425XXX  C                   ELSE
099500170425XXX  C                   EXSR      YCLRMG
099600170425XXX  C                   ENDIF
099700170425      *
099800170425      * Validate Product.
099900170425     C     XSELC         IFEQ      'S'
100000170425     C     XKPROD        IFNE      *BLANKS
100100170425     C     XKPROD        CHAIN     HSLPRODA                           99
100200170425     C     *IN99         IFEQ      *ON
100300170425     C                   MOVE      *ON           *IN37
100400170425     C                   MOVE      XYES          XERROR
100500170425     C                   MOVEL     'HSV2007'     P0MSID
100600170425     C                   EXSR      YSNDMG
100700170425     C                   ELSE
100800170425     C                   MOVEL     NDESC         XNDESC
100900170425     C                   Z-ADD     NPRIC         XKPRIC
101000170425     C                   ENDIF
101100170425     C                   ENDIF
101200170425     C                   ENDIF
101300170425      *
101400170425      * Reverse price for Credit
101500170425     C     MSALE         IFEQ      'C'
101600170425     C                   Z-SUB     XKPRIC        XKPRIC
101700170425     C                   ENDIF
101800170425      *
101900170425      * Extended value
102000170425     C     XSELC         IFEQ      'S'
102100170425     C     XSELC         OREQ      'N'
102200170425     C     XKPRIC        MULT      XKQTYN        XKVALU
102300170425BL    *
102400170425BL   C*          #KVALU    MULT MVATP     #KVATA
102500170425     C                   ENDIF
102600170425      *
102700170425OWE   * Save Price, Value and Description field contents....
102800170425OWE  C                   MOVE(P)   XKPRIC        TKPRIC            9 2
102900170425OWE  C                   MOVE(P)   XKVALU        TKVALU            9 2
103000170425OWE  C                   MOVE(P)   XNDESC        TNDESC           19
103100170425      *
103200170425      * Check quantity against allocated serial numbers.
103300170425OOO  C*          #KQTYN    IFNE 0
103400170425OOO  C*          #KSERF    ANDNE0
103500170425OOO  C*          #KSERT    ANDNE0
103600170425OOO  C*          #KSERT    SUB  #KSERF    WKQTYN
103700170425OOO  C*                    ADD  1         WKQTYN
103800170425OOO  C*          #KQTYN    IFNE WKQTYN
103900170425OOO  C*                    MOVEA'1011'    *IN,40
104000170425OOO  C*                    MOVE #YES      #ERROR
104100170425OOO  C*                    MOVEL'HSV2013' P0MSID
104200170425OOO  C*                    EXSR @SNDMG
104300170425OOO  C*                    ENDIF
104400170425OOO  C*                    ENDIF
104500170425      *
104600170425      * Check voucher control if not yet allocated
104700170425     C     XSELC         IFEQ      'S'
104800170425     C     XKQTYN        ANDGT     0
104900170425OOO  C*          #KSERC    IFEQ *BLANKS
105000170425OOO  C*          #KSERF    ANDEQ0
105100170425OOO  C*          #KSERT    ANDEQ0
105200170425     C                   MOVEL     'U'           WKVCTL
105300170425     C                   EXSR      UPVCTL
105400170425     C                   ENDIF
105500170425OOO  C*                    ENDIF
105600170425      *
105700170425      * Update subfile record with DSPATR settings and set SFLRCDNBR.
105800170425     C                   Z-ADD     RRNX          RCDNBR
105900170425OWE  C                   MOVE      TKPRIC        XKPRIC
106000170425OWE  C                   MOVE      TKVALU        XKVALU
106100170425OWE  C                   MOVE      TNDESC        XNDESC
106200170425     C                   UPDATE    HSS200C                                      SFL
106300170425     C                   MOVEA     '00000000'    *IN(36)
106400170425      *
106500170425      * If errors encountered in subfile then exit subfile validation.
106600170425     C     XERROR        IFEQ      XYES
106700170425OWE  C                   MOVEL(P)  XSELC         TSELC             1
106800170425OWE  C                   MOVEL(P)  XKPROD        TPROD            13
106900170425OWE  C                   MOVEL(P)  XKPRIC        TPRIC             9 2
107000170425OWE  C                   MOVEL(P)  XKQTYN        TQTYN             9 0
107100170425OWE  C                   MOVEL(P)  XNDESC        TDESC            19
107200170425OOO  C*                    Z-ADDRRN#      RRNS    50
107300170425     C                   LEAVE
107400170425     C                   ENDIF
107500170425      *
107600170425      * End of non-blank subfile check.
107700170425     C                   ENDIF                                                  ....EndIf3
107800170425      *
107900170425      * End of Subfile CHAIN check.
108000170425     C                   ENDIF                                                  ...EndIf2
108100170425      *
108200170425      * End of loop for next subfile record.
108300170425     C                   ENDDO                                                  ..EndDo1
108400170425      *
108500170425      * Save last RRN number used.
108600170425BL   C*                    Z-ADDRRN#      SAVRRN
108700170425      *
108800170425      * If no errors found...
108900170425     C     XERROR        IFEQ      XNO
109000170425      * ...display "Data valid.Press F10 to update" message...
109100170425     C                   MOVEL     'HSV9006'     P0MSID
109200170425     C                   EXSR      YSNDMG
109300170425      * ...activate F10 key (*IN61=*ON).
109400170425     C                   MOVE      *ON           *IN61
109500170425     C                   ENDIF
109600170425XXX  C     XJUMP1        IFEQ      XYES
109700170425XXX  C     *IN52         ANDEQ     *ON
109800170425     C                   CALL      'HSR342'
109900170425     C                   ENDIF
110000170425XXX  C                   MOVE      *OFF          *IN52
110100170425     C                   ENDSR
110200170425      *
110300170425      *----------------------------------------------------------------
110400170425      * DISCNT - Discount retrieval.
110500170425      *----------------------------------------------------------------
110600170425      *
110700170425     C     DISCNT        BEGSR
110800170425      *
110900170425      * If customer discount is not entered on header screen either
111000170425      * caluclate from HSPDISC file keyed on Order Value or default
111100170425      * according to Customer Type.
111200170425      *
111300170425     C     XJDISP        IFEQ      0
111400170425      *
111500170425      * Setup key list for HSPDISC
111600170425      *
111700170425     C                   Z-ADD     XKTVAL        PFAMT
111800170425      *
111900170425      * SETLL on HSLDISCA
112000170425      *
112100170425     C     DSCKEY        SETLL     HSLDISCA                               99
112200170425      *
112300170425      * If record not found READP
112400170425      *
112500170425     C     *IN99         IFEQ      *OFF
112600170425     C                   READP     HSLDISCA                               99
112700170425      *
112800170425      * If not BOF
112900170425      *
113000170425     C     *IN99         IFEQ      *OFF
113100170425BL   C     PCTYP         ANDEQ     ECTYP
113200170425     C                   Z-ADD     PDISC         KDISP
113300170425      *
113400170425      * Else calculate discount according to Customer Type
113500170425      *
113600170425     C                   ELSE
113700170425      *
113800170425     C                   SELECT
113900170425      *
114000170425      * If Customer Type is '001' - Z-ADD 10 to discount
114100170425      *
114200170425     C     ECTYP         WHENEQ    '001'
114300170425     C                   Z-ADD     10            KDISP
114400170425      *
114500170425      * If Customer Type is '002' - Z-ADD 20 to discount
114600170425      *
114700170425     C     ECTYP         WHENEQ    '002'
114800170425     C                   Z-ADD     20            KDISP
114900170425      *
115000170425     C                   ENDSL
115100170425      *
115200170425     C                   ENDIF
115300170425      *
115400170425      * Record found on SETLL
115500170425      *
115600170425     C                   ELSE
115700170425      *
115800170425     C                   Z-ADD     PDISC         KDISP
115900170425      *
116000170425     C                   ENDIF
116100170425      *
116200170425      * #JDISP not equal to 0
116300170425      *
116400170425     C                   ELSE
116500170425     C                   Z-ADD     XJDISP        KDISP
116600170425      *
116700170425     C                   ENDIF
116800170425      *
116900170425     C                   ENDSR
117000170425      *
117100170425      *----------------------------------------------------------------
117200170425      * Check for minimum order value.
117300170425      *----------------------------------------------------------------
117400170425     C     MINVAL        BEGSR
117500170425     C                   Z-ADD     0             WKTOTV
117600170425     C                   Z-ADD     1             RRNP
117700170425      *
117800170425      * Accumulate order total value
117900170425     C     *IN99         DOUEQ     *ON
118000170425BL   C     RRNP          OREQ      100
118100170425BL   C     XSELC         OREQ      *BLANK
118200170425     C     RRNP          CHAIN     HSS200C                            99
118300170425     C     *IN99         IFEQ      *OFF
118400170425     C                   ADD       XKVALU        WKTOTV
118500170425     C                   ENDIF
118600170425     C                   ADD       1             RRNP
118700170425     C                   ENDDO
118800170425      *
118900170425      * Compare order total value and minimum order value
119000170425     C     WKTOTV        IFLT      MORDV
119100170425     C                   MOVE      XYES          XERROR
119200170425     C                   MOVEL     'HSV2011'     P0MSID
119300170425     C                   EXSR      YSNDMG
119400170425     C                   ENDIF
119500170425     C                   Z-ADD     1             RRNP
119600170425     C                   Z-ADD     1             RRNX
119700170425     C                   ENDSR
119800170425      *
119900170425      *----------------------------------------------------------------
120000170425      * Ship to all delivery points.
120100170425      *----------------------------------------------------------------
120200170425     C     SHPALL        BEGSR
120300170425     C*
120400170425     C* SETLL on HSLCUSTA with Customer Number
120500170425     C*
120600170425     C     XJCUST        SETLL     HSLCUSTA
120700170425     C*
120800170425     C* READE on HSLCUSTA with Customer Number
120900170425     C*
121000170425     C     XJCUST        READE     HSLCUSTA                               99
121100170425     C*
121200170425     C* If not EOF
121300170425     C*
121400170425     C     *IN99         DOWEQ     *OFF
121500170425     C*
121600170425     C* If ECGRP not equal to blanks
121700170425     C*
121800170425     C     ECGRP         IFNE      *BLANKS
121900170425     C*
122000170425     C* CHAIN to Customer File for Delivery Name and Address
122100170425     C*
122200170425     C*          ECGRP     CHAINALTCUSTF             13
122300170425     C*
122400170425     C*          *IN13     IFEQ *OFF
122500170425     C*
122600170425     C* Write Order Header Record
122700170425     C*
122800170425     C                   EXSR      UPORDH
122900170425     C*
123000170425     C* Set up Delivery Name and Address
123100170425     C*
123200170425     C                   MOVEL     ENAM1         XVNAM1
123300170425     C                   MOVEL     EADR1         XVADR1
123400170425     C                   MOVEL     EADR2         XVADR2
123500170425     C                   MOVEL     EADR3         XVADR3
123600170425     C                   MOVEL     EPCDE         XVPCDE
123700170425     C*
123800170425     C* Write Order Delivery Record
123900170425     C*
124000170425     C                   EXSR      UPODEL
124100170425     C*
124200170425     C* Write Order Detail Record
124300170425     C*
124400170425     C                   EXSR      UPORDD
124500170425     C*
124600170425     C* ECGRP equal to blanks
124700170425     C*
124800170425     C*                    ENDIF
124900170425     C*
125000170425     C* Customer Record not found
125100170425     C*
125200170425     C                   ENDIF
125300170425     C*
125400170425     C* Increment order number
125500170425     C*
125600170425     C     *LOCK         IN        ORDERX
125700170425     C                   ADD       1             ORDERX
125800170425     C                   OUT       ORDERX
125900170425     C                   Z-ADD     ORDERX        XJSORD
126000170425     C*
126100170425     C* READE on HSLCUSTA with Customer Number
126200170425     C*
126300170425     C     XJCUST        READE     HSLCUSTA                               99
126400170425     C*
126500170425     C                   ENDDO
126600170425     C*
126700170425     C* EOF on HSLCUSTA
126800170425     C*
126900170425     C                   ENDSR
127000170425      *
127100170425      *----------------------------------------------------------------
127200170425      * Update voucher control.
127300170425      *----------------------------------------------------------------
127400170425     C     UPVCTL        BEGSR
127500170425      *
127600170425     C                   MOVE      *ON           *IN85
127700170425      * Save order line values
127800170425      *
127900170425     C                   Z-ADD     0             XQUAN             9 0
128000170425     C                   MOVE      XNO           XJUMP             1
128100170425      * Clear flag for successful range allocation.
128200170425     C                   MOVEL     *BLANK        WKRANG
128300170425      *
128400170425      * Clear flag for first tracking record found.
128500170425     C                   MOVEL     XNO           XFIRST            1
128600170425      *
128700170425      * Get Serial number range.
128800170425     C                   MOVEL     *BLANKS       WKSERC
128900170425     C     *IN92         DOUEQ     *ON
129000170425     C     WKRANG        OREQ      'Y'
129100170425      *
129200170425OWE   * Work back through the subfile checking for duplicate
129300170425OWE   * product codes.... If found validate data under DOUB subroutine.
129400170425      *
129500170425OWE  C                   MOVE      RRNX          RRNXX             5 0
129600170425OWE  C     RRNX          DOUEQ     0
129700170425OWE  C                   SUB       1             RRNX
129800170425OWE  C     RRNX          IFEQ      0
129900170425OWE  C                   LEAVE
130000170425OWE  C                   ENDIF
130100170425OWE  C     RRNX          CHAIN     HSS200C                            90
130200170425OWE  C     XKPROD        IFEQ      TPROD1
130300170425OWE  C                   MOVE      RRNXX         RRNX
130400170425OWE  C                   EXSR      DOUB
130500170425OWE  C                   MOVE      *ON           *IN81
130600170425OWE  C                   LEAVE
130700170425OWE  C                   ENDIF
130800170425OWE  C                   ENDDO
130900170425      *
131000170425OWE   * Reset subfile position.....
131100170425OWE  C                   MOVE      RRNXX         RRNX
131200170425OWE  C     RRNX          CHAIN     HSS200C                            90
131300170425      *
131400170425      * Exit from subroutine if DOUB sr has been processed....
131500170425      *
131600170425OWE  C     *IN81         IFEQ      *ON
131700170425OWE  C                   MOVE      XKSERF        XKSERF
131800170425OWE  C                   MOVE      XKSERC        XKSERC
131900170425OWE  C                   MOVE      XKSERT        XKSERT
132000170425OWE  C                   MOVE      *OFF          *IN81
132100170425OWE  C                   LEAVE
132200170425OWE  C                   ENDIF
132300170425      *
132400170425     C     VCHKEY        SETLL     HSLVCTLA
132500170425     C     XKPROD        READE     HSLVCTLA                               92
132600170425      *
132700170425      * Move pointer file values into temporary fields....
132800170425      *
132900170425     C                   MOVE      BPROD         OPROD            13
133000170425     C                   MOVE      BSERCC        OSERC             3
133100170425     C                   MOVE      BSERNN        OSERN             9 0
133200170425     C                   Z-ADD     BSERNN        WKSERN
133300170425     C                   MOVE      BSERCC        WKSERC
133400170425     C                   Z-ADD     BSERNN        XXSERF            9 0
133500170425     C********             SUB  1         ##SERF
133600170425      *
133700170425      *
133800170425     C     *IN92         IFEQ      *OFF
133900170425      *
134000170425      * Scan voucher tracking file for first available voucher....
134100170425      *
134200170425     C                   MOVE      BSERCC        XKSERC
134300170425     C                   MOVE      OSERN         XKSERF
134400170425      *
134500170425     C     *IN94         DOUEQ     *ON
134600170425     C     XQUAN         OREQ      XKQTYN
134700170425      *
134800170425     C     *IN85         IFEQ      *ON
134900170425     C     TRCKEY        SETLL     HSLTRACB
135000170425     C                   MOVE      *OFF          *IN85
135100170425     C                   ENDIF
135200170425      *
135300170425     C     XKPROD        READE     HSLTRACB                               94
135400170425      *
135500170425     C     *IN94         IFEQ      *ON
135600170425     C                   LEAVE
135700170425     C                   ENDIF
135800170425      *
135900170425     C     ASERC         IFNE      WKSERC
136000170425     C     ASERN         ORNE      WKSERN
136100170425     C     AALLD         ORNE      *ZEROS
136200170425     C                   ADD       1             DSERN
136300170425      *
136400170425     C     *IN87         IFEQ      *OFF
136500170425     C     XXSERN        ADD       1             XXRES             9 0
136600170425PPP  C*          XXRES     IFNE ASERN
136700170425PPP  C*                    MOVE ASERN     ##SERF
136800170425PPP  C*                    ELSE
136900170425     C                   MOVE      ASERN         XXSERF
137000170425     C                   ADD       1             XXSERF
137100170425     C                   ADD       1             WKSERN
137200170425RRR  C                   MOVE      *ON           *IN85
137300170425RRR  C                   ADD       1             XKSERF
137400170425PPP  C*                    ENDIF
137500170425     C                   ELSE
137600170425      *
137700170425      * No previous error so add to HSPEXPA.....
137800170425     C                   MOVE(P)   WKSERC        XXSERC            3
137900170425     C                   MOVE(P)   WKSERN        XXSERN            9 0
138000170425     C                   SUB       1             WKSERN
138100170425     C                   MOVE      XYES          XJUMP
138200170425XXX  C                   MOVE      XYES          XJUMP1            1
138300170425      *
138400170425     C****       *IN87     IFEQ *ON
138500170425     C                   MOVE      XXSERF        USERNS
138600170425     C                   MOVE      WKSERN        USERNE
138700170425     C                   MOVE      WKSERC        USERCC
138800170425     C                   MOVE      XKPROD        UPROD
138900170425     C                   OPEN      HSLEXPAA
139000170425     C                   WRITE     HSFEXPA
139100170425     C                   CLOSE     HSLEXPAA
139200170425     C*****                ENDIF
139300170425      *
139400170425     C                   MOVE      ASERN         XXSERF
139500170425     C                   ADD       1             DSERN
139600170425     C     DSERN         IFNE      ASERN
139700170425     C     ASERN         SUB       DSERN         DIF               9 0
139800170425     C                   ADD       DIF           XXSERF
139900170425     C                   ENDIF
140000170425      *
140100170425     C                   ADD       1             XKSERF
140200170425     C                   ADD       2             WKSERN
140300170425     C                   MOVE      *ON           *IN85
140400170425     C                   MOVE      *OFF          *IN87
140500170425      *
140600170425XXX  C     ASERC         IFNE      WKSERC
140700170425XXX  C                   MOVE      ASERC         WKSERC
140800170425XXX  C                   MOVE      ASERN         WKSERN
140900170425XXX  C                   MOVE      WKSERC        XKSERC
141000170425XXX  C                   MOVE      WKSERN        XKSERF
141100170425XXX  C                   MOVE      WKSERN        XXSERF
141200170425XXX  C                   MOVE      *ON           *IN85
141300170425XXX  C                   ENDIF
141400170425      *
141500170425     C                   ITER
141600170425     C                   ENDIF
141700170425      *
141800170425     C     ASERC         IFNE      WKSERC
141900170425     C                   MOVE      ASERC         WKSERC
142000170425     C                   MOVE      ASERN         WKSERN
142100170425     C                   MOVE      WKSERC        XKSERC
142200170425XXX  C                   MOVE      WKSERN        XKSERF
142300170425XXX  C                   MOVE      WKSERN        XXSERF
142400170425     C                   MOVE      *ON           *IN85
142500170425     C                   ENDIF
142600170425      *
142700170425     C                   ENDIF
142800170425      *
142900170425      *
143000170425     C     AALLD         IFEQ      *ZEROS
143100170425     C***        *IN87     IFEQ *OFF
143200170425     C***                  ADD  1         ##SERF
143300170425     C***                  ENDIF
143400170425     C                   MOVE      *ON           *IN87
143500170425     C                   ADD       1             XQUAN
143600170425     C                   MOVE      XYES          XFIRST
143700170425     C                   MOVE      ASERC         WKSERC
143800170425     C                   MOVE(P)   ASERN         DSERN             9 0
143900170425     C                   ADD       1             WKSERN
144000170425     C                   ADD       1             XKSERF
144100170425     C                   MOVE      *ON           *IN85
144200170425     C                   ITER
144300170425     C                   ELSE
144400170425     C                   ITER
144500170425     C                   ENDIF
144600170425      *
144700170425     C                   ENDDO
144800170425      *
144900170425     C     XFIRST        IFEQ      XNO
145000170425     C                   MOVE      XYES          XERROR
145100170425     C                   MOVEL     'HSV2024'     P0MSID
145200170425     C                   EXSR      YSNDMG
145300170425     C                   CLEAR                   XKSERC
145400170425     C                   CLEAR                   XKSERT
145500170425     C                   CLEAR                   XKSERF
145600170425     C                   LEAVE
145700170425     C                   ENDIF
145800170425      *
145900170425     C     XQUAN         IFNE      XKQTYN
146000170425     C                   MOVE      XYES          XERROR
146100170425     C                   MOVEL     'HSV2025'     P0MSID
146200170425     C                   EXSR      YSNDMG
146300170425     C                   CLEAR                   XKSERC
146400170425     C                   CLEAR                   XKSERT
146500170425     C                   CLEAR                   XKSERF
146600170425     C*****                MOVE *ON       *IN52
146700170425     C                   LEAVE
146800170425     C                   ENDIF
146900170425      *
147000170425     C                   MOVE      *ON           *IN52
147100170425      *
147200170425     C     XJUMP         IFEQ      XYES
147300170425     C***                  MOVE #YES      #ERROR
147400170425     C                   MOVEL     'HSV2026'     P0MSID
147500170425     C                   EXSR      YSNDMG
147600170425      *
147700170425     C                   SUB       1             WKSERN
147800170425XXX  C                   MOVEL     'Y'           WKRANG
147900170425      *
148000170425     C*****                MOVE XXSERC    #KSERC
148100170425     C*****                MOVE XXSERN    #KSERF
148200170425     C*****      TRCKEY    CHAINHSLTRACB             99
148300170425     C*****      *IN99     IFEQ *OFF
148400170425     C*****                ADD  1         ##SERF
148500170425     C*****                ENDIF
148600170425      *
148700170425     C                   MOVE      XXSERF        USERNS
148800170425     C                   MOVE      WKSERN        USERNE
148900170425     C                   MOVE      WKSERC        USERCC
149000170425     C                   OPEN      HSLEXPAA
149100170425     C                   WRITE     HSFEXPA
149200170425     C                   CLOSE     HSLEXPAA
149300170425      *
149400170425     C                   CLEAR                   XKSERC
149500170425     C                   CLEAR                   XKSERT
149600170425     C                   CLEAR                   XKSERF
149700170425     C                   EXSR      YJUMP
149800170425     C                   MOVE      *ON           *IN86
149900170425     C                   MOVE      *ON           *IN61
150000170425     C                   LEAVE
150100170425     C                   ENDIF
150200170425      *
150300170425      * Series code found.
150400170425     C                   MOVE      BSERCC        XKSERC
150500170425      *
150600170425     C                   Z-ADD     OSERN         XKSERF
150700170425     C                   SUB       1             WKSERN
150800170425     C                   Z-ADD     WKSERN        XKSERT
150900170425      *
151000170425      * Flag successful range allocation.
151100170425     C                   MOVEL     'Y'           WKRANG
151200170425      *
151300170425      * Update if required.
151400170425     C                   ENDIF
151500170425     C                   ENDDO
151600170425      *
151700170425      * Unsuccessful range allocation.
151800170425     C     WKRANG        IFNE      'Y'
151900170425     C                   MOVEA     '111'         *IN(41)
152000170425XXX  C****                 MOVE #YES      #ERROR
152100170425     C                   MOVEL     'HSV2012'     P0MSID
152200170425     C                   EXSR      YSNDMG
152300170425     C                   ENDIF
152400170425      *
152500170425     C                   ENDSR
152600170425      *
152700170425      *----------------------------------------------------------------
152800170425      * Display contents of HSLEXPAA
152900170425      *----------------------------------------------------------------
153000170425      *
153100170425     C     YJUMP         BEGSR
153200170425     C                   ENDSR
153300170425      *
153400170425      *
153500170425      *----------------------------------------------------------------
153600170425      * Delete contents of HSLEXPAA
153700170425      *----------------------------------------------------------------
153800170425      *
153900170425     C     YDELT         BEGSR
154000170425     C                   CALL      'HSC200A'
154100170425     C                   ENDSR
154200170425      *
154300170425      *----------------------------------------------------------------
154400170425      * Repeat of Product Code in a single order
154500170425      *----------------------------------------------------------------
154600170425      *
154700170425OWE  C     DOUB          BEGSR
154800170425      *
154900170425      * Get Serial number range.
155000170425OWE  C                   MOVEL     *BLANKS       WKSERC
155100170425OWE  C     *IN92         DOUEQ     *ON
155200170425OWE  C     WKRANG        OREQ      'Y'
155300170425      *
155400170425OWE  C     VCHKEY        SETLL     HSLVCTLA
155500170425OWE  C     XKPROD        READE     HSLVCTLA                               92
155600170425OWE  C     *IN92         IFEQ      *OFF
155700170425      *
155800170425      * Get available series code.
155900170425OWEM C     BSERNN        ADD       TQTYN1        XXSERN            9 0
156000170425OWE  C*          ##SERN    IFGT BSERNE
156100170425OWE  C*                    MOVELBSERCN    WKSERC
156200170425OWE  C                   ITER
156300170425OWE  C                   ELSE
156400170425      *
156500170425      * Work back through the subfile searching for duplicate
156600170425      * product code/series code combination records......
156700170425      *
156800170425OWE  C                   MOVE(P)   RRNX          RRNXX             5 0
156900170425OWE  C     RRNX          DOUEQ     0
157000170425OWE  C                   SUB       1             RRNX
157100170425OWE  C     RRNX          IFEQ      0
157200170425OWE  C                   MOVE      *ON           *IN83
157300170425OWE  C                   LEAVE
157400170425OWE  C                   ENDIF
157500170425OWE  C     RRNX          CHAIN     HSS200C                            90
157600170425OWE  C     XKSERC        IFEQ      BSERCC
157700170425OWE  C     XKSERT        ADD       TQTYN1        RES               9 0
157800170425OWE  C*          RES       IFLE BSERNE
157900170425OWE  C                   MOVE(P)   XKSERC        KKSERC            3
158000170425OWE  C                   MOVE(P)   XKSERT        KKSERT            9 0
158100170425OWE  C                   LEAVE
158200170425OWE  C                   ELSE
158300170425OWE  C                   MOVE      *ON           *IN84
158400170425OWE  C                   LEAVE
158500170425OWE  C                   ENDIF
158600170425OWE  C*                    ENDIF
158700170425OWE  C                   ENDDO
158800170425      *
158900170425      * Reset the subfile pointer position.....
159000170425OWE  C                   MOVE(P)   RRNXX         RRNX
159100170425OWE  C     RRNX          CHAIN     HSS200C                            90
159200170425      *
159300170425OWE  C     *IN84         IFEQ      *OFF
159400170425OWE  C     *IN83         ANDEQ     *OFF
159500170425OWE   * Series code found.
159600170425OWE  C                   MOVE(P)   KKSERC        XKSERC            3
159700170425OWE   *
159800170425OWE   * Set To serial number for the order.
159900170425OWE  C                   MOVE(P)   RES           XKSERT            9 0
160000170425OWE   *
160100170425OWE   * Set From Serial Number for the order.
160200170425OWE  C     KKSERT        ADD       1             XKSERF            9 0
160300170425OWE   *
160400170425OWE   * Set Next Serial Number for the voucher control.
160500170425OWE  C                   ADD       TQTYN1        BSERNN
160600170425OWE   *
160700170425OWE   * Flag successful range allocation.
160800170425OWE  C                   MOVEL     'Y'           WKRANG
160900170425OWE  C                   ITER
161000170425OWE  C                   ENDIF
161100170425      *
161200170425OWE  C     *IN83         IFEQ      *ON
161300170425OWE  C     *IN84         ANDEQ     *OFF
161400170425OWE  C                   MOVE      *OFF          *IN83
161500170425      *
161600170425OWE   * Series code found.
161700170425OWE  C                   MOVE      BSERCC        XKSERC            3
161800170425OWE   *
161900170425OWE   * Set To serial number for the order.
162000170425OWE  C     BSERNN        ADD       TQTYN1        XKSERT            9 0
162100170425OWE  C                   SUB       1             XKSERT
162200170425OWE   *
162300170425OWE   * Set From Serial Number for the order.
162400170425OWE  C                   Z-ADD     BSERNN        XKSERF
162500170425OWE   *
162600170425OWE   * Set Next Serial Number for the voucher control.
162700170425OWE  C                   ADD       TQTYN1        BSERNN
162800170425OWE   *
162900170425OWE   * Flag successful range allocation.
163000170425OWE  C                   MOVEL     'Y'           WKRANG
163100170425OWE  C                   ITER
163200170425OWE  C                   ENDIF
163300170425OWE  C                   MOVE      *OFF          *IN84
163400170425OWE  C*                    MOVELBSERCN    WKSERC
163500170425      *
163600170425OWE  C*                    ENDIF
163700170425OWE  C                   ENDIF
163800170425OWE  C                   ENDDO
163900170425OWE  C                   ENDSR
164000170425      *----------------------------------------------------------------
164100170425      * Update voucher tracking.
164200170425      *----------------------------------------------------------------
164300170425     C     UPTRAC        BEGSR
164400170425      *
164500170425      * Reverse order date before update.
164600170425BL   C     YMODE         IFEQ      'E'
164700170425     C                   Z-ADD     JDD           WKD
164800170425     C                   Z-ADD     JMM           WKM
164900170425     C                   Z-ADD     JCC           WKC
165000170425     C                   Z-ADD     JYY           WKY
165100170425     C                   Z-ADD     WKORDD        ADFIS
165200170425BL   C                   ENDIF
165300170425      *
165400170425      * Locate voucher record.
165500170425     C     TRCKEY        SETLL     HSLTRACB
165600170425     C     XKPROD        DOUNE     APROD
165700170425     C     *IN99         OREQ      *ON
165800170425     C                   READ      HSLTRACB                               99
165900170425     C     *IN99         IFEQ      *OFF
166000170425      *
166100170425      * Exit if product code or series code does not match.
166200170425     C     XKPROD        IFNE      APROD
166300170425     C     XKSERC        ORNE      ASERC
166400170425     C                   LEAVE
166500170425     C                   ENDIF
166600170425      *
166700170425      * Update vouchers in the serial number range.
166800170425     C     XKSERF        IFLE      ASERN
166900170425     C     XKSERT        ANDGE     ASERN
167000170425BL   C     YMODE         IFEQ      'D'
167100170425BL   C                   MOVEL     XJCUST        ACUST
167200170425BL   C                   Z-ADD     0             ADSPB
167300170425BL   C                   ELSE
167400170425      *
167500170425     C                   Z-ADD     XJSORD        ASORD
167600170425     C                   Z-ADD     WKORDD        ADFIS
167700170425     C                   UPDATE    HSFTRAC
167800170425BL   C                   ENDIF
167900170425     C                   ENDIF
168000170425     C                   ENDIF
168100170425     C                   ENDDO
168200170425     C                   ENDSR
168300170425      *
168400170425      *----------------------------------------------------------------
168500170425      * Update inventory allocations.
168600170425      *----------------------------------------------------------------
168700170425     C     UPINVA        BEGSR
168800170425      *
168900170425      * Update stock quantities.
169000170425     C     IVMKEY        CHAIN     HSLINVMA                           99
169100170425     C     *IN99         IFEQ      *OFF
169200170425      *
169300170425      * Increase allocated quantity and reduce available quantity.
169400170425     C                   ADD       XKQTYN        DQTYR
169500170425     C                   SUB       XKQTYN        DQTYF
169600170425     C                   UPDATE    HSFINVM
169700170425     C                   ENDIF
169800170425     C                   ENDSR
169900170425      *
170000170425      *----------------------------------------------------------------
170100170425      * Update inventory sales.
170200170425      *----------------------------------------------------------------
170300170425BL   C     UPINVS        BEGSR
170400170425BL    *
170500170425BL    * Update stock quantities.
170600170425BL   C     IVMKEY        CHAIN     HSLINVMA                           99
170700170425BL   C     *IN99         IFEQ      *OFF
170800170425BL    *
170900170425BL    * Reduce allocated quantity and reduce on-hand quantity.
171000170425BL   C                   SUB       XKQTYN        DQTYR
171100170425BL   C                   SUB       XKQTYN        DQTYO
171200170425BL   C                   UPDATE    HSFINVM
171300170425BL   C                   ENDIF
171400170425BL   C                   ENDSR
171500170425      *
171600170425      *----------------------------------------------------------------
171700170425      * Print delivery note.
171800170425      *----------------------------------------------------------------
171900170425     C     PRTDEL        BEGSR
172000170425BL   C                   MOVEL     XJSORD        ORDPRM
172100170425BL   C                   CALL      'HSR230'
172200170425BL   C                   PARM                    ORDPRM
172300170425     C                   ENDSR
172400170425      *
172500170425      *----------------------------------------------------------------
172600170425      * Print invoice.
172700170425      *----------------------------------------------------------------
172800170425     C     PRTINV        BEGSR
172900170425BL   C                   MOVEL     XJSORD        ORDPRM
173000170425BL   C                   CALL      'HSR220'
173100170425BL   C                   PARM                    ORDPRM
173200170425     C                   ENDSR
173300170425      *
173400170425      *----------------------------------------------------------------
173500170425      * Create order details.
173600170425      *----------------------------------------------------------------
173700170425     C     UPORDD        BEGSR
173800170425      *
173900170425      * Order line already exists
174000170425     C                   MOVEL     ' '           UPDAT
174100170425     C     XOLIN         IFGT      0
174200170425     C     KEYOLN        CHAIN     HSLORDDB                           98
174300170425     C                   Z-ADD     XOLIN         KLINE
174400170425     C                   ENDIF
174500170425      *
174600170425      * Write fields for order detail record.
174700170425     C                   MOVEL     XSELC         KLTYP
174800170425     C                   MOVEL     XJCOMP        KCOMP
174900170425     C                   MOVEL     XJTYPE        KTYPE
175000170425     C                   Z-ADD     XJSORD        KSORD
175100170425     C                   Z-ADD     RRNX          KLINE
175200170425     C                   MOVEL     XJCUST        KCUST
175300170425     C                   MOVEL     XKPROD        KPROD
175400170425     C                   MOVEL     XKSERC        KSERC
175500170425     C                   Z-ADD     XKSERF        KSERNF
175600170425     C                   Z-ADD     0             KELEMF
175700170425     C                   Z-ADD     XKSERT        KSERNT
175800170425     C                   Z-ADD     0             KELEMT
175900170425     C                   Z-ADD     XKQTYN        KQTYN
176000170425     C                   Z-ADD     NCOST         KCOST
176100170425     C                   Z-ADD     XKPRIC        KPRIC
176200170425     C                   Z-ADD     XKVALU        KVALU
176300170425      *
176400170425BL    * Obtain VAT% from Order Type record.
176500170425BL   C*          #KVALU    MULT .175      KVATA
176600170425BL   C*          #KVALU    MULT MVATP     KVATA
176700170425BL   C*          KVATA     DIV  100       KVATA     H
176800170425     C                   Z-ADD     CYMD          KCRTD
176900170425     C                   Z-ADD     XXTME         KCRTT
177000170425     C                   MOVEL     XNDESC        KDESC
177100170425     C                   MOVEL     XJOBNO        KCRTS
177200170425     C                   MOVEL     XUSRID        KCRTU
177300170425     C                   MOVEL     XPGMID        KCRTP
177400170425     C                   MOVEL     *BLANK        KDELT
177500170425      *
177600170425      * Update order detail record.
177700170425     C     XOLIN         IFGT      0
177800170425     C     *IN98         IFEQ      *OFF
177900170425     C                   MOVEL     'Y'           UPDAT
178000170425     C                   UPDATE    HSFORDD
178100170425     C                   ENDIF
178200170425     C                   ELSE
178300170425      *
178400170425      * Write order detail record.
178500170425     C                   WRITE     HSFORDD
178600170425     C                   ENDIF
178700170425     C                   ENDSR
178800170425      *
178900170425      *----------------------------------------------------------------
179000170425      * Create order header.
179100170425      *----------------------------------------------------------------
179200170425     C     UPORDH        BEGSR
179300170425      *
179400170425      * Program mode - Maintenance, or Dispatch
179500170425     C     YMODE         IFEQ      'M'
179600170425     C     YMODE         OREQ      'D'
179700170425      *
179800170425      * Access order header record.
179900170425     C     XJSORD        CHAIN     HSLORDHA                           99
180000170425     C                   ENDIF
180100170425      *
180200170425      * Write fields for order header record.
180300170425     C                   MOVEL     XJCOMP        JCOMP
180400170425     C                   MOVEL     XJCUST        JCUST
180500170425     C                   MOVEL     *BLANKS       JCUSB
180600170425     C                   MOVEL     XJORDR        JORDR
180700170425     C                   MOVEL     XJTYPE        JTYPE
180800170425     C                   Z-ADD     XJSORD        JSORD
180900170425     C                   Z-ADD     WKORDD        JORDD
181000170425     C                   MOVEL     *BLANKS       JINVN
181100170425     C                   Z-ADD     0             JINVD
181200170425     C                   MOVEL     *BLANKS       JDELN
181300170425     C                   Z-ADD     0             JDELD
181400170425     C                   Z-ADD     CYMD          JCRTD
181500170425     C                   Z-ADD     XXTME         JCRTT
181600170425     C                   MOVEL     XJOBNO        JCRTS
181700170425     C                   MOVEL     XUSRID        JCRTU
181800170425     C                   MOVEL     XPGMID        JCRTP
181900170425     C                   MOVEL     *BLANK        JDELT
182000170425      *
182100170425      * Program mode - Entry
182200170425     C     YMODE         IFEQ      'E'
182300170425      *
182400170425      * Write order header record.
182500170425BL   C                   MOVEL     'A'           JSTAT
182600170425     C                   WRITE     HSFORDH
182700170425     C                   ENDIF
182800170425      *
182900170425      * Program mode - Maintenance, or Dispatch
183000170425     C     YMODE         IFEQ      'M'
183100170425     C     YMODE         OREQ      'D'
183200170425BL   C     YMODE         IFEQ      'D'
183300170425BL   C                   Z-ADD     *DATE         JDELD
183400170425BL   C                   MOVEL     'D'           JSTAT
183500170425BL   C                   ENDIF
183600170425      *
183700170425      * Update order header record.
183800170425     C     *IN99         IFEQ      *OFF
183900170425     C                   UPDATE    HSFORDH
184000170425     C                   ENDIF
184100170425     C                   ENDIF
184200170425     C                   ENDSR
184300170425      *
184400170425      *----------------------------------------------------------------
184500170425      * Create order delivery details.
184600170425     C     UPODEL        BEGSR
184700170425      *
184800170425      * Program mode - Maintenance, or Dispatch
184900170425     C     YMODE         IFEQ      'M'
185000170425     C     YMODE         OREQ      'D'
185100170425      *
185200170425     C     XJSORD        CHAIN     HSFODEL                            99
185300170425     C                   ENDIF
185400170425      *
185500170425      * Write fields for order delivery detail record.
185600170425     C                   MOVEL     XJCOMP        VCOMP
185700170425     C                   MOVEL     XJTYPE        VTYPE
185800170425     C                   Z-ADD     XJSORD        VSORD
185900170425     C                   MOVEL     XVNAM1        VNAM1
186000170425     C                   MOVEL     XVADR1        VADR1
186100170425     C                   MOVEL     XVADR2        VADR2
186200170425     C                   MOVEL     XVADR3        VADR3
186300170425     C                   MOVEL     XVPCDE        VPCDE
186400170425     C                   MOVEL     XVDIN1        VDIN1
186500170425     C                   MOVEL     XVDIN2        VDIN2
186600170425     C                   MOVEL     XVDIN3        VDIN3
186700170425     C                   MOVEL     *BLANKS       VDELT
186800170425      *
186900170425      * Program mode - Entry
187000170425     C     YMODE         IFEQ      'E'
187100170425      *
187200170425      * Write order delivery details record.
187300170425     C                   WRITE     HSFODEL
187400170425     C                   ENDIF
187500170425      *
187600170425      * Program mode - Maintenance, or Dispatch
187700170425     C     YMODE         IFEQ      'M'
187800170425     C     YMODE         OREQ      'D'
187900170425      *
188000170425      * Update order delivery details record.
188100170425     C     *IN99         IFEQ      *OFF
188200170425     C                   UPDATE    HSFODEL
188300170425     C                   ENDIF
188400170425     C                   ENDIF
188500170425      *
188600170425     C                   ENDSR
188700170425      *----------------------------------------------------------------
188800170425      * Create inventory sales transaction.
188900170425      *----------------------------------------------------------------
189000170425     C     UPINVT        BEGSR
189100170425      *
189200170425      * Write fields for inventory sales transaction record.
189300170425     C                   MOVEL     XJCOMP        CCOMP
189400170425     C                   MOVEL     XJWHSE        CWHSE
189500170425     C                   MOVEL     XKPROD        CPROD
189600170425     C                   MOVEL     *BLANKS       CSUBCF
189700170425     C                   MOVEL     *BLANKS       CSUBCT
189800170425     C                   MOVEL     *BLANKS       CVTYP
189900170425     C                   MOVEL     XKSERC        CSERC
190000170425     C                   Z-ADD     XKSERF        CSERNF
190100170425     C                   Z-ADD     0             CELEMF
190200170425     C                   Z-ADD     XKSERT        CSERNT
190300170425     C                   Z-ADD     0             CELEMT
190400170425     C                   Z-ADD     XKQTYN        CQTYN
190500170425     C                   Z-ADD     0             CBATC
190600170425BL   C                   MOVEL(P)  XJSORD        CDELN
190700170425     C                   MOVEL     *BLANKS       CREAS
190800170425     C                   Z-ADD     CYMD          CTDAT
190900170425BL   C                   MOVEL     MTTYP         CTYPE
191000170425     C                   MOVEL     *BLANKS       CSUPP
191100170425     C                   MOVEL     XJCUST        CCUST
191200170425     C                   MOVEL     *BLANKS       CAREA
191300170425     C                   MOVEL     *BLANKS       CAISL
191400170425     C                   MOVEL     *BLANKS       CBAYR
191500170425     C                   MOVEL     *BLANKS       CLEVL
191600170425     C                   MOVEL     *BLANKS       CINVN
191700170425     C                   Z-ADD     CYMD          CCRTD
191800170425     C                   Z-ADD     XXTME         CCRTT
191900170425     C                   MOVEL     XJOBNO        CCRTS
192000170425     C                   MOVEL     XUSRID        CCRTU
192100170425     C                   MOVEL     XPGMID        CCRTP
192200170425     C                   MOVEL     *BLANK        CDELT
192300170425      *
192400170425      * Write inventory sales transaction record.
192500170425     C                   WRITE     HSFINVT
192600170425     C                   ENDSR
192700170425      *
192800170425      *----------------------------------------------------------------
192900170425      * VALIDH - Validate header screen.
193000170425      *----------------------------------------------------------------
193100170425      *
193200170425     C     VALIDH        BEGSR
193300170425      *
193400170425      * Screen Header validation:
193500170425      *
193600170425      * Reset work values.
193700170425     C                   RESET                   XERROR
193800170425     C                   MOVE      *OFF          *IN61                          Hide F10/F11
193900170425      *
194000170425      * Reset error indicators.
194100170425     C                   MOVEA     XZEROS        *IN(30)
194200170425      *
194300170425      * Validate that Order Type is a valid Type.
194400170425     C     XJTYPE        CHAIN     HSLORDPA                           99
194500170425     C     *IN99         IFEQ      *ON
194600170425     C                   MOVE      *ON           *IN30
194700170425     C                   MOVE      XYES          XERROR
194800170425     C                   MOVEL     'HSV2001'     P0MSID
194900170425     C                   EXSR      YSNDMG
195000170425     C                   ENDIF
195100170425      *
195200170425      * Validate that Company is valid.
195300170425     C     XJCOMP        IFNE      *BLANKS
195400170425     C     XJCOMP        CHAIN     HSLCOMPA                           99
195500170425     C     *IN99         IFEQ      *ON
195600170425     C                   MOVE      *ON           *IN31
195700170425     C                   MOVE      XYES          XERROR
195800170425     C                   MOVEL     'HSV2002'     P0MSID
195900170425     C                   EXSR      YSNDMG
196000170425     C                   ENDIF
196100170425     C                   ENDIF
196200170425      *
196300170425      * Validate that Warehouse is valid.
196400170425     C     XJWHSE        IFNE      *BLANKS
196500170425     C     XJWHSE        CHAIN     HSLWHSEA                           99
196600170425     C     *IN99         IFEQ      *ON
196700170425     C                   MOVE      *ON           *IN32
196800170425     C                   MOVE      XYES          XERROR
196900170425     C                   MOVEL     'HSV0006'     P0MSID
197000170425     C                   EXSR      YSNDMG
197100170425     C                   ENDIF
197200170425     C                   ENDIF
197300170425      *
197400170425      * Validate Post Code
197500170425XXX  C     XJCUST        IFEQ      *BLANKS
197600170425     C     XJPCDE        IFNE      *BLANKS
197700170425     C     XJPCDE        CHAIN     HSLCUSTB                           99
197800170425     C     *IN99         IFEQ      *ON
197900170425     C                   MOVE      *ON           *IN33
198000170425     C                   MOVE      XYES          XERROR
198100170425     C                   MOVEL     'HSV2003'     P0MSID
198200170425     C                   EXSR      YSNDMG
198300170425     C                   ENDIF
198400170425      *
198500170425      * If Customer is found
198600170425     C     *IN99         IFEQ      *OFF
198700170425      * ...load Customer record into screen fields.
198800170425XXXM C                   MOVEL     ENAM1         XJNAM1                         Name 1
198900170425XXXM C                   MOVEL     ENAM2         XJNAM2                         Name 2
199000170425XXXM C                   MOVEL     EADR1         XJADR1                         Address 1
199100170425XXXM C                   MOVEL     EADR2         XJADR2                         Address 2
199200170425XXXM C                   MOVE      ECUST         XJCUST                         Cust No.
199300170425XXX  C                   MOVE      ECLIM         XJCLIM           15 0          Credit Limit
199400170425XXX  C                   MOVE      ETYSL         XJTYSL           20 5          Last Year Sales
199500170425XXX  C                   ENDIF
199600170425      *
199700170425     C                   ENDIF
199800170425     C                   ENDIF
199900170425      *
200000170425      * Validate Customer Number
200100170425XXXD C*          #JCUST    IFNE *BLANKS
200200170425     C     XJCUST        CHAIN     HSLCUSTA                           99
200300170425     C     *IN99         IFEQ      *ON
200400170425     C                   MOVE      *ON           *IN34
200500170425     C                   MOVE      XYES          XERROR
200600170425     C                   MOVEL     'HSV2004'     P0MSID
200700170425     C                   EXSR      YSNDMG
200800170425     C                   ENDIF
200900170425      *
201000170425      * If Customer is found
201100170425     C     *IN99         IFEQ      *OFF
201200170425      * ...load Customer record into screen fields.
201300170425XXXM C                   MOVEL     ENAM1         XJNAM1                         Name 1
201400170425XXXM C                   MOVEL     ENAM2         XJNAM2                         Name 2
201500170425XXXM C                   MOVEL     EADR1         XJADR1                         Address 1
201600170425XXXM C                   MOVEL     EADR2         XJADR2                         Address 2
201700170425XXXM C                   MOVE      EPCDE         XJPCDE                         Post Code
201800170425XXX  C                   MOVE      ECLIM         XJCLIM           15 0          Credit Limit
201900170425XXX  C                   MOVE      ETYSL         XJTYSL           20 5          Last Year Sales
202000170425XXX   *
202100170425XXX   * Check customer's credit rating allows order entry......
202200170425XXX  C     ECRAT         IFEQ      '01 '
202300170425XXX  C                   MOVE      *ON           *IN34
202400170425XXX  C                   MOVE      XYES          XERROR
202500170425XXX  C                   MOVEL     'HSV2018'     P0MSID
202600170425XXX  C                   EXSR      YSNDMG
202700170425XXX  C                   ENDIF
202800170425      *
202900170425     C                   ENDIF
203000170425XXXD C*                    ENDIF
203100170425      *
203200170425      * Maximum discount is 40%
203300170425     C     XJDISP        IFGT      40
203400170425     C                   MOVE      *ON           *IN36
203500170425     C                   MOVE      XYES          XERROR
203600170425     C                   MOVEL     'HSV0142'     P0MSID
203700170425     C                   EXSR      YSNDMG
203800170425     C                   ENDIF
203900170425      *
204000170425      * Check order date
204100170425     C     XJORDD        IFEQ      0
204200170425     C                   EXSR      YDATEC
204300170425     C                   ELSE
204400170425      *
204500170425      * a) Check for leap year and adjust number of days in February
204600170425      *    in Days in Month array.
204700170425     C     JYY           DIV       4             REM               4 0
204800170425     C     REM           IFEQ      0
204900170425     C                   MOVEL     'Y'           LEAP              1
205000170425     C                   ELSE
205100170425     C                   MOVEL     ' '           LEAP
205200170425     C                   ENDIF
205300170425     C                   SELECT
205400170425     C     LEAP          WHENEQ    ' '
205500170425     C                   MOVEA     28            DIM(2)
205600170425     C     LEAP          WHENEQ    'Y'
205700170425     C                   MOVEA     29            DIM(2)
205800170425     C                   ENDSL
205900170425      * Day
206000170425     C     JDD           IFGT      31
206100170425     C     JDD           ORLT      01
206200170425      * Month
206300170425     C     JMM           ORGT      12
206400170425     C     JMM           ORLT      01
206500170425      *
206600170425      * If date error found...
206700170425     C                   MOVE      *ON           *IN35
206800170425     C                   MOVE      XYES          XERROR
206900170425     C                   MOVEL     'HSV2005'     P0MSID
207000170425     C                   EXSR      YSNDMG
207100170425     C                   ENDIF
207200170425      *
207300170425      * Validate Day within month.
207400170425     C                   Z-ADD     JMM           M                 2 0
207500170425     C     JDD           IFLT      1
207600170425     C     JMM           ORGE      1
207700170425     C     JMM           ANDLE     12
207800170425     C     JDD           ANDGT     DIM(M)
207900170425      *
208000170425      * If date error found...
208100170425     C                   MOVE      *ON           *IN35
208200170425     C                   MOVE      XYES          XERROR
208300170425     C                   MOVEL     'HSV2005'     P0MSID
208400170425     C                   EXSR      YSNDMG
208500170425     C                   ENDIF
208600170425     C                   ENDIF
208700170425      *
208800170425      * If no errors found...
208900170425     C     XERROR        IFEQ      XNO
209000170425      * ...display "Data valid.Press F10 to update" message...
209100170425     C                   MOVEL     'HSV9006'     P0MSID
209200170425     C                   EXSR      YSNDMG
209300170425      * ...activate F10 key (*IN61=*ON).
209400170425     C                   MOVE      *ON           *IN61
209500170425     C                   ENDIF
209600170425      *
209700170425     C                   ENDSR
209800170425      *
209900170425      *----------------------------------------------------------------
210000170425      * @DATEC - Date Check Routine
210100170425      *----------------------------------------------------------------
210200170425      *
210300170425     C     YDATEC        BEGSR
210400170425      *
210500170425      * Convert six-digit system date to eight digits, with century.
210600170425     C                   MOVEL     UDAY          DD
210700170425     C                   MOVEL     UMONTH        MM
210800170425     C                   MOVEL     UYEAR         YY
210900170425     C     YY            IFGT      80
211000170425     C                   Z-ADD     19            CC
211100170425     C                   ELSE
211200170425     C                   Z-ADD     20            CC
211300170425     C                   ENDIF
211400170425     C                   MOVEL     CC            CCYY              4 0
211500170425     C                   MOVE      YY            CCYY
211600170425      *
211700170425      * Set default date for order entry.
211800170425     C     XJORDD        IFEQ      0
211900170425     C                   Z-ADD     DMCY          XJORDD
212000170425     C                   ENDIF
212100170425      *
212200170425      * Set date for transaction audit field.
212300170425     C                   Z-ADD     DD            DDD
212400170425     C                   Z-ADD     MM            MMM
212500170425     C                   Z-ADD     CC            CCC
212600170425     C                   Z-ADD     YY            YYY
212700170425     C                   ENDSR
212800170425      *
212900170425      *----------------------------------------------------------------
213000170425      * @SERCH - F4 prompt control.
213100170425      *----------------------------------------------------------------
213200170425      *
213300170425     C     YSERCH        BEGSR
213400170425      *
213500170425      * Check that cursor is in a valid field for prompting.
213600170425     C     CSRRCD        IFEQ      'HSS200A'
213700170425     C     CSRFLD        ANDEQ     'XJCUST'
213800170425     C     CSRRCD        OREQ      'HSS200A'
213900170425     C     CSRFLD        ANDEQ     'XJTYPE'
214000170425     C     CSRRCD        OREQ      'HSS200A'
214100170425     C     CSRFLD        ANDEQ     'XJCOMP'
214200170425     C     CSRRCD        OREQ      'HSS200A'
214300170425     C     CSRFLD        ANDEQ     'XJWHSE'
214400170425     C     CSRRCD        OREQ      'HSS200A'
214500170425     C     CSRFLD        ANDEQ     'XJPCDE'
214600170425     C     CSRRCD        OREQ      'HSS200C'
214700170425     C     CSRFLD        ANDEQ     'XKPROD'
214800170425      *
214900170425      * Move appropriate data to parameter fields depending upon search
215000170425      * field chosen.
215100170425     C                   SELECT
215200170425      *
215300170425      * Customer No.
215400170425     C     CSRFLD        WHENEQ    'XJCUST'
215500170425     C                   MOVEL(P)  'HSLCUSTA'    FILEY
215600170425     C                   MOVEL(P)  'ENAM1'       NAMEY
215700170425     C                   MOVEL(P)  'ECUST'       NUMBRY
215800170425      *
215900170425      * Post Code
216000170425     C     CSRFLD        WHENEQ    'XJPCDE'
216100170425     C                   MOVEL(P)  'HSLCUSTB'    FILEY
216200170425     C                   MOVEL(P)  'ENAM1'       NAMEY
216300170425     C                   MOVEL(P)  'EPCDE'       NUMBRY
216400170425      *
216500170425      * Order Type.
216600170425     C     CSRFLD        WHENEQ    'XJTYPE'
216700170425     C                   MOVEL(P)  'HSLORDPA'    FILEY
216800170425     C                   MOVEL(P)  'MODES'       NAMEY
216900170425     C                   MOVEL(P)  'MOTYP'       NUMBRY
217000170425      *
217100170425      * Company Code
217200170425     C     CSRFLD        WHENEQ    'XJCOMP'
217300170425     C                   MOVEL(P)  'HSLCOMPA'    FILEY
217400170425     C                   MOVEL(P)  'WODES'       NAMEY
217500170425     C                   MOVEL(P)  'WCOMP'       NUMBRY
217600170425      *
217700170425      * Warehouse Code
217800170425     C     CSRFLD        WHENEQ    'XJWHSE'
217900170425     C                   MOVEL(P)  'HSLWHSEA'    FILEY
218000170425     C                   MOVEL(P)  'PODES'       NAMEY
218100170425     C                   MOVEL(P)  'PWHSE'       NUMBRY
218200170425      *
218300170425      * Product Code
218400170425     C     CSRFLD        WHENEQ    'XKPROD'
218500170425     C                   MOVEL(P)  'HSLPRODA'    FILEY
218600170425     C                   MOVEL(P)  'NDESC'       NAMEY
218700170425     C                   MOVEL(P)  'NPROD'       NUMBRY
218800170425      *
218900170425     C                   ENDSL
219000170425      *
219100170425      * Call system window program to retrieve data.  If Return Code is
219200170425      * *OFF then load retrieved data into screen fields.
219300170425     C                   Z-ADD     10            LINY
219400170425     C                   Z-ADD     8             COLY
219500170425     C                   CALL      'HSR341'      PL341
219600170425      *
219700170425      * If Return Code is *OFF then load retrieved data into
219800170425      * appropriate screen fields.
219900170425     C     YRTNC         IFEQ      *OFF                                         ..If2
220000170425      *
220100170425     C                   SELECT
220200170425      *
220300170425      * Customer No.
220400170425     C     CSRFLD        WHENEQ    'XJCUST'
220500170425     C                   MOVEL(P)  YNUMBR        XJCUST
220600170425      *
220700170425      * Post Code
220800170425     C     CSRFLD        WHENEQ    'XJPCDE'
220900170425     C                   MOVEL(P)  YNUMBR        XJPCDE
221000170425      *
221100170425      * Customer Type.
221200170425     C     CSRFLD        WHENEQ    'XJTYPE'
221300170425     C                   MOVEL(P)  YNUMBR        XJTYPE
221400170425      *
221500170425      * Company Code
221600170425     C     CSRFLD        WHENEQ    'XJCOMP'
221700170425     C                   MOVEL(P)  YNUMBR        XJCOMP
221800170425      *
221900170425      * Warehouse Code
222000170425     C     CSRFLD        WHENEQ    'XJWHSE'
222100170425     C                   MOVEL(P)  YNUMBR        XJWHSE
222200170425      *
222300170425      * Product Code
222400170425     C     CSRFLD        WHENEQ    'XKPROD'
222500170425     C                   MOVEL(P)  YNUMBR        XKPROD
222600170425      *
222700170425     C                   ENDSL
222800170425     C                   ENDIF                                                  ..EndIf2
222900170425      *
223000170425      * otherwise cursor is in wrong format/field so display message.
223100170425     C                   ELSE                                                   .ElseIf1
223200170425     C                   MOVEL     'HSV9009'     P0MSID
223300170425     C                   EXSR      YSNDMG
223400170425     C                   ENDIF                                                  .EndIf1
223500170425      *
223600170425     C                   ENDSR
223700170425      *
223800170425      *----------------------------------------------------------------
223900170425      * @SERSF - F4 prompt control for order detail subfile.
224000170425      *----------------------------------------------------------------
224100170425      *
224200170425     C     YSERSF        BEGSR
224300170425      * Clear row / column control.
224400170425     C                   Z-ADD     0             CSRROW
224500170425     C                   Z-ADD     0             CSRCOL
224600170425      *
224700170425      * Retrieve the current cursor position.
224800170425     C     CSRLOC        DIV       256           ROW               2 0
224900170425     C                   MVR                     COL               2 0
225000170425     C                   Z-ADD     ROW           CSRROW
225100170425     C                   Z-ADD     COL           CSRCOL
225200170425      *
225300170425      * Execute search.
225400170425     C                   EXSR      YSERCH
225500170425      *
225600170425      * Flag subfile record to return value.
225700170425     C     CSRRRN        CHAIN     HSS200C                            99
225800170425     C     *IN99         IFEQ      *OFF
225900170425     C                   MOVEL     *ON           *IN37
226000170425XXX  C     YNUMBR        IFNE      *BLANKS
226100170425     C                   MOVEL(P)  YNUMBR        XKPROD
226200170425XXX  C                   ENDIF
226300170425     C                   UPDATE    HSS200C
226400170425     C                   MOVEL     *OFF          *IN37
226500170425     C                   ENDIF
226600170425     C                   ENDSR
226700170425      *
226800170425      *----------------------------------------------------------------
226900170425      * @SNDMG - Send message to this program's MSGQ.
227000170425      *----------------------------------------------------------------
227100170425      *
227200170425     C     YSNDMG        BEGSR
227300170425      *
227400170425     C                   CALL      'SNDMSGC'
227500170425     C                   PARM                    P0PGMQ                         Program queue
227600170425     C                   PARM                    P0PGRL                         Rel queue
227700170425     C                   PARM                    P0MSID                         Message ID
227800170425     C                   PARM                    P0MSGF                         Message file
227900170425     C                   PARM                    P0MSDA                         Message data
228000170425     C                   PARM                    P0MSTP                         Message type
228100170425      *
228200170425     C                   ENDSR
228300170425      *
228400170425      *----------------------------------------------------------------
228500170425      * @CLRMG - Clear message(s) from this program's MSGQ.
228600170425      *----------------------------------------------------------------
228700170425      *
228800170425     C     YCLRMG        BEGSR
228900170425      *
229000170425     C                   CALL      'RMVMSGC'
229100170425      *
229200170425     C                   ENDSR
229300170425      *
229400170425      *----------------------------------------------------------------
229500170425      * *UPPVCT- Update the voucher control
229600170425      *----------------------------------------------------------------
229700170425      *
229800170425     C     UPPVCT        BEGSR
229900170425     C                   Z-ADD     1             RRNQ
230000170425     C     RRNQ          CHAIN     HSS200C                            97
230100170425     C     *IN97         DOWEQ     *OFF
230200170425      *
230300170425     C                   ADD       1             RRNQ
230400170425     C     XSELC         IFNE      *BLANK
230500170425     C     XKPROD        ORNE      *BLANK
230600170425     C     XNDESC        ORNE      *BLANK
230700170425     C     XKPRIC        ORNE      *ZEROS
230800170425     C     XKQTYN        ORNE      *ZEROS
230900170425     C     XKVALU        ORNE      *ZEROS
231000170425     C     XKVATA        ORNE      *ZEROS
231100170425     C     XKSERC        ORNE      *BLANKS
231200170425     C     XKSERF        ORNE      *ZEROS
231300170425     C     XKSERT        ORNE      *ZEROS
231400170425     C                   MOVE      XKSERC        WKSERC
231500170425     C                   MOVE      XKSERT        TEMP              9 0
231600170425     C                   ADD       1             TEMP
231700170425     C     VCHKEY        SETLL     HSLVCTLA
231800170425     C     XKPROD        READE     HSLVCTLA                               92
231900170425     C                   MOVE      TEMP          BSERNN
232000170425     C                   UPDATE    HSFVCTL
232100170425     C                   ENDIF
232200170425      *
232300170425     C     RRNQ          IFEQ      100
232400170425     C                   LEAVE
232500170425     C                   ENDIF
232600170425     C     RRNQ          CHAIN     HSS200C                            97
232700170425     C                   ENDDO
232800170425     C                   ENDSR
232900170425      *
233000170425      *----------------------------------------------------------------
233100170425      * *INZSR - Initialization.
233200170425      *----------------------------------------------------------------
233300170425      *
233400170425     C     *INZSR        BEGSR
233500170425BL    *
233600170425BL    * Dummy read to open file.
233700170425BL   C                   READ      HSPINVT                                99
233800170425BL   C                   UPDATE    HSFINVT
233900170425     C                   OPEN      HSLEXPAA
234000170425BL   C                   READ      HSLEXPAA                               99
234100170425     C                   CLOSE     HSLEXPAA
234200170425      *
234300170425      * Key lists.
234400170425      * Key List for Voucher Control.
234500170425     C     VCHKEY        KLIST
234600170425     C                   KFLD                    XKPROD
234700170425     C                   KFLD                    WKSERC
234800170425      *
234900170425      * Key List for Voucher Cross-Reference.
235000170425     C     KEYXRF        KLIST
235100170425     C                   KFLD                    CCYY
235200170425     C                   KFLD                    XJCUST
235300170425     C                   KFLD                    XKPROD
235400170425      *
235500170425      * Key List for Sales Order.
235600170425     C     KEYOLN        KLIST
235700170425     C                   KFLD                    XJSORD
235800170425     C                   KFLD                    XOLIN
235900170425      *
236000170425      * Key List for Inventory Masterfile.
236100170425     C     IVMKEY        KLIST
236200170425     C                   KFLD                    XKPROD
236300170425     C                   KFLD                    WKSUBC
236400170425     C                   MOVE      *BLANKS       WKSUBC
236500170425      *
236600170425      * Key List for Voucher Tracking.
236700170425     C     TRCKEY        KLIST
236800170425     C                   KFLD                    XKPROD
236900170425     C                   KFLD                    XKSERC
237000170425     C                   KFLD                    XKSERF
237100170425      *
237200170425      * Key List for Customer Discount File.
237300170425     C     DSCKEY        KLIST
237400170425     C                   KFLD                    ECTYP
237500170425     C                   KFLD                    PFAMT
237600170425      *
237700170425      * Parameter Lists.
237800170425      * Entry parameter list.
237900170425     C     *ENTRY        PLIST
238000170425     C                   PARM                    YMODE             1            Mode
238100170425     C                   PARM                    YORDNO            8            Sales Order No.
238200170425     C                   PARM                    YTYPE             3            Order Type
238300170425     C                   PARM                    YCUST             8            Customer No.
238400170425      *
238500170425      * List for Call to HSR341 - Search program.
238600170425     C     PL341         PLIST
238700170425     C                   PARM                    YRTNC             1
238800170425     C                   PARM                    YNUMBR           15
238900170425     C                   PARM                    FILEY            10
239000170425     C                   PARM                    NAMEY             6
239100170425     C                   PARM                    NUMBRY            6
239200170425     C                   PARM                    LINY              3 0
239300170425     C                   PARM                    COLY              3 0
239400170425      *
239500170425      * Field definitions
239600170425     C     *LIKE         DEFINE    XKVALU        WKTOTV
239700170425     C     *LIKE         DEFINE    XKSERC        WKSERC
239800170425     C     *LIKE         DEFINE    BSERNN        WKSERN
239900170425     C     *LIKE         DEFINE    XKQTYN        WKQTYN
240000170425     C     *LIKE         DEFINE    DSUBC         WKSUBC
240100170425     C     *LIKE         DEFINE    XNO           WKRANG
240200170425     C     *LIKE         DEFINE    XNO           WKVCTL
240300170425     C     *LIKE         DEFINE    XNO           UPDAT
240400170425      *
240500170425      * Variable declarations.
240600170425     C                   MOVE      '0'           XNO               1
240700170425     C                   MOVE      '1'           XYES              1
240800170425     C                   MOVE      XNO           XERROR            1
240900170425     C                   MOVE      XNO           XUPDAT            1
241000170425     C                   MOVE      XNO           XDELET            1
241100170425BL   C                   MOVEL     *BLANKS       ORDPRM            8
241200170425     C                   Z-ADD     1             RCDNBR
241300170425     C                   Z-ADD     0             RRNX              5 0
241400170425     C                   Z-ADD     0             RRNVAL            5 0
241500170425     C                   Z-ADD     0             RRNLIN            5 0
241600170425     C                   Z-ADD     0             RRNQ              5 0
241700170425     C                   Z-ADD     0             RRNP              5 0
241800170425      *
241900170425      * Prepare message subfile.
242000170425     C                   MOVE      *ON           *IN79
242100170425     C                   MOVE      XPGMID        P0PGMQ           10            Program queu
242200170425     C                   MOVEL     '*PRV'        P0PGRL            5            Rel queue
242300170425     C                   MOVE      *BLANKS       P0MSID            7            Message ID
242400170425     C                   MOVEL     'HSM001'      P0MSGF           10            Message file
242500170425     C                   MOVE      *BLANKS       P0MSDA          132            Message data
242600170425     C                   MOVEL     '*INFO'       P0MSTP            7            Message type
242700170425      *
242800170425     C                   EXSR      YDATEC
242900170425      *
243000170425     C                   ENDSR
243100170425** Days in Month array DIM.
243200170425312831303130313130313031
