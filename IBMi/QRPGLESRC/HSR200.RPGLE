      *%CSTD===========================================================*
      ** Application. : RWB        Rays demo app                       *
      ** Component. . : HSR200                        Type: RPGLE      *
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
      ** MODIFS: 01 RBERNARDI  08/29/2017 18:07  00.00.08 MR 17/    7  *
      **           HSR200 Long Term Changes                            *
      *%ECSTD==========================================================*
      *%EXEC OVRDBF INTFILE EXTFILE
      * %ATTR TGTRLS(*CURRENT)
      */TITLE Sales Order Entry / Maintenance / Inquiry
      *
      * System        : HSV Control & Tracking
      * Author        : Bob Lee (Intec Systems)
      * Date          : January 1999
      * GOTO
      * GOTO
      * GOTO
      *================================================================
      * Indicator usage:
      *  20 - Order Valid for Despatch
      *  30 - 45 Input fields- DSPATR.
      *  62 - Control display/non-display of F10-Update.
      *  75 - 78 Program mode - Dispatch/Entry/Inquiry/Maintenance
      *  79 - MSGSFL (SFLCLR ETC...).
      *  99 - General CHAIN/SETLL result.
      *
      *================================================================
      * Maintenance   :
      * Fix/Chg Ref. Date       Description.
      * ------------ ---------- -----------------------------------
      *================================================================
      *
     H DATEDIT(*YMD)
     FHSLCUSTB  IF   E           K DISK
     F                                     RENAME(HSFCUST:HSFCUSTB)
      * Customer Master by Post Code.
      *
     FHSLCUSTA  IF   E           K DISK
      * Customer Master by Customer Account.
      *
     F*LTCUSTAIF  E           K        DISK
     F*           HSFCUST                           KRENAMEALTCUSTF
      * Customer Master by Customer Account.
      *
     FHSLORDPA  IF   E           K DISK
      * Sales Order Parameters.
      *
     FHSLTRACB  UF   E           K DISK
      * Voucher Tracking by Product/Series/Serial No./Element No.
      *
     FHSLEXPAA  UF A E           K DISK    USROPN
      * Unbanded Order line file by Product/Series/Serial No.
      *
     FHSLVCTLA  UF   E           K DISK
      * Voucher Control.
      *
     FHSLVXRFB  IF   E           K DISK
      * Agency Product Cross-Reference.
      *
     FHSLORDHA  UF A E           K DISK
      * Sales Order Header.
      *
     FHSLORDDB  UF A E           K DISK
      * Sales Order Detail.
      *
     FHSLODELA  UF A E           K DISK
      * Sales Order Delivery Detail.
      *
     FHSLSHPOA  IF   E           K DISK
      * Ship Only.
      *
     FHSLINVMA  UF   E           K DISK
      * Inventory Master.
      *
     FHSLWHSEA  IF   E           K DISK
      * Warehouse Master.
      *
     FHSLCOMPA  IF   E           K DISK
      * Company Master.
      *
     FHSLPRODA  IF   E           K DISK
      * Product Master.
      *
     FHSLDISCA  IF   E           K DISK
      * Customer Discount File
      *
BL   FHSPINVT   UF A E           K DISK
      * Inventory Transactions.
      *
BL   FARTICLE   IF   E           K DISK
      * FOR ARTCILE XREF
      *
     FHSS200    CF   E             WORKSTN INFDS(INFDS)
     F                                     SFILE(HSS200C:RRNX)
      * Screen file.
      *================================================================
      * Arrays.
      *
      * Days in Month for date validation.
     D DIM             S              2  0 DIM(12) CTDATA PERRCD(12)
      *================================================================
      * Data Structures.
      *
      * Screen Information DS.
     D INFDS           DS
     D  KEY                  369    369
     D  CSRLOC               370    371B 0
      *
     D XXXSDS         SDS           429
     D  XPGMID           *PROC
     D  XJOBNO               244    253
     D  XUSRID               254    263
      *
      * General DDMMCCYY date format.
     D                 DS
     D  DD                     1      2  0 INZ
     D  MM                     3      4  0 INZ
     D  CC                     5      6  0 INZ
     D  YY                     7      8  0 INZ
     D  DMCY                   1      8  0
      *
      * General CCYYMMDD date format.
     D                 DS
     D  CCC                    1      2  0 INZ
     D  YYY                    3      4  0 INZ
     D  MMM                    5      6  0 INZ
     D  DDD                    7      8  0 INZ
     D  CYMD                   1      8  0
      *
      * Input order date format.
     D                 DS
     D  JDD                    1      2  0 INZ
     D  JMM                    3      4  0 INZ
     D  JCC                    5      6  0 INZ
     D  JYY                    7      8  0 INZ
     D  XJORDD                 1      8  0
      *
      * Output order date format.
     D                 DS
     D  WKC                    1      2  0 INZ
     D  WKY                    3      4  0 INZ
     D  WKM                    5      6  0 INZ
     D  WKD                    7      8  0 INZ
     D  WKORDD                 1      8  0
      *
      *----------------------------------------------------------------
      * Constants.
      *
      * Named hexidecimal constants for function keys.
     D F03             C                   CONST(X'33')
     D F04             C                   CONST(X'34')
     D F06             C                   CONST(X'36')
     D F07             C                   CONST(X'37')
     D F10             C                   CONST(X'3A')
     D F11             C                   CONST(X'3B')
     D F12             C                   CONST(X'3C')
      *
      * Zeros to "SETOF" error indicators.
     D XZEROS          C                   CONST('0000000000000000000')
      *
      *================================================================
      * M A I N L I N E
      *================================================================
      *
      * Dispatch mode
     C     YMODE         IFEQ      'D'
     C                   MOVEL     *ON           *IN75
     C                   MOVEL     *OFF          *IN79
     C                   ELSE
     C                   MOVEL     *OFF          *IN75
     C                   ENDIF
     C                   READ      ARTICLE                                99
      *
      * Entry mode
     C     YMODE         IFEQ      'E'
     C                   MOVEL     *ON           *IN76
     C                   ELSE
     C                   MOVEL     *OFF          *IN76
     C                   ENDIF
      *                  CABEQ
      *                  CABLT
      *                  CABLE
      *                  CABGT
      *                  CABGE
      *                  CABNE
      *                  CASEQ
      *                  CASLT
      *                  CASLE
      *                  CASGT
      *                  CASGE
      *                  CASNE
      * Inquiry mode
     C     YMODE         IFEQ      'I'
     C                   MOVEL     *ON           *IN77
     C                   ELSE
     C                   MOVEL     *OFF          *IN77
     C                   ENDIF
      *
      * Maintenance mode       changesfordemo
     C     YMODE         IFEQ      'M'
     C                   MOVEL     *ON           *IN78
     C                   ELSE
     C                   MOVEL     *OFF          *IN78
     C                   ENDIF
      *
      * Program mode
     C     START         TAG
     C     YMODE         IFEQ      'I'
     C     YMODE         OREQ      'D'
     C     YMODE         OREQ      'M'
     C     YORDNO        IFNE      *BLANKS
     C                   MOVEL     YORDNO        XJSORD
     C                   MOVEL     YORDNO        WKORDN            8 0
     C     WKORDN        CHAIN     HSLORDHA                           99
     C                   ENDIF
     C                   ENDIF
      *
     C     YMODE         IFEQ      'D'
     C                   MOVE      JTYPE         XJTYPE
     C                   MOVE      JCUST         XJCUST
     C                   Z-ADD     JORDD         WKORDD
     C                   Z-ADD     WKC           JCC
     C                   Z-ADD     WKY           JYY
     C                   Z-ADD     WKM           JMM
     C                   Z-ADD     WKD           JDD
     C                   MOVE      JORDR         XJORDR
     C                   MOVE      JSORD         XJSORD
     C     JSTAT         IFEQ      'A'
     C     JSTAT         OREQ      ' '
     C                   MOVE      *ON           *IN20
     C                   ELSE
     C                   MOVE      *OFF          *IN20
     C                   MOVEL     'HSV2015'     P0MSID
     C                   EXSR      YSNDMG
     C                   ENDIF
     C     JCUST         CHAIN     HSLCUSTA                           13
     C                   MOVE      EPCDE         XJPCDE
     C                   MOVE      ENAM1         XENAM1
     C     JSORD         SETLL     HSLORDDB
     C     JSORD         READE     HSLORDDB                               99
     C     *IN99         DOWEQ     *OFF
     C                   ADD       KQTYN         XVQTY
     C     JSORD         READE     HSLORDDB                               99
     C                   ENDDO
     C                   Z-ADD     KDISP         XJDISP
     C                   ELSE
     C                   EXSR      YCLRSC
     C                   ENDIF
      *
      * Dispatch mode.
XXX  C     YMODE         IFEQ      'D'
XXX  C     JSORD         CHAIN     HSLODELA                           99
XXX  C     VNAM1         IFEQ      *BLANKS
XXX  C                   MOVEL(P)  ENAM1         XXNAM1
XXX  C                   MOVEL(P)  ENAM2         XXNAM2
XXX  C                   MOVEL(P)  EADR1         XXADR1
XXX  C                   MOVEL(P)  EADR2         XXADR2
XXX  C                   ELSE
XXX  C                   MOVEL(P)  VNAM1         XXNAM1
XXX  C                   MOVE      *BLANKS       XXNAM2
XXX  C                   MOVEL(P)  VADR1         XXADR1
XXX  C                   MOVEL(P)  VADR2         XXADR2
XXX  C                   ENDIF
XXX  C                   ENDIF
      *
      *
      * Dispatch, or Inquiry, or Maintenance mode.
XXX  C     YMODE         IFEQ      'I'
XXX  C     YMODE         OREQ      'D'
XXX  C     YMODE         OREQ      'M'
XXX  C                   MOVEL     YCUST         XJCUST
XXX  C                   MOVEL     YTYPE         XJTYPE
XXX  C                   ENDIF
     C     HDR           TAG
XXX  C                   MOVE      *OFF          *IN47
      * Display screen to receive Customer No. until F03/F10
     C     KEY           DOUEQ     F03
     C     KEY           OREQ      F10
     C     XERROR        ANDEQ     XNO
      *
      * Exit if F03 pressed.
     C     KEY           IFEQ      F03
     C                   MOVE      *ON           *INLR
     C                   LEAVE
     C                   ENDIF
      *
      * Display messages.
     C                   WRITE     MSGCTL
      *
     C                   TIME                    XXTME
     C                   EXFMT     HSS200A
      *
ZZZ  C     XJTYPE        CHAIN     HSLORDPA                           99
ZZZ  C     MSALE         IFEQ      'C'
ZZZ  C                   MOVE      *ON           *IN30
ZZZ  C                   MOVE      XYES          XERROR
ZZZ  C                   MOVEL     'HSV2027'     P0MSID
ZZZ  C                   EXSR      YSNDMG
ZZZ  C                   ITER
ZZZ  C                   ENDIF
      *
XXX  C                   CLEAR                   XVQTY
XXX  C     *IN20         IFEQ      *OFF
XXX  C     YMODE         ANDEQ     'D'
XXX  C                   ITER
XXX  C                   ENDIF
      *
BL   C                   Z-ADD     1             RCDNBR
      *
      * Clear messages.
     C                   EXSR      YCLRMG
      *
      * Process the various function keys available on the screen.
      *
      * Process Despatch if F07 pressed.
     C     KEY           IFEQ      F07
      *
      * Validate that Order Type is a valid Type.
     C     XJTYPE        CHAIN     HSLORDPA                           99
     C     *IN99         IFEQ      *ON
     C                   MOVE      *ON           *IN30
     C                   MOVE      XYES          XERROR
     C                   MOVEL     'HSV2001'     P0MSID
     C                   EXSR      YSNDMG
     C                   GOTO      START
     C                   ENDIF
     C                   ENDIF
      *
     C     YMODE         IFEQ      'D'
     C     WKORDN        ANDNE     XJSORD
     C                   MOVEL     XJSORD        WKORDN            8 0
     C     XJSORD        CHAIN     HSLORDHA                           99
     C     *IN99         IFEQ      *ON
     C                   MOVE      *OFF          *IN20
     C                   MOVEL     'HSV2017'     P0MSID
     C                   EXSR      YSNDMG
     C                   ELSE
     C                   MOVE      JTYPE         XJTYPE
     C                   MOVE      JCUST         XJCUST
     C                   Z-ADD     JORDD         WKORDD
     C                   Z-ADD     WKC           JCC
     C                   Z-ADD     WKY           JYY
     C                   Z-ADD     WKM           JMM
     C                   Z-ADD     WKD           JDD
     C                   MOVE      JORDR         XJORDR
     C                   MOVE      JSORD         XJSORD
     C     JSTAT         IFEQ      'A'
     C     JSTAT         OREQ      ' '
     C                   MOVE      *ON           *IN20
     C                   ELSE
     C                   MOVE      *OFF          *IN20
     C                   MOVEL     'HSV2015'     P0MSID
     C                   EXSR      YSNDMG
     C                   ENDIF
     C                   ENDIF
     C     JCUST         CHAIN     HSLCUSTA                           13
     C                   MOVE      EPCDE         XJPCDE
     C                   MOVE      ENAM1         XENAM1
     C     JSORD         SETLL     HSLORDDB
     C     JSORD         READE     HSLORDDB                               99
     C     *IN99         DOWEQ     *OFF
     C                   ADD       KQTYN         XVQTY
     C     JSORD         READE     HSLORDDB                               99
     C                   ENDDO
     C                   Z-ADD     KDISP         XJDISP
     C                   GOTO      HDR
     C                   ENDIF
      *
      * Program in inquiry, dispatch or maintenance mode
     C     YMODE         IFEQ      'I'
     C     YMODE         OREQ      'M'
     C     YMODE         OREQ      'D'
      *
      * Initialise subfile
     C                   MOVEA     '1001'        *IN(70)
     C                   WRITE     HSS200B
     C     XJSORD        IFNE      0
     C                   Z-ADD     0             RRNX
     C     XJSORD        SETLL     HSLORDDB
     C     *IN97         DOUEQ     *ON
     C     XJSORD        READE     HSLORDDB                               97
      *
      * Build subfile from existing order.
     C     *IN97         IFEQ      *OFF
     C                   ADD       1             RRNX
     C     RRNX          CHAIN     HSS200C                            99
     C                   Z-ADD     KLINE         XOLIN
     C                   MOVEL     KLTYP         XSELC
     C                   MOVEL     KPROD         XKPROD
     C                   MOVEL     KDESC         XNDESC
     C                   MOVEL     KSERC         XKSERC
     C                   Z-ADD     KSERNF        XKSERF
     C                   Z-ADD     KSERNT        XKSERT
     C                   Z-ADD     KQTYN         XKQTYN
     C                   Z-ADD     KPRIC         XKPRIC
     C                   Z-ADD     KVALU         XKVALU
XXX  C                   MOVE      XKQTYN        XXQTYN
BL    *
BL    * Ship Only - set line value to zero.
BL   C     SHONLY        IFEQ      'Y'
BL   C     XSELC         ANDEQ     'S'
BL   C                   Z-ADD     0             XKVALU
BL   C                   ENDIF
BL    *
BL   C*          #KVALU    MULT MVATP     #KVATA
      *
      * Extended value
     C     XSELC         IFEQ      'S'
     C     XSELC         OREQ      'N'
     C     XKPRIC        MULT      XKQTYN        XKVALU
BL    *
BL    * Ship Only - set line value to zero.
BL   C     SHONLY        IFEQ      'Y'
BL   C     XSELC         ANDEQ     'S'
BL   C                   Z-ADD     0             XKVALU
BL   C                   ENDIF
BL    *
BL   C*          #KVALU    MULT MVATP     #KVATA
      *
     C                   ENDIF
      *
      * Write subfile record.
     C     *IN99         IFEQ      *OFF
     C                   UPDATE    HSS200C
     C                   ELSE
     C                   WRITE     HSS200C
     C                   ENDIF
     C                   ENDIF
     C                   ENDDO
     C                   ENDIF
     C                   LEAVE
     C                   ENDIF
      *
      * Program mode - Entry
     C     YMODE         IFEQ      'E'
      *
      * Execute search if F04 pressed.
     C     KEY           IFEQ      F04
     C                   EXSR      YSERCH
XXX  C                   ITER
XXX  C                   EXSR      YCLRMG
     C                   ENDIF
      *
      * Validate header screen fields.
     C                   EXSR      VALIDH
      *
      * Validate ship only requirements.
     C                   EXSR      SHPONL
      *
     C                   ENDIF
      *
      * Process Despatch if F07 pressed.
RT   C     KEY           IFEQ      F07
      *
RT   C                   LEAVE
RT   C                   ENDIF
      *
      * End of DO loops for F03/F10 key checks.
     C                   ENDDO
     C                   MOVE      *OFF          *IN61
      *
      * Clear messages.
     C                   EXSR      YCLRMG
      *
      * Exit if F03 pressed.
     C     KEY           IFEQ      F03
      * Exit program.
     C                   MOVE      *ON           *INLR
     C                   RETURN
     C                   ENDIF
      *
      *-------------------------------------------------------
      *
      * Program mode - Entry
      * Retrieve order number.
     C     YMODE         IFEQ      'E'
     C     *DTAARA       DEFINE    HSAORDERNO    ORDERX            8 0
     C     *LOCK         IN        ORDERX
     C                   ADD       1             ORDERX
     C                   OUT       ORDERX
     C                   Z-ADD     ORDERX        XJSORD
     C                   ENDIF
      *
      * Display screen to receive Order Details until F10/F12
     C     DET           TAG
      *
      * Program in inquiry, or dispatch, or maintenance mode
     C     YMODE         IFEQ      'I'
     C     YMODE         OREQ      'M'
     C     YMODE         OREQ      'D'
     C     KEY           OREQ      F12
     C                   MOVEL     *OFF          *IN73
     C                   ELSE
     C                   MOVEL     *ON           *IN73
     C                   ENDIF
      *
     C     KEY           DOUEQ     F10
     C     XERROR        ANDEQ     XNO
     C     KEY           OREQ      F12
      *
      * Display messages.
     C                   WRITE     MSGCTL
      *
      * Read subfile to accumulate order value.
     C     RRNX          IFGT      0
     C                   Z-ADD     1             RRNVAL
     C                   Z-ADD     0             XKTVAL
     C     *IN98         DOUEQ     *ON
BL   C     RRNVAL        OREQ      100
BL   C     XSELC         OREQ      *BLANK
     C     RRNVAL        CHAIN     HSS200C                            98
     C     XSELC         IFNE      *BLANK
     C     XKPROD        ANDNE     *BLANK
     C     *IN98         ANDEQ     *OFF
     C     XSELC         ORNE      *BLANK
     C     XNDESC        ANDNE     *BLANK
     C     *IN98         ANDEQ     *OFF
     C                   ADD       XKVALU        XKTVAL
     C                   ENDIF
     C                   ADD       1             RRNVAL
     C                   ENDDO
     C                   ENDIF
      *
      * Dispatch mode.
XXX  C     YMODE         IFEQ      'D'
XXX  C     XJCUST        CHAIN     HSLCUSTA                           99
XXX   * ...load Customer record into screen 2 fields.
XXX  C                   MOVEL     ENAM1         XJNAM1                         Name 1
XXX  C                   MOVEL     ENAM2         XJNAM2                         Name 2
XXX  C                   MOVEL     EADR1         XJADR1                         Address 1
XXX  C                   MOVEL     EADR2         XJADR2                         Address 2
XXX  C                   ENDIF
      *
      *
      * Display footer.
RT   C     KEY           IFNE      F07
     C                   WRITE     HSS200E
RT   C                   ENDIF
      *
     C                   TIME                    XXTME
     C                   MOVEA     '011'         *IN(70)
      *
RT   C     KEY           IFNE      F07
     C                   EXFMT     HSS200B
XXX  C                   MOVE      XNO           XJUMP1
      *
     C     KEY           IFNE      F10
     C                   EXSR      YDELT
     C                   ENDIF
      *
RT   C                   ENDIF
      *
     C                   MOVEL     *OFF          *IN73
     C                   MOVEL     *OFF          *IN86
      *
OWE   * Clear messages (Only if an error has not been repeated)
      *
OWE  C     XERROR        IFEQ      XNO
      * Clear messages.
     C                   EXSR      YCLRMG
OWE  C                   ENDIF
      *
      * Process the various function keys available on the screen.
      *
      * Exit if F12 pressed.
     C     KEY           IFEQ      F12
     C                   GOTO      HDR
     C                   ENDIF
      *
      * Execute search if F04 pressed.
     C     KEY           IFEQ      F04
     C                   EXSR      YSERSF
     C                   ITER
     C                   ENDIF
      *
      * Check for agency cross-references.
BL   C     MXREF         IFEQ      'Y'
     C                   EXSR      AGXREF
BL   C                   ENDIF
      *
OWE   * Validate order detail screen fields (only re-validate data
OWE   * if it has been changed. Otherwise re-display error message).
OWE  C     XERROR        IFEQ      XYES
OWE  C     RRNS          CHAIN     HSS200C                            98
OWE  C     XSELC         IFNE      TSELC
OWE  C     XKPROD        ORNE      TPROD
OWE  C     XKPRIC        ORNE      TPRIC
OWE  C     XKQTYN        ORNE      TQTYN
OWE  C     XNDESC        ORNE      TDESC
OWE  C                   MOVE      *ON           *IN93
OWE  C                   ENDIF
OWE  C                   ENDIF
      *
OWE  C     *IN93         IFEQ      *ON
     C     XERROR        OREQ      XNO
      *
      * Validate order detail screen fields.
     C                   EXSR      VALIDD
OWE  C                   ENDIF
      *
      * Discount retrieval.
     C                   EXSR      DISCNT
      *
      * Stock allocation preview
      *                 - with banded allocation and manual allocation.
BL   C*          MSALE     IFEQ 'S'
     C*                    EXSR ALLOCS
BL   C*                    ENDIF
      *
      * Process Dispatch if F07 pressed.
RT   C     KEY           IFEQ      F07
      *
RT   C                   LEAVE
RT   C                   ENDIF
      *
      * End of DO loops for F10/F12 key checks.
     C                   ENDDO
      *
      *-------------------------------------------------------
      * Confirm order - prompt for delivery details.
      *               - file updates when F10 pressed.
     C     KEY           DOUEQ     F10
     C     XERROR        ANDEQ     XNO
     C     KEY           OREQ      F12
      *
      * Clear messages.
     C                   EXSR      YCLRMG
      *
      * Process the various function keys available on the screen.
      *
      * Exit if F12 pressed.
OOO  C*          KEY       IFEQ F12
OOO  C*                    GOTO DET
OOO  C*                    ENDIF
      *
      * Check for minimum order value.
RT   C     KEY           IFNE      F07
     C     MORDV         IFGT      0
     C                   EXSR      MINVAL
     C                   ENDIF
      *
XXX   * Credit limit check.... Warning only.
XXX  C     XKTVAL        ADD       XJTYSL        TOT              20 5
XXX  C     TOT           IFGT      XJCLIM
XXX  C                   MOVE      *ON           *IN46
XXX  C                   MOVEL     'HSV2019'     P0MSID
XXX  C                   EXSR      YSNDMG
XXX  C                   ENDIF
RT   C                   ENDIF
      *
      * Display messages.
     C                   WRITE     MSGCTL
      *
      * Display key text footer.
XXXM C*                    WRITEHSS200E
RT   C     KEY           IFNE      F07
XXXM C                   WRITE     HSS200F
RT   C                   ENDIF
      *
      * Delivery address prompt screen.
     C                   TIME                    XXTME
      *
      * Program in inquiry, dispatch or maintenance mode
     C     YMODE         IFEQ      'I'
     C     YMODE         OREQ      'M'
     C     YMODE         OREQ      'D'
     C     WKORDN        CHAIN     HSLODELA                           99
      *
      * Write fields for order delivery detail record.
     C     *IN99         IFEQ      *OFF
     C                   MOVEL     VNAM1         XVNAM1
     C                   MOVEL     VADR1         XVADR1
     C                   MOVEL     VADR2         XVADR2
     C                   MOVEL     VADR3         XVADR3
     C                   MOVEL     VPCDE         XVPCDE
     C                   MOVEL     VDIN1         XVDIN1
     C                   MOVEL     VDIN2         XVDIN2
     C                   MOVEL     VDIN3         XVDIN3
     C                   ENDIF
     C                   ENDIF
      *
      * Write order delivery details record.
RT   C     KEY           IFNE      F07
     C                   EXFMT     HSS200D
RT   C                   ENDIF
      *
OWE   * Exit if F12 pressed.
OWE  C     KEY           IFEQ      F12
     C                   EXSR      YDELT
OWE  C                   GOTO      DET
OWE  C                   ENDIF
      *
      * Clear messages.
XXX  C     *IN47         IFEQ      *OFF
     C                   EXSR      YCLRMG
XXX  C                   ENDIF
      *
      * Update all files, if no errors exist.
     C     KEY           IFEQ      F10
     C     XERROR        ANDEQ     XNO
RT   C     KEY           OREQ      F07
     C                   Z-ADD     1             RRNX
     C     *IN98         DOUEQ     *ON
BL   C     RRNX          OREQ      100
BL   C     XSELC         OREQ      *BLANK
     C     RRNX          CHAIN     HSS200C                            98
     C     XSELC         IFNE      *BLANK
     C     XKPROD        ANDNE     *BLANK
     C     *IN98         ANDEQ     *OFF
     C     XSELC         ORNE      *BLANK
     C     XNDESC        ANDNE     *BLANK
     C     *IN98         ANDEQ     *OFF
      *
      * Save RRN for current order line.
     C                   Z-ADD     RRNX          RRNLIN
      *
OWE   * Update Voucher Control if in entry mode....
OWE  C     YMODE         IFEQ      'E'
BL   C     MSALE         ANDEQ     'S'
OWE  C                   EXSR      UPPVCT
OWE  C                   ENDIF
      *
      * Re-position to required subfile line
     C                   Z-ADD     RRNLIN        RRNX
     C     RRNX          CHAIN     HSS200C                            98
      *
BL    * Create/Update order details if in Entry,Maint,or Dispatch mode.
BL   C     YMODE         IFEQ      'E'
BL   C     YMODE         OREQ      'D'
BL   C     YMODE         OREQ      'M'
     C                   EXSR      UPORDD
BL   C                   ENDIF
      *
BL    * Update voucher tracking if in Entry or Dispatch mode.
BL    * Stock lines only.
     C     YMODE         IFEQ      'E'
     C     XSELC         ANDEQ     'S'
BL   C     YMODE         OREQ      'D'
BL   C     XSELC         ANDEQ     'S'
     C                   EXSR      UPTRAC
BL   C                   ENDIF
      *
BL    * Allocate inventory if in Entry mode.
BL    * Stock lines only.
BL   C     YMODE         IFEQ      'E'
BL   C     XSELC         ANDEQ     'S'
      * Update inventory allocations.
     C                   EXSR      UPINVA
     C                   ENDIF
      *
BL    * Sell inventory if in Dispatch mode.
BL    * Stock lines only.
BL   C     YMODE         IFEQ      'D'
BL   C     XSELC         ANDEQ     'S'
      * Update inventory sales.
BL   C                   EXSR      UPINVS
      *
      * Create inventory sales transaction.
     C                   EXSR      UPINVT
     C                   ENDIF
     C                   ENDIF
     C                   ADD       1             RRNX
     C                   ENDDO
      *
BL    * Create/Update order header if in Entry,Maint,or Dispatch mode.
BL   C     YMODE         IFEQ      'E'
BL   C     YMODE         OREQ      'D'
BL   C     YMODE         OREQ      'M'
     C                   EXSR      UPORDH
      *
      * Create/update delivery record if in Entry,Maint or Dispat.mode.
     C                   EXSR      UPODEL
BL   C                   ENDIF
      *
BL    * Ship to all delivery points if in Entry mode.
BL   C     YMODE         IFEQ      'E'
BL   C     MALLP         ANDEQ     'Y'
     C                   EXSR      SHPALL
BL   C                   ENDIF
      *
BL    * Print delivery note if in Entry mode, and charges only not set.
BL   C     YMODE         IFEQ      'E'
BL   C     MINVC         ANDNE     'Y'
     C                   EXSR      PRTDEL
BL   C                   ENDIF
      *
BL    * Print Invoice if in Entry mode, and Immediate print required.
BL   C     YMODE         IFEQ      'E'
BL   C     MINVP         ANDEQ     'I'
     C                   EXSR      PRTINV
BL   C                   ENDIF
      *
     C                   ENDIF
      * Process Despatch if F07 pressed.
RT   C     KEY           IFEQ      F07
     C                   EXSR      YCLRSC
      *
RT   C                   LEAVE
RT   C                   ENDIF
      *
      * End of Confirmation.
     C                   ENDDO
      *
      * Return to order details if F12 pressed.
     C     KEY           IFEQ      F12
     C                   GOTO      DET
     C                   ENDIF
      *
      * Clear Subfile
     C                   MOVEA     '1000'        *IN(70)
     C                   WRITE     HSS200B
      *
      * Clear contents of HSPEXPA.
     C                   EXSR      YDELT
      *
      * Return to order header.
     C                   GOTO      HDR
      *
      *****************************************************************
      *----------------------------------------------------------------
      * @CLRSC - Clear screen fields.
      *----------------------------------------------------------------
      *
     C     YCLRSC        BEGSR
      *
BL    * Clear header screen fields.
BL   C     YMODE         IFNE      'E'
     C                   CLEAR                   XJTYPE
BL   C                   ENDIF
BL   C     YMODE         IFEQ      'D'
     C                   CLEAR                   XJSORD
     C                   CLEAR                   XENAM1
     C                   CLEAR                   XVQTY
BL   C                   ENDIF
     C                   CLEAR                   XJCOMP
     C                   CLEAR                   XJWHSE
     C                   CLEAR                   XJPCDE
     C                   CLEAR                   XJCUST
     C                   CLEAR                   XJDISP
     C                   CLEAR                   XJORDD
     C                   CLEAR                   XJORDR
      *
BL    * Clear delivery screen fields.
BL   C                   CLEAR                   XVNAM1
BL   C                   CLEAR                   XVADR1
BL   C                   CLEAR                   XVADR2
BL   C                   CLEAR                   XVADR3
BL   C                   CLEAR                   XVPCDE
BL   C                   CLEAR                   XVDIN1
BL   C                   CLEAR                   XVDIN2
BL   C                   CLEAR                   XVDIN3
     C                   ENDSR
      *
      *----------------------------------------------------------------
      * SHPONL - Validate ship only requirements.
      *----------------------------------------------------------------
     C     SHPONL        BEGSR
      *
      * Check if a ship only record exists for this customer
     C     XJCUST        CHAIN     HSLSHPOA                           99
     C     *IN99         IFEQ      *OFF
     C                   MOVEL     'Y'           SHONLY            1
BL   C                   ELSE
BL   C                   MOVEL     ' '           SHONLY
     C                   ENDIF
     C                   ENDSR
      *
      *----------------------------------------------------------------
      * AGXREF - Check for agency cross-references.
      *----------------------------------------------------------------
     C     AGXREF        BEGSR
     C     KEYXRF        CHAIN     HSLVXRFB                           99
     C     *IN99         IFEQ      *OFF
     C                   MOVEL     HPROD         KPROD
     C                   MOVEL     HPROD         XKPROD
     C                   ENDIF
     C                   ENDSR
      *
      *----------------------------------------------------------------
      * VALIDD - Validate order detail screen fields.
      *----------------------------------------------------------------
     C     VALIDD        BEGSR
      *
      * Order Detail validation:
      *
      * Reset work values.
     C*                    Z-ADD0         RRN#
OWEM C                   Z-ADD     0             RRNS              5 0
OWE  C                   Z-ADD     1             RRNT              5 0
     C                   RESET                   XERROR
     C                   MOVE      *OFF          *IN61                          Hide F10/F11
      *
      * Reset error indicators.
     C                   MOVEA     XZEROS        *IN(30)
      *
      * Read all Records from subfile and validate contents.
     C     *IN99         DOUEQ     *ON                                          ..Do1
OWE   *
OWE   * Process the subfile in one of two modes depending on whether
OWE   * a previous change to the subfile has been made....
OWE   *
OWE  C     *IN82         IFEQ      *OFF
OWE  C                   READC     HSS200C                                99
OWE  C                   Z-ADD     RRNX          RRNT
OWE  C                   ADD       1             RRNT
OWE  C                   ELSE
OWE  C     RRNT          IFEQ      101
OWE  C                   LEAVE
OWE  C                   ENDIF
OWE  C     RRNT          CHAIN     HSS200C                            99
OWE  C                   ADD       1             RRNT
OWE  C                   ENDIF
      *
     C*                    READCHSS200C                  99
      * Retrieve subfile record.
     C     *IN99         IFEQ      *OFF                                         ...If2
OWE  C                   MOVE      XKPROD        TPROD1           13
OWE  C                   MOVE      XKQTYN        TQTYN1           15 0
OWE  C                   MOVE      *ON           *IN82
      *
      * Reset subfile error indicators.
     C                   MOVEA     '00000000'    *IN(36)
      *
     C     XSELC         IFNE      *BLANK                                       ....If3
     C     XKPROD        ORNE      *BLANK                                       ....If3
     C     XNDESC        ORNE      *BLANK                                       ....If3
     C     XKPRIC        ORNE      *ZEROS                                       ....If3
     C     XKQTYN        ORNE      *ZEROS                                       ....If3
     C     XKVALU        ORNE      *ZEROS                                       ....If3
     C     XKVATA        ORNE      *ZEROS                                       ....If3
     C     XKSERC        ORNE      *BLANKS                                      ....If3
     C     XKSERF        ORNE      *ZEROS                                       ....If3
     C     XKSERT        ORNE      *ZEROS                                       ....If3
      *
      * Count active subfile records.
OWE  C*                    ADD  1         RRN#
OWE  C                   ADD       1             RRNS
      *
      * Validate Selection code.
     C     XSELC         IFNE      'S'
     C     XSELC         ANDNE     'N'
     C     XSELC         ANDNE     'T'
      *
      * Validate Selection code / Product code / Text combination
     C     XSELC         OREQ      *BLANK
     C     XKPROD        ANDNE     *BLANKS
     C     XSELC         OREQ      *BLANK
     C     XNDESC        ANDNE     *BLANKS
     C     XSELC         OREQ      *BLANK
     C     XKPRIC        ANDNE     0
     C     XSELC         OREQ      *BLANK
     C     XKQTYN        ANDNE     0
     C     XSELC         OREQ      'T'
     C     XKPROD        ANDNE     *BLANKS
     C     XSELC         OREQ      'T'
     C     XKPRIC        ANDNE     0
     C     XSELC         OREQ      'T'
     C     XKQTYN        ANDNE     0
     C     XSELC         OREQ      'T'
     C     XKSERC        ANDNE     *BLANKS
     C     XSELC         OREQ      'T'
     C     XKSERF        ANDNE     0
     C     XSELC         OREQ      'T'
     C     XKSERT        ANDNE     0
     C     XSELC         OREQ      'S'
     C     XKQTYN        ANDEQ     0
     C*          #SELC     OREQ 'S'
     C*          #KPRIC    ANDEQ0
     C     XSELC         OREQ      'N'
     C     XKQTYN        ANDEQ     0
     C     XSELC         OREQ      'N'
     C     XKPRIC        ANDEQ     0
     C                   MOVE      *ON           *IN36
     C                   MOVE      XYES          XERROR
     C                   MOVEL     'HSV2006'     P0MSID
     C                   EXSR      YSNDMG
     C                   ENDIF
      *
      * Validate Selection code for Invoice Charge Only order type.
     C     XSELC         IFEQ      'S'
     C     MINVC         ANDEQ     'Y'
     C                   MOVE      *ON           *IN36
     C                   MOVE      XYES          XERROR
     C                   MOVEL     'HSV2014'     P0MSID
     C                   EXSR      YSNDMG
     C                   ENDIF
      *
XXX  C     YMODE         IFEQ      'D'
XXX  C     XKQTYN        ANDGT     XXQTYN
XXX  C                   MOVE      XYES          XERROR
XXX  C                   MOVEL     'HSV2020'     P0MSID
XXX  C                   EXSR      YSNDMG
XXX  C                   LEAVE
XXX  C                   ELSE
XXX  C                   EXSR      YCLRMG
XXX  C                   ENDIF
      *
      * Validate Product.
     C     XSELC         IFEQ      'S'
     C     XKPROD        IFNE      *BLANKS
     C     XKPROD        CHAIN     HSLPRODA                           99
     C     *IN99         IFEQ      *ON
     C                   MOVE      *ON           *IN37
     C                   MOVE      XYES          XERROR
     C                   MOVEL     'HSV2007'     P0MSID
     C                   EXSR      YSNDMG
     C                   ELSE
     C                   MOVEL     NDESC         XNDESC
     C                   Z-ADD     NPRIC         XKPRIC
     C                   ENDIF
     C                   ENDIF
     C                   ENDIF
      *
      * Reverse price for Credit
     C     MSALE         IFEQ      'C'
     C                   Z-SUB     XKPRIC        XKPRIC
     C                   ENDIF
      *
      * Extended value
     C     XSELC         IFEQ      'S'
     C     XSELC         OREQ      'N'
     C     XKPRIC        MULT      XKQTYN        XKVALU
BL    *
BL   C*          #KVALU    MULT MVATP     #KVATA
     C                   ENDIF
      *
OWE   * Save Price, Value and Description field contents....
OWE  C                   MOVE(P)   XKPRIC        TKPRIC            9 2
OWE  C                   MOVE(P)   XKVALU        TKVALU            9 2
OWE  C                   MOVE(P)   XNDESC        TNDESC           19
      *
      * Check quantity against allocated serial numbers.
OOO  C*          #KQTYN    IFNE 0
OOO  C*          #KSERF    ANDNE0
OOO  C*          #KSERT    ANDNE0
OOO  C*          #KSERT    SUB  #KSERF    WKQTYN
OOO  C*                    ADD  1         WKQTYN
OOO  C*          #KQTYN    IFNE WKQTYN
OOO  C*                    MOVEA'1011'    *IN,40
OOO  C*                    MOVE #YES      #ERROR
OOO  C*                    MOVEL'HSV2013' P0MSID
OOO  C*                    EXSR @SNDMG
OOO  C*                    ENDIF
OOO  C*                    ENDIF
      *
      * Check voucher control if not yet allocated
     C     XSELC         IFEQ      'S'
     C     XKQTYN        ANDGT     0
OOO  C*          #KSERC    IFEQ *BLANKS
OOO  C*          #KSERF    ANDEQ0
OOO  C*          #KSERT    ANDEQ0
     C                   MOVEL     'U'           WKVCTL
     C                   EXSR      UPVCTL
     C                   ENDIF
OOO  C*                    ENDIF
      *
      * Update subfile record with DSPATR settings and set SFLRCDNBR.
     C                   Z-ADD     RRNX          RCDNBR
OWE  C                   MOVE      TKPRIC        XKPRIC
OWE  C                   MOVE      TKVALU        XKVALU
OWE  C                   MOVE      TNDESC        XNDESC
     C                   UPDATE    HSS200C                                      SFL
     C                   MOVEA     '00000000'    *IN(36)
      *
      * If errors encountered in subfile then exit subfile validation.
     C     XERROR        IFEQ      XYES
OWE  C                   MOVEL(P)  XSELC         TSELC             1
OWE  C                   MOVEL(P)  XKPROD        TPROD            13
OWE  C                   MOVEL(P)  XKPRIC        TPRIC             9 2
OWE  C                   MOVEL(P)  XKQTYN        TQTYN             9 0
OWE  C                   MOVEL(P)  XNDESC        TDESC            19
OOO  C*                    Z-ADDRRN#      RRNS    50
     C                   LEAVE
     C                   ENDIF
      *
      * End of non-blank subfile check.
     C                   ENDIF                                                  ....EndIf3
      *
      * End of Subfile CHAIN check.
     C                   ENDIF                                                  ...EndIf2
      *
      * End of loop for next subfile record.
     C                   ENDDO                                                  ..EndDo1
      *
      * Save last RRN number used.
BL   C*                    Z-ADDRRN#      SAVRRN
      *
      * If no errors found...
     C     XERROR        IFEQ      XNO
      * ...display "Data valid.Press F10 to update" message...
     C                   MOVEL     'HSV9006'     P0MSID
     C                   EXSR      YSNDMG
      * ...activate F10 key (*IN61=*ON).
     C                   MOVE      *ON           *IN61
     C                   ENDIF
XXX  C     XJUMP1        IFEQ      XYES
XXX  C     *IN52         ANDEQ     *ON
     C                   CALL      'HSR342'
     C                   ENDIF
XXX  C                   MOVE      *OFF          *IN52
     C                   ENDSR
      *
      *----------------------------------------------------------------
      * DISCNT - Discount retrieval.
      *----------------------------------------------------------------
      *
     C     DISCNT        BEGSR
      *
      * If customer discount is not entered on header screen either
      * caluclate from HSPDISC file keyed on Order Value or default
      * according to Customer Type.
      *
     C     XJDISP        IFEQ      0
      *
      * Setup key list for HSPDISC
      *
     C                   Z-ADD     XKTVAL        PFAMT
      *
      * SETLL on HSLDISCA
      *
     C     DSCKEY        SETLL     HSLDISCA                               99
      *
      * If record not found READP
      *
     C     *IN99         IFEQ      *OFF
     C                   READP     HSLDISCA                               99
      *
      * If not BOF
      *
     C     *IN99         IFEQ      *OFF
BL   C     PCTYP         ANDEQ     ECTYP
     C                   Z-ADD     PDISC         KDISP
      *
      * Else calculate discount according to Customer Type
      *
     C                   ELSE
      *
     C                   SELECT
      *
      * If Customer Type is '001' - Z-ADD 10 to discount
      *
     C     ECTYP         WHENEQ    '001'
     C                   Z-ADD     10            KDISP
      *
      * If Customer Type is '002' - Z-ADD 20 to discount
      *
     C     ECTYP         WHENEQ    '002'
     C                   Z-ADD     20            KDISP
      *
     C                   ENDSL
      *
     C                   ENDIF
      *
      * Record found on SETLL
      *
     C                   ELSE
      *
     C                   Z-ADD     PDISC         KDISP
      *
     C                   ENDIF
      *
      * #JDISP not equal to 0
      *
     C                   ELSE
     C                   Z-ADD     XJDISP        KDISP
      *
     C                   ENDIF
      *
     C                   ENDSR
      *
      *----------------------------------------------------------------
      * Check for minimum order value.
      *----------------------------------------------------------------
     C     MINVAL        BEGSR
     C                   Z-ADD     0             WKTOTV
     C                   Z-ADD     1             RRNP
      *
      * Accumulate order total value
     C     *IN99         DOUEQ     *ON
BL   C     RRNP          OREQ      100
BL   C     XSELC         OREQ      *BLANK
     C     RRNP          CHAIN     HSS200C                            99
     C     *IN99         IFEQ      *OFF
     C                   ADD       XKVALU        WKTOTV
     C                   ENDIF
     C                   ADD       1             RRNP
     C                   ENDDO
      *
      * Compare order total value and minimum order value
     C     WKTOTV        IFLT      MORDV
     C                   MOVE      XYES          XERROR
     C                   MOVEL     'HSV2011'     P0MSID
     C                   EXSR      YSNDMG
     C                   ENDIF
     C                   Z-ADD     1             RRNP
     C                   Z-ADD     1             RRNX
     C                   ENDSR
      *
      *----------------------------------------------------------------
      * Ship to all delivery points.
      *----------------------------------------------------------------
     C     SHPALL        BEGSR
     C*
     C* SETLL on HSLCUSTA with Customer Number
     C*
     C     XJCUST        SETLL     HSLCUSTA
     C*
     C* READE on HSLCUSTA with Customer Number
     C*
     C     XJCUST        READE     HSLCUSTA                               99
     C*
     C* If not EOF
     C*
     C     *IN99         DOWEQ     *OFF
     C*
     C* If ECGRP not equal to blanks
     C*
     C     ECGRP         IFNE      *BLANKS
     C*
     C* CHAIN to Customer File for Delivery Name and Address
     C*
     C*          ECGRP     CHAINALTCUSTF             13
     C*
     C*          *IN13     IFEQ *OFF
     C*
     C* Write Order Header Record
     C*
     C                   EXSR      UPORDH
     C*
     C* Set up Delivery Name and Address
     C*
     C                   MOVEL     ENAM1         XVNAM1
     C                   MOVEL     EADR1         XVADR1
     C                   MOVEL     EADR2         XVADR2
     C                   MOVEL     EADR3         XVADR3
     C                   MOVEL     EPCDE         XVPCDE
     C*
     C* Write Order Delivery Record
     C*
     C                   EXSR      UPODEL
     C*
     C* Write Order Detail Record
     C*
     C                   EXSR      UPORDD
     C*
     C* ECGRP equal to blanks
     C*
     C*                    ENDIF
     C*
     C* Customer Record not found
     C*
     C                   ENDIF
     C*
     C* Increment order number
     C*
     C     *LOCK         IN        ORDERX
     C                   ADD       1             ORDERX
     C                   OUT       ORDERX
     C                   Z-ADD     ORDERX        XJSORD
     C*
     C* READE on HSLCUSTA with Customer Number
     C*
     C     XJCUST        READE     HSLCUSTA                               99
     C*
     C                   ENDDO
     C*
     C* EOF on HSLCUSTA
     C*
     C                   ENDSR
      *
      *----------------------------------------------------------------
      * Update voucher control.
      *----------------------------------------------------------------
     C     UPVCTL        BEGSR
      *
     C                   MOVE      *ON           *IN85
      * Save order line values
      *
     C                   Z-ADD     0             XQUAN             9 0
     C                   MOVE      XNO           XJUMP             1
      * Clear flag for successful range allocation.
     C                   MOVEL     *BLANK        WKRANG
      *
      * Clear flag for first tracking record found.
     C                   MOVEL     XNO           XFIRST            1
      *
      * Get Serial number range.
     C                   MOVEL     *BLANKS       WKSERC
     C     *IN92         DOUEQ     *ON
     C     WKRANG        OREQ      'Y'
      *
OWE   * Work back through the subfile checking for duplicate
OWE   * product codes.... If found validate data under DOUB subroutine.
      *
OWE  C                   MOVE      RRNX          RRNXX             5 0
OWE  C     RRNX          DOUEQ     0
OWE  C                   SUB       1             RRNX
OWE  C     RRNX          IFEQ      0
OWE  C                   LEAVE
OWE  C                   ENDIF
OWE  C     RRNX          CHAIN     HSS200C                            90
OWE  C     XKPROD        IFEQ      TPROD1
OWE  C                   MOVE      RRNXX         RRNX
OWE  C                   EXSR      DOUB
OWE  C                   MOVE      *ON           *IN81
OWE  C                   LEAVE
OWE  C                   ENDIF
OWE  C                   ENDDO
      *
OWE   * Reset subfile position.....
OWE  C                   MOVE      RRNXX         RRNX
OWE  C     RRNX          CHAIN     HSS200C                            90
      *
      * Exit from subroutine if DOUB sr has been processed....
      *
OWE  C     *IN81         IFEQ      *ON
OWE  C                   MOVE      XKSERF        XKSERF
OWE  C                   MOVE      XKSERC        XKSERC
OWE  C                   MOVE      XKSERT        XKSERT
OWE  C                   MOVE      *OFF          *IN81
OWE  C                   LEAVE
OWE  C                   ENDIF
      *
     C     VCHKEY        SETLL     HSLVCTLA
     C     XKPROD        READE     HSLVCTLA                               92
      *
      * Move pointer file values into temporary fields....
      *
     C                   MOVE      BPROD         OPROD            13
     C                   MOVE      BSERCC        OSERC             3
     C                   MOVE      BSERNN        OSERN             9 0
     C                   Z-ADD     BSERNN        WKSERN
     C                   MOVE      BSERCC        WKSERC
     C                   Z-ADD     BSERNN        XXSERF            9 0
     C********             SUB  1         ##SERF
      *
      *
     C     *IN92         IFEQ      *OFF
      *
      * Scan voucher tracking file for first available voucher....
      *
     C                   MOVE      BSERCC        XKSERC
     C                   MOVE      OSERN         XKSERF
      *
     C     *IN94         DOUEQ     *ON
     C     XQUAN         OREQ      XKQTYN
      *
     C     *IN85         IFEQ      *ON
     C     TRCKEY        SETLL     HSLTRACB
     C                   MOVE      *OFF          *IN85
     C                   ENDIF
      *
     C     XKPROD        READE     HSLTRACB                               94
      *
     C     *IN94         IFEQ      *ON
     C                   LEAVE
     C                   ENDIF
      *
     C     ASERC         IFNE      WKSERC
     C     ASERN         ORNE      WKSERN
     C     AALLD         ORNE      *ZEROS
     C                   ADD       1             DSERN
      *
     C     *IN87         IFEQ      *OFF
     C     XXSERN        ADD       1             XXRES             9 0
PPP  C*          XXRES     IFNE ASERN
PPP  C*                    MOVE ASERN     ##SERF
PPP  C*                    ELSE
     C                   MOVE      ASERN         XXSERF
     C                   ADD       1             XXSERF
     C                   ADD       1             WKSERN
RRR  C                   MOVE      *ON           *IN85
RRR  C                   ADD       1             XKSERF
PPP  C*                    ENDIF
     C                   ELSE
      *
      * No previous error so add to HSPEXPA.....
     C                   MOVE(P)   WKSERC        XXSERC            3
     C                   MOVE(P)   WKSERN        XXSERN            9 0
     C                   SUB       1             WKSERN
     C                   MOVE      XYES          XJUMP
XXX  C                   MOVE      XYES          XJUMP1            1
      *
     C****       *IN87     IFEQ *ON
     C                   MOVE      XXSERF        USERNS
     C                   MOVE      WKSERN        USERNE
     C                   MOVE      WKSERC        USERCC
     C                   MOVE      XKPROD        UPROD
     C                   OPEN      HSLEXPAA
     C                   WRITE     HSFEXPA
     C                   CLOSE     HSLEXPAA
     C*****                ENDIF
      *
     C                   MOVE      ASERN         XXSERF
     C                   ADD       1             DSERN
     C     DSERN         IFNE      ASERN
     C     ASERN         SUB       DSERN         DIF               9 0
     C                   ADD       DIF           XXSERF
     C                   ENDIF
      *
     C                   ADD       1             XKSERF
     C                   ADD       2             WKSERN
     C                   MOVE      *ON           *IN85
     C                   MOVE      *OFF          *IN87
      *
XXX  C     ASERC         IFNE      WKSERC
XXX  C                   MOVE      ASERC         WKSERC
XXX  C                   MOVE      ASERN         WKSERN
XXX  C                   MOVE      WKSERC        XKSERC
XXX  C                   MOVE      WKSERN        XKSERF
XXX  C                   MOVE      WKSERN        XXSERF
XXX  C                   MOVE      *ON           *IN85
XXX  C                   ENDIF
      *
     C                   ITER
     C                   ENDIF
      *
     C     ASERC         IFNE      WKSERC
     C                   MOVE      ASERC         WKSERC
     C                   MOVE      ASERN         WKSERN
     C                   MOVE      WKSERC        XKSERC
XXX  C                   MOVE      WKSERN        XKSERF
XXX  C                   MOVE      WKSERN        XXSERF
     C                   MOVE      *ON           *IN85
     C                   ENDIF
      *
     C                   ENDIF
      *
      *
     C     AALLD         IFEQ      *ZEROS
     C***        *IN87     IFEQ *OFF
     C***                  ADD  1         ##SERF
     C***                  ENDIF
     C                   MOVE      *ON           *IN87
     C                   ADD       1             XQUAN
     C                   MOVE      XYES          XFIRST
     C                   MOVE      ASERC         WKSERC
     C                   MOVE(P)   ASERN         DSERN             9 0
     C                   ADD       1             WKSERN
     C                   ADD       1             XKSERF
     C                   MOVE      *ON           *IN85
     C                   ITER
     C                   ELSE
     C                   ITER
     C                   ENDIF
      *
     C                   ENDDO
      *
     C     XFIRST        IFEQ      XNO
     C                   MOVE      XYES          XERROR
     C                   MOVEL     'HSV2024'     P0MSID
     C                   EXSR      YSNDMG
     C                   CLEAR                   XKSERC
     C                   CLEAR                   XKSERT
     C                   CLEAR                   XKSERF
     C                   LEAVE
     C                   ENDIF
      *
     C     XQUAN         IFNE      XKQTYN
     C                   MOVE      XYES          XERROR
     C                   MOVEL     'HSV2025'     P0MSID
     C                   EXSR      YSNDMG
     C                   CLEAR                   XKSERC
     C                   CLEAR                   XKSERT
     C                   CLEAR                   XKSERF
     C*****                MOVE *ON       *IN52
     C                   LEAVE
     C                   ENDIF
      *
     C                   MOVE      *ON           *IN52
      *
     C     XJUMP         IFEQ      XYES
     C***                  MOVE #YES      #ERROR
     C                   MOVEL     'HSV2026'     P0MSID
     C                   EXSR      YSNDMG
      *
     C                   SUB       1             WKSERN
XXX  C                   MOVEL     'Y'           WKRANG
      *
     C*****                MOVE XXSERC    #KSERC
     C*****                MOVE XXSERN    #KSERF
     C*****      TRCKEY    CHAINHSLTRACB             99
     C*****      *IN99     IFEQ *OFF
     C*****                ADD  1         ##SERF
     C*****                ENDIF
      *
     C                   MOVE      XXSERF        USERNS
     C                   MOVE      WKSERN        USERNE
     C                   MOVE      WKSERC        USERCC
     C                   OPEN      HSLEXPAA
     C                   WRITE     HSFEXPA
     C                   CLOSE     HSLEXPAA
      *
     C                   CLEAR                   XKSERC
     C                   CLEAR                   XKSERT
     C                   CLEAR                   XKSERF
     C                   EXSR      YJUMP
     C                   MOVE      *ON           *IN86
     C                   MOVE      *ON           *IN61
     C                   LEAVE
     C                   ENDIF
      *
      * Series code found.
     C                   MOVE      BSERCC        XKSERC
      *
     C                   Z-ADD     OSERN         XKSERF
     C                   SUB       1             WKSERN
     C                   Z-ADD     WKSERN        XKSERT
      *
      * Flag successful range allocation.
     C                   MOVEL     'Y'           WKRANG
      *
      * Update if required.
     C                   ENDIF
     C                   ENDDO
      *
      * Unsuccessful range allocation.
     C     WKRANG        IFNE      'Y'
     C                   MOVEA     '111'         *IN(41)
XXX  C****                 MOVE #YES      #ERROR
     C                   MOVEL     'HSV2012'     P0MSID
     C                   EXSR      YSNDMG
     C                   ENDIF
      *
     C                   ENDSR
      *
      *----------------------------------------------------------------
      * Display contents of HSLEXPAA
      *----------------------------------------------------------------
      *
     C     YJUMP         BEGSR
     C                   ENDSR
      *
      *
      *----------------------------------------------------------------
      * Delete contents of HSLEXPAA
      *----------------------------------------------------------------
      *
     C     YDELT         BEGSR
     C                   CALL      'HSC200A'
     C                   ENDSR
      *
      *----------------------------------------------------------------
      * Repeat of Product Code in a single order
      *----------------------------------------------------------------
      *
OWE  C     DOUB          BEGSR
      *
      * Get Serial number range.
OWE  C                   MOVEL     *BLANKS       WKSERC
OWE  C     *IN92         DOUEQ     *ON
OWE  C     WKRANG        OREQ      'Y'
      *
OWE  C     VCHKEY        SETLL     HSLVCTLA
OWE  C     XKPROD        READE     HSLVCTLA                               92
OWE  C     *IN92         IFEQ      *OFF
      *
      * Get available series code.
OWEM C     BSERNN        ADD       TQTYN1        XXSERN            9 0
OWE  C*          ##SERN    IFGT BSERNE
OWE  C*                    MOVELBSERCN    WKSERC
OWE  C                   ITER
OWE  C                   ELSE
      *
      * Work back through the subfile searching for duplicate
      * product code/series code combination records......
      *
OWE  C                   MOVE(P)   RRNX          RRNXX             5 0
OWE  C     RRNX          DOUEQ     0
OWE  C                   SUB       1             RRNX
OWE  C     RRNX          IFEQ      0
OWE  C                   MOVE      *ON           *IN83
OWE  C                   LEAVE
OWE  C                   ENDIF
OWE  C     RRNX          CHAIN     HSS200C                            90
OWE  C     XKSERC        IFEQ      BSERCC
OWE  C     XKSERT        ADD       TQTYN1        RES               9 0
OWE  C*          RES       IFLE BSERNE
OWE  C                   MOVE(P)   XKSERC        KKSERC            3
OWE  C                   MOVE(P)   XKSERT        KKSERT            9 0
OWE  C                   LEAVE
OWE  C                   ELSE
OWE  C                   MOVE      *ON           *IN84
OWE  C                   LEAVE
OWE  C                   ENDIF
OWE  C*                    ENDIF
OWE  C                   ENDDO
      *
      * Reset the subfile pointer position.....
OWE  C                   MOVE(P)   RRNXX         RRNX
OWE  C     RRNX          CHAIN     HSS200C                            90
      *
OWE  C     *IN84         IFEQ      *OFF
OWE  C     *IN83         ANDEQ     *OFF
OWE   * Series code found.
OWE  C                   MOVE(P)   KKSERC        XKSERC            3
OWE   *
OWE   * Set To serial number for the order.
OWE  C                   MOVE(P)   RES           XKSERT            9 0
OWE   *
OWE   * Set From Serial Number for the order.
OWE  C     KKSERT        ADD       1             XKSERF            9 0
OWE   *
OWE   * Set Next Serial Number for the voucher control.
OWE  C                   ADD       TQTYN1        BSERNN
OWE   *
OWE   * Flag successful range allocation.
OWE  C                   MOVEL     'Y'           WKRANG
OWE  C                   ITER
OWE  C                   ENDIF
      *
OWE  C     *IN83         IFEQ      *ON
OWE  C     *IN84         ANDEQ     *OFF
OWE  C                   MOVE      *OFF          *IN83
      *
OWE   * Series code found.
OWE  C                   MOVE      BSERCC        XKSERC            3
OWE   *
OWE   * Set To serial number for the order.
OWE  C     BSERNN        ADD       TQTYN1        XKSERT            9 0
OWE  C                   SUB       1             XKSERT
OWE   *
OWE   * Set From Serial Number for the order.
OWE  C                   Z-ADD     BSERNN        XKSERF
OWE   *
OWE   * Set Next Serial Number for the voucher control.
OWE  C                   ADD       TQTYN1        BSERNN
OWE   *
OWE   * Flag successful range allocation.
OWE  C                   MOVEL     'Y'           WKRANG
OWE  C                   ITER
OWE  C                   ENDIF
OWE  C                   MOVE      *OFF          *IN84
OWE  C*                    MOVELBSERCN    WKSERC
      *
OWE  C*                    ENDIF
OWE  C                   ENDIF
OWE  C                   ENDDO
OWE  C                   ENDSR
      *----------------------------------------------------------------
      * Update voucher tracking.
      *----------------------------------------------------------------
     C     UPTRAC        BEGSR
      *
      * Reverse order date before update.
BL   C     YMODE         IFEQ      'E'
     C                   Z-ADD     JDD           WKD
     C                   Z-ADD     JMM           WKM
     C                   Z-ADD     JCC           WKC
     C                   Z-ADD     JYY           WKY
     C                   Z-ADD     WKORDD        ADFIS
BL   C                   ENDIF
      *
      * Locate voucher record.
     C     TRCKEY        SETLL     HSLTRACB
     C     XKPROD        DOUNE     APROD
     C     *IN99         OREQ      *ON
     C                   READ      HSLTRACB                               99
     C     *IN99         IFEQ      *OFF
      *
      * Exit if product code or series code does not match.
     C     XKPROD        IFNE      APROD
     C     XKSERC        ORNE      ASERC
     C                   LEAVE
     C                   ENDIF
      *
      * Update vouchers in the serial number range.
     C     XKSERF        IFLE      ASERN
     C     XKSERT        ANDGE     ASERN
BL   C     YMODE         IFEQ      'D'
BL   C                   MOVEL     XJCUST        ACUST
BL   C                   Z-ADD     0             ADSPB
BL   C                   ELSE
      *
     C                   Z-ADD     XJSORD        ASORD
     C                   Z-ADD     WKORDD        ADFIS
     C                   UPDATE    HSFTRAC
BL   C                   ENDIF
     C                   ENDIF
     C                   ENDIF
     C                   ENDDO
     C                   ENDSR
      *
      *----------------------------------------------------------------
      * Update inventory allocations.
      *----------------------------------------------------------------
     C     UPINVA        BEGSR
      *
      * Update stock quantities.
     C     IVMKEY        CHAIN     HSLINVMA                           99
     C     *IN99         IFEQ      *OFF
      *
      * Increase allocated quantity and reduce available quantity.
     C                   ADD       XKQTYN        DQTYR
     C                   SUB       XKQTYN        DQTYF
     C                   UPDATE    HSFINVM
     C                   ENDIF
     C                   ENDSR
      *
      *----------------------------------------------------------------
      * Update inventory sales.
      *----------------------------------------------------------------
BL   C     UPINVS        BEGSR
BL    *
BL    * Update stock quantities.
BL   C     IVMKEY        CHAIN     HSLINVMA                           99
BL   C     *IN99         IFEQ      *OFF
BL    *
BL    * Reduce allocated quantity and reduce on-hand quantity.
BL   C                   SUB       XKQTYN        DQTYR
BL   C                   SUB       XKQTYN        DQTYO
BL   C                   UPDATE    HSFINVM
BL   C                   ENDIF
BL   C                   ENDSR
      *
      *----------------------------------------------------------------
      * Print delivery note.
      *----------------------------------------------------------------
     C     PRTDEL        BEGSR
BL   C                   MOVEL     XJSORD        ORDPRM
BL   C                   CALL      'HSR230'
BL   C                   PARM                    ORDPRM
     C                   ENDSR
      *
      *----------------------------------------------------------------
      * Print invoice.
      *----------------------------------------------------------------
     C     PRTINV        BEGSR
BL   C                   MOVEL     XJSORD        ORDPRM
BL   C                   CALL      'HSR220'
BL   C                   PARM                    ORDPRM
     C                   ENDSR
      *
      *----------------------------------------------------------------
      * Create order details.
      *----------------------------------------------------------------
     C     UPORDD        BEGSR
      *
      * Order line already exists
     C                   MOVEL     ' '           UPDAT
     C     XOLIN         IFGT      0
     C     KEYOLN        CHAIN     HSLORDDB                           98
     C                   Z-ADD     XOLIN         KLINE
     C                   ENDIF
      *
      * Write fields for order detail record.
     C                   MOVEL     XSELC         KLTYP
     C                   MOVEL     XJCOMP        KCOMP
     C                   MOVEL     XJTYPE        KTYPE
     C                   Z-ADD     XJSORD        KSORD
     C                   Z-ADD     RRNX          KLINE
     C                   MOVEL     XJCUST        KCUST
     C                   MOVEL     XKPROD        KPROD
     C                   MOVEL     XKSERC        KSERC
     C                   Z-ADD     XKSERF        KSERNF
     C                   Z-ADD     0             KELEMF
     C                   Z-ADD     XKSERT        KSERNT
     C                   Z-ADD     0             KELEMT
     C                   Z-ADD     XKQTYN        KQTYN
     C                   Z-ADD     NCOST         KCOST
     C                   Z-ADD     XKPRIC        KPRIC
     C                   Z-ADD     XKVALU        KVALU
      *
BL    * Obtain VAT% from Order Type record.
BL   C*          #KVALU    MULT .175      KVATA
BL   C*          #KVALU    MULT MVATP     KVATA
BL   C*          KVATA     DIV  100       KVATA     H
     C                   Z-ADD     CYMD          KCRTD
     C                   Z-ADD     XXTME         KCRTT
     C                   MOVEL     XNDESC        KDESC
     C                   MOVEL     XJOBNO        KCRTS
     C                   MOVEL     XUSRID        KCRTU
     C                   MOVEL     XPGMID        KCRTP
     C                   MOVEL     *BLANK        KDELT
      *
      * Update order detail record.
     C     XOLIN         IFGT      0
     C     *IN98         IFEQ      *OFF
     C                   MOVEL     'Y'           UPDAT
     C                   UPDATE    HSFORDD
     C                   ENDIF
     C                   ELSE
      *
      * Write order detail record.
     C                   WRITE     HSFORDD
     C                   ENDIF
     C                   ENDSR
      *
      *----------------------------------------------------------------
      * Create order header.
      *----------------------------------------------------------------
     C     UPORDH        BEGSR
      *
      * Program mode - Maintenance, or Dispatch
     C     YMODE         IFEQ      'M'
     C     YMODE         OREQ      'D'
      *
      * Access order header record.
     C     XJSORD        CHAIN     HSLORDHA                           99
     C                   ENDIF
      *
      * Write fields for order header record.
     C                   MOVEL     XJCOMP        JCOMP
     C                   MOVEL     XJCUST        JCUST
     C                   MOVEL     *BLANKS       JCUSB
     C                   MOVEL     XJORDR        JORDR
     C                   MOVEL     XJTYPE        JTYPE
     C                   Z-ADD     XJSORD        JSORD
     C                   Z-ADD     WKORDD        JORDD
     C                   MOVEL     *BLANKS       JINVN
     C                   Z-ADD     0             JINVD
     C                   MOVEL     *BLANKS       JDELN
     C                   Z-ADD     0             JDELD
     C                   Z-ADD     CYMD          JCRTD
     C                   Z-ADD     XXTME         JCRTT
     C                   MOVEL     XJOBNO        JCRTS
     C                   MOVEL     XUSRID        JCRTU
     C                   MOVEL     XPGMID        JCRTP
     C                   MOVEL     *BLANK        JDELT
      *
      * Program mode - Entry
     C     YMODE         IFEQ      'E'
      *
      * Write order header record.
BL   C                   MOVEL     'A'           JSTAT
     C                   WRITE     HSFORDH
     C                   ENDIF
      *
      * Program mode - Maintenance, or Dispatch
     C     YMODE         IFEQ      'M'
     C     YMODE         OREQ      'D'
BL   C     YMODE         IFEQ      'D'
BL   C                   Z-ADD     *DATE         JDELD
BL   C                   MOVEL     'D'           JSTAT
BL   C                   ENDIF
      *
      * Update order header record.
     C     *IN99         IFEQ      *OFF
     C                   UPDATE    HSFORDH
     C                   ENDIF
     C                   ENDIF
     C                   ENDSR
      *
      *----------------------------------------------------------------
      * Create order delivery details.
     C     UPODEL        BEGSR
      *
      * Program mode - Maintenance, or Dispatch
     C     YMODE         IFEQ      'M'
     C     YMODE         OREQ      'D'
      *
     C     XJSORD        CHAIN     HSFODEL                            99
     C                   ENDIF
      *
      * Write fields for order delivery detail record.
     C                   MOVEL     XJCOMP        VCOMP
     C                   MOVEL     XJTYPE        VTYPE
     C                   Z-ADD     XJSORD        VSORD
     C                   MOVEL     XVNAM1        VNAM1
     C                   MOVEL     XVADR1        VADR1
     C                   MOVEL     XVADR2        VADR2
     C                   MOVEL     XVADR3        VADR3
     C                   MOVEL     XVPCDE        VPCDE
     C                   MOVEL     XVDIN1        VDIN1
     C                   MOVEL     XVDIN2        VDIN2
     C                   MOVEL     XVDIN3        VDIN3
     C                   MOVEL     *BLANKS       VDELT
      *
      * Program mode - Entry
     C     YMODE         IFEQ      'E'
      *
      * Write order delivery details record.
     C                   WRITE     HSFODEL
     C                   ENDIF
      *
      * Program mode - Maintenance, or Dispatch
     C     YMODE         IFEQ      'M'
     C     YMODE         OREQ      'D'
      *
      * Update order delivery details record.
     C     *IN99         IFEQ      *OFF
     C                   UPDATE    HSFODEL
     C                   ENDIF
     C                   ENDIF
      *
     C                   ENDSR
      *----------------------------------------------------------------
      * Create inventory sales transaction.
      *----------------------------------------------------------------
     C     UPINVT        BEGSR
      *
      * Write fields for inventory sales transaction record.
     C                   MOVEL     XJCOMP        CCOMP
     C                   MOVEL     XJWHSE        CWHSE
     C                   MOVEL     XKPROD        CPROD
     C                   MOVEL     *BLANKS       CSUBCF
     C                   MOVEL     *BLANKS       CSUBCT
     C                   MOVEL     *BLANKS       CVTYP
     C                   MOVEL     XKSERC        CSERC
     C                   Z-ADD     XKSERF        CSERNF
     C                   Z-ADD     0             CELEMF
     C                   Z-ADD     XKSERT        CSERNT
     C                   Z-ADD     0             CELEMT
     C                   Z-ADD     XKQTYN        CQTYN
     C                   Z-ADD     0             CBATC
BL   C                   MOVEL(P)  XJSORD        CDELN
     C                   MOVEL     *BLANKS       CREAS
     C                   Z-ADD     CYMD          CTDAT
BL   C                   MOVEL     MTTYP         CTYPE
     C                   MOVEL     *BLANKS       CSUPP
     C                   MOVEL     XJCUST        CCUST
     C                   MOVEL     *BLANKS       CAREA
     C                   MOVEL     *BLANKS       CAISL
     C                   MOVEL     *BLANKS       CBAYR
     C                   MOVEL     *BLANKS       CLEVL
     C                   MOVEL     *BLANKS       CINVN
     C                   Z-ADD     CYMD          CCRTD
     C                   Z-ADD     XXTME         CCRTT
     C                   MOVEL     XJOBNO        CCRTS
     C                   MOVEL     XUSRID        CCRTU
     C                   MOVEL     XPGMID        CCRTP
     C                   MOVEL     *BLANK        CDELT
      *
      * Write inventory sales transaction record.
     C                   WRITE     HSFINVT
     C                   ENDSR
      *
      *----------------------------------------------------------------
      * VALIDH - Validate header screen.
      *----------------------------------------------------------------
      *
     C     VALIDH        BEGSR
      *
      * Screen Header validation:
      *
      * Reset work values.
     C                   RESET                   XERROR
     C                   MOVE      *OFF          *IN61                          Hide F10/F11
      *
      * Reset error indicators.
     C                   MOVEA     XZEROS        *IN(30)
      *
      * Validate that Order Type is a valid Type.
     C     XJTYPE        CHAIN     HSLORDPA                           99
     C     *IN99         IFEQ      *ON
     C                   MOVE      *ON           *IN30
     C                   MOVE      XYES          XERROR
     C                   MOVEL     'HSV2001'     P0MSID
     C                   EXSR      YSNDMG
     C                   ENDIF
      *
      * Validate that Company is valid.
     C     XJCOMP        IFNE      *BLANKS
     C     XJCOMP        CHAIN     HSLCOMPA                           99
     C     *IN99         IFEQ      *ON
     C                   MOVE      *ON           *IN31
     C                   MOVE      XYES          XERROR
     C                   MOVEL     'HSV2002'     P0MSID
     C                   EXSR      YSNDMG
     C                   ENDIF
     C                   ENDIF
      *
      * Validate that Warehouse is valid.
     C     XJWHSE        IFNE      *BLANKS
     C     XJWHSE        CHAIN     HSLWHSEA                           99
     C     *IN99         IFEQ      *ON
     C                   MOVE      *ON           *IN32
     C                   MOVE      XYES          XERROR
     C                   MOVEL     'HSV0006'     P0MSID
     C                   EXSR      YSNDMG
     C                   ENDIF
     C                   ENDIF
      *
      * Validate Post Code
XXX  C     XJCUST        IFEQ      *BLANKS
     C     XJPCDE        IFNE      *BLANKS
     C     XJPCDE        CHAIN     HSLCUSTB                           99
     C     *IN99         IFEQ      *ON
     C                   MOVE      *ON           *IN33
     C                   MOVE      XYES          XERROR
     C                   MOVEL     'HSV2003'     P0MSID
     C                   EXSR      YSNDMG
     C                   ENDIF
      *
      * If Customer is found
     C     *IN99         IFEQ      *OFF
      * ...load Customer record into screen fields.
XXXM C                   MOVEL     ENAM1         XJNAM1                         Name 1
XXXM C                   MOVEL     ENAM2         XJNAM2                         Name 2
XXXM C                   MOVEL     EADR1         XJADR1                         Address 1
XXXM C                   MOVEL     EADR2         XJADR2                         Address 2
XXXM C                   MOVE      ECUST         XJCUST                         Cust No.
XXX  C                   MOVE      ECLIM         XJCLIM           15 0          Credit Limit
XXX  C                   MOVE      ETYSL         XJTYSL           20 5          Last Year Sales
XXX  C                   ENDIF
      *
     C                   ENDIF
     C                   ENDIF
      *
      * Validate Customer Number
XXXD C*          #JCUST    IFNE *BLANKS
     C     XJCUST        CHAIN     HSLCUSTA                           99
     C     *IN99         IFEQ      *ON
     C                   MOVE      *ON           *IN34
     C                   MOVE      XYES          XERROR
     C                   MOVEL     'HSV2004'     P0MSID
     C                   EXSR      YSNDMG
     C                   ENDIF
      *
      * If Customer is found
     C     *IN99         IFEQ      *OFF
      * ...load Customer record into screen fields.
XXXM C                   MOVEL     ENAM1         XJNAM1                         Name 1
XXXM C                   MOVEL     ENAM2         XJNAM2                         Name 2
XXXM C                   MOVEL     EADR1         XJADR1                         Address 1
XXXM C                   MOVEL     EADR2         XJADR2                         Address 2
XXXM C                   MOVE      EPCDE         XJPCDE                         Post Code
XXX  C                   MOVE      ECLIM         XJCLIM           15 0          Credit Limit
XXX  C                   MOVE      ETYSL         XJTYSL           20 5          Last Year Sales
XXX   *
XXX   * Check customer's credit rating allows order entry......
XXX  C     ECRAT         IFEQ      '01 '
XXX  C                   MOVE      *ON           *IN34
XXX  C                   MOVE      XYES          XERROR
XXX  C                   MOVEL     'HSV2018'     P0MSID
XXX  C                   EXSR      YSNDMG
XXX  C                   ENDIF
      *
     C                   ENDIF
XXXD C*                    ENDIF
      *
      * Maximum discount is 40%
     C     XJDISP        IFGT      40
     C                   MOVE      *ON           *IN36
     C                   MOVE      XYES          XERROR
     C                   MOVEL     'HSV0142'     P0MSID
     C                   EXSR      YSNDMG
     C                   ENDIF
      *
      * Check order date
     C     XJORDD        IFEQ      0
     C                   EXSR      YDATEC
     C                   ELSE
      *
      * a) Check for leap year and adjust number of days in February
      *    in Days in Month array.
     C     JYY           DIV       4             REM               4 0
     C     REM           IFEQ      0
     C                   MOVEL     'Y'           LEAP              1
     C                   ELSE
     C                   MOVEL     ' '           LEAP
     C                   ENDIF
     C                   SELECT
     C     LEAP          WHENEQ    ' '
     C                   MOVEA     28            DIM(2)
     C     LEAP          WHENEQ    'Y'
     C                   MOVEA     29            DIM(2)
     C                   ENDSL
      * Day
     C     JDD           IFGT      31
     C     JDD           ORLT      01
      * Month
     C     JMM           ORGT      12
     C     JMM           ORLT      01
      *
      * If date error found...
     C                   MOVE      *ON           *IN35
     C                   MOVE      XYES          XERROR
     C                   MOVEL     'HSV2005'     P0MSID
     C                   EXSR      YSNDMG
     C                   ENDIF
      *
      * Validate Day within month.
     C                   Z-ADD     JMM           M                 2 0
     C     JDD           IFLT      1
     C     JMM           ORGE      1
     C     JMM           ANDLE     12
     C     JDD           ANDGT     DIM(M)
      *
      * If date error found...
     C                   MOVE      *ON           *IN35
     C                   MOVE      XYES          XERROR
     C                   MOVEL     'HSV2005'     P0MSID
     C                   EXSR      YSNDMG
     C                   ENDIF
     C                   ENDIF
      *
      * If no errors found...
     C     XERROR        IFEQ      XNO
      * ...display "Data valid.Press F10 to update" message...
     C                   MOVEL     'HSV9006'     P0MSID
     C                   EXSR      YSNDMG
      * ...activate F10 key (*IN61=*ON).
     C                   MOVE      *ON           *IN61
     C                   ENDIF
      *
     C                   ENDSR
      *
      *----------------------------------------------------------------
      * @DATEC - Date Check Routine
      *----------------------------------------------------------------
      *
     C     YDATEC        BEGSR
      *
      * Convert six-digit system date to eight digits, with century.
     C                   MOVEL     UDAY          DD
     C                   MOVEL     UMONTH        MM
     C                   MOVEL     UYEAR         YY
     C     YY            IFGT      80
     C                   Z-ADD     19            CC
     C                   ELSE
     C                   Z-ADD     20            CC
     C                   ENDIF
     C                   MOVEL     CC            CCYY              4 0
     C                   MOVE      YY            CCYY
      *
      * Set default date for order entry.
     C     XJORDD        IFEQ      0
     C                   Z-ADD     DMCY          XJORDD
     C                   ENDIF
      *
      * Set date for transaction audit field.
     C                   Z-ADD     DD            DDD
     C                   Z-ADD     MM            MMM
     C                   Z-ADD     CC            CCC
     C                   Z-ADD     YY            YYY
     C                   ENDSR
      *
      *----------------------------------------------------------------
      * @SERCH - F4 prompt control.
      *----------------------------------------------------------------
      *
     C     YSERCH        BEGSR
      *
      * Check that cursor is in a valid field for prompting.
     C     CSRRCD        IFEQ      'HSS200A'
     C     CSRFLD        ANDEQ     'XJCUST'
     C     CSRRCD        OREQ      'HSS200A'
     C     CSRFLD        ANDEQ     'XJTYPE'
     C     CSRRCD        OREQ      'HSS200A'
     C     CSRFLD        ANDEQ     'XJCOMP'
     C     CSRRCD        OREQ      'HSS200A'
     C     CSRFLD        ANDEQ     'XJWHSE'
     C     CSRRCD        OREQ      'HSS200A'
     C     CSRFLD        ANDEQ     'XJPCDE'
     C     CSRRCD        OREQ      'HSS200C'
     C     CSRFLD        ANDEQ     'XKPROD'
      *
      * Move appropriate data to parameter fields depending upon search
      * field chosen.
     C                   SELECT
      *
      * Customer No.
     C     CSRFLD        WHENEQ    'XJCUST'
     C                   MOVEL(P)  'HSLCUSTA'    FILEY
     C                   MOVEL(P)  'ENAM1'       NAMEY
     C                   MOVEL(P)  'ECUST'       NUMBRY
      *
      * Post Code
     C     CSRFLD        WHENEQ    'XJPCDE'
     C                   MOVEL(P)  'HSLCUSTB'    FILEY
     C                   MOVEL(P)  'ENAM1'       NAMEY
     C                   MOVEL(P)  'EPCDE'       NUMBRY
      *
      * Order Type.
     C     CSRFLD        WHENEQ    'XJTYPE'
     C                   MOVEL(P)  'HSLORDPA'    FILEY
     C                   MOVEL(P)  'MODES'       NAMEY
     C                   MOVEL(P)  'MOTYP'       NUMBRY
      *
      * Company Code
     C     CSRFLD        WHENEQ    'XJCOMP'
     C                   MOVEL(P)  'HSLCOMPA'    FILEY
     C                   MOVEL(P)  'WODES'       NAMEY
     C                   MOVEL(P)  'WCOMP'       NUMBRY
      *
      * Warehouse Code
     C     CSRFLD        WHENEQ    'XJWHSE'
     C                   MOVEL(P)  'HSLWHSEA'    FILEY
     C                   MOVEL(P)  'PODES'       NAMEY
     C                   MOVEL(P)  'PWHSE'       NUMBRY
      *
      * Product Code
     C     CSRFLD        WHENEQ    'XKPROD'
     C                   MOVEL(P)  'HSLPRODA'    FILEY
     C                   MOVEL(P)  'NDESC'       NAMEY
     C                   MOVEL(P)  'NPROD'       NUMBRY
      *
     C                   ENDSL
      *
      * Call system window program to retrieve data.  If Return Code is
      * *OFF then load retrieved data into screen fields.
     C                   Z-ADD     10            LINY
     C                   Z-ADD     8             COLY
     C                   CALL      'HSR341'      PL341
      *
      * If Return Code is *OFF then load retrieved data into
      * appropriate screen fields.
     C     YRTNC         IFEQ      *OFF                                         ..If2
      *
     C                   SELECT
      *
      * Customer No.
     C     CSRFLD        WHENEQ    'XJCUST'
     C                   MOVEL(P)  YNUMBR        XJCUST
      *
      * Post Code
     C     CSRFLD        WHENEQ    'XJPCDE'
     C                   MOVEL(P)  YNUMBR        XJPCDE
      *
      * Customer Type.
     C     CSRFLD        WHENEQ    'XJTYPE'
     C                   MOVEL(P)  YNUMBR        XJTYPE
      *
      * Company Code
     C     CSRFLD        WHENEQ    'XJCOMP'
     C                   MOVEL(P)  YNUMBR        XJCOMP
      *
      * Warehouse Code
     C     CSRFLD        WHENEQ    'XJWHSE'
     C                   MOVEL(P)  YNUMBR        XJWHSE
      *
      * Product Code
     C     CSRFLD        WHENEQ    'XKPROD'
     C                   MOVEL(P)  YNUMBR        XKPROD
      *
     C                   ENDSL
     C                   ENDIF                                                  ..EndIf2
      *
      * otherwise cursor is in wrong format/field so display message.
     C                   ELSE                                                   .ElseIf1
     C                   MOVEL     'HSV9009'     P0MSID
     C                   EXSR      YSNDMG
     C                   ENDIF                                                  .EndIf1
      *
     C                   ENDSR
      *
      *----------------------------------------------------------------
      * @SERSF - F4 prompt control for order detail subfile.
      *----------------------------------------------------------------
      *
     C     YSERSF        BEGSR
      * Clear row / column control.
     C                   Z-ADD     0             CSRROW
     C                   Z-ADD     0             CSRCOL
      *
      * Retrieve the current cursor position.
     C     CSRLOC        DIV       256           ROW               2 0
     C                   MVR                     COL               2 0
     C                   Z-ADD     ROW           CSRROW
     C                   Z-ADD     COL           CSRCOL
      *
      * Execute search.
     C                   EXSR      YSERCH
      *
      * Flag subfile record to return value.
     C     CSRRRN        CHAIN     HSS200C                            99
     C     *IN99         IFEQ      *OFF
     C                   MOVEL     *ON           *IN37
XXX  C     YNUMBR        IFNE      *BLANKS
     C                   MOVEL(P)  YNUMBR        XKPROD
XXX  C                   ENDIF
     C                   UPDATE    HSS200C
     C                   MOVEL     *OFF          *IN37
     C                   ENDIF
     C                   ENDSR
      *
      *----------------------------------------------------------------
      * @SNDMG - Send message to this program's MSGQ.
      *----------------------------------------------------------------
      *
     C     YSNDMG        BEGSR
      *
     C                   CALL      'SNDMSGC'
     C                   PARM                    P0PGMQ                         Program queue
     C                   PARM                    P0PGRL                         Rel queue
     C                   PARM                    P0MSID                         Message ID
     C                   PARM                    P0MSGF                         Message file
     C                   PARM                    P0MSDA                         Message data
     C                   PARM                    P0MSTP                         Message type
      *
     C                   ENDSR
      *
      *----------------------------------------------------------------
      * @CLRMG - Clear message(s) from this program's MSGQ.
      *----------------------------------------------------------------
      *
     C     YCLRMG        BEGSR
      *
     C                   CALL      'RMVMSGC'
      *
     C                   ENDSR
      *
      *----------------------------------------------------------------
      * *UPPVCT- Update the voucher control
      *----------------------------------------------------------------
      *
     C     UPPVCT        BEGSR
     C                   Z-ADD     1             RRNQ
     C     RRNQ          CHAIN     HSS200C                            97
     C     *IN97         DOWEQ     *OFF
      *
     C                   ADD       1             RRNQ
     C     XSELC         IFNE      *BLANK
     C     XKPROD        ORNE      *BLANK
     C     XNDESC        ORNE      *BLANK
     C     XKPRIC        ORNE      *ZEROS
     C     XKQTYN        ORNE      *ZEROS
     C     XKVALU        ORNE      *ZEROS
     C     XKVATA        ORNE      *ZEROS
     C     XKSERC        ORNE      *BLANKS
     C     XKSERF        ORNE      *ZEROS
     C     XKSERT        ORNE      *ZEROS
     C                   MOVE      XKSERC        WKSERC
     C                   MOVE      XKSERT        TEMP              9 0
     C                   ADD       1             TEMP
     C     VCHKEY        SETLL     HSLVCTLA
     C     XKPROD        READE     HSLVCTLA                               92
     C                   MOVE      TEMP          BSERNN
     C                   UPDATE    HSFVCTL
     C                   ENDIF
      *
     C     RRNQ          IFEQ      100
     C                   LEAVE
     C                   ENDIF
     C     RRNQ          CHAIN     HSS200C                            97
     C                   ENDDO
     C                   ENDSR
      *
      *----------------------------------------------------------------
      * *INZSR - Initialization.
      *----------------------------------------------------------------
      *
     C     *INZSR        BEGSR
BL    *
BL    * Dummy read to open file.
BL   C                   READ      HSPINVT                                99
BL   C                   UPDATE    HSFINVT
     C                   OPEN      HSLEXPAA
BL   C                   READ      HSLEXPAA                               99
     C                   CLOSE     HSLEXPAA
      *
      * Key lists.
      * Key List for Voucher Control.
     C     VCHKEY        KLIST
     C                   KFLD                    XKPROD
     C                   KFLD                    WKSERC
      *
      * Key List for Voucher Cross-Reference.
     C     KEYXRF        KLIST
     C                   KFLD                    CCYY
     C                   KFLD                    XJCUST
     C                   KFLD                    XKPROD
      *
      * Key List for Sales Order.
     C     KEYOLN        KLIST
     C                   KFLD                    XJSORD
     C                   KFLD                    XOLIN
      *
      * Key List for Inventory Masterfile.
     C     IVMKEY        KLIST
     C                   KFLD                    XKPROD
     C                   KFLD                    WKSUBC
     C                   MOVE      *BLANKS       WKSUBC
      *
      * Key List for Voucher Tracking.
     C     TRCKEY        KLIST
     C                   KFLD                    XKPROD
     C                   KFLD                    XKSERC
     C                   KFLD                    XKSERF
      *
      * Key List for Customer Discount File.
     C     DSCKEY        KLIST
     C                   KFLD                    ECTYP
     C                   KFLD                    PFAMT
      *
      * Parameter Lists.
      * Entry parameter list.
     C     *ENTRY        PLIST
     C                   PARM                    YMODE             1            Mode
     C                   PARM                    YORDNO            8            Sales Order No.
     C                   PARM                    YTYPE             3            Order Type
     C                   PARM                    YCUST             8            Customer No.
      *
      * List for Call to HSR341 - Search program.
     C     PL341         PLIST
     C                   PARM                    YRTNC             1
     C                   PARM                    YNUMBR           15
     C                   PARM                    FILEY            10
     C                   PARM                    NAMEY             6
     C                   PARM                    NUMBRY            6
     C                   PARM                    LINY              3 0
     C                   PARM                    COLY              3 0
      *
      * Field definitions
     C     *LIKE         DEFINE    XKVALU        WKTOTV
     C     *LIKE         DEFINE    XKSERC        WKSERC
     C     *LIKE         DEFINE    BSERNN        WKSERN
     C     *LIKE         DEFINE    XKQTYN        WKQTYN
     C     *LIKE         DEFINE    DSUBC         WKSUBC
     C     *LIKE         DEFINE    XNO           WKRANG
     C     *LIKE         DEFINE    XNO           WKVCTL
     C     *LIKE         DEFINE    XNO           UPDAT
      *
      * Variable declarations.
     C                   MOVE      '0'           XNO               1
     C                   MOVE      '1'           XYES              1
     C                   MOVE      XNO           XERROR            1
     C                   MOVE      XNO           XUPDAT            1
     C                   MOVE      XNO           XDELET            1
BL   C                   MOVEL     *BLANKS       ORDPRM            8
     C                   Z-ADD     1             RCDNBR
     C                   Z-ADD     0             RRNX              5 0
     C                   Z-ADD     0             RRNVAL            5 0
     C                   Z-ADD     0             RRNLIN            5 0
     C                   Z-ADD     0             RRNQ              5 0
     C                   Z-ADD     0             RRNP              5 0
      *
      * Prepare message subfile.
     C                   MOVE      *ON           *IN79
     C                   MOVE      XPGMID        P0PGMQ           10            Program queu
     C                   MOVEL     '*PRV'        P0PGRL            5            Rel queue
     C                   MOVE      *BLANKS       P0MSID            7            Message ID
     C                   MOVEL     'HSM001'      P0MSGF           10            Message file
     C                   MOVE      *BLANKS       P0MSDA          132            Message data
     C                   MOVEL     '*INFO'       P0MSTP            7            Message type
      *
     C                   EXSR      YDATEC
      *
     C                   ENDSR
** Days in Month array DIM.
312831303130313130313031
