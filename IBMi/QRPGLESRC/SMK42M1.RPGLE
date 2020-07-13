     H*------------------------------------------------------------------------
     H* Test Pck procedures
     H*------------------------------------------------------------------------
     D* Prototype for called module and program
     D/COPY SMK42M3_P
     D/COPY SMK42R4_P
     D* Parameters
     D e_Action        s              1a
     D e_PckNbr        s              5p 0
     D e_Pck1          s             30p 9
     D e_Pck2          s             30p 9
     D e_Pck3          s             30p 9
     D e_Pck4          s             30p 9
     D e_PckRet        s             30p 9
     D*--------
     D*
     C*
     C     *ENTRY        PLIST
     C                   Parm                    e_Action                       1=Min: 2=Max
     C                   Parm                    e_PckNbr
     C                   Parm                    e_Pck1
     C                   Parm                    e_Pck2
     C                   Parm                    e_Pck3
     C                   Parm                    e_Pck4
     C                   Parm                    e_PckRet
     C*
     C                   Eval      e_PckRet = 0
     C*
     C                   Select
     C*
     C*-- Test with 2 Pck
     C                   When      e_PckNbr = 2
     C                   CallB     'SMK42M2'
     C                   Parm                    e_Action
     C                   Parm                    e_Pck1
     C                   Parm                    e_Pck2
     C                   Parm                    e_PckRet
     C*
     C*-- Test with 3 Pck
     C                   When      e_PckNbr = 3
     C                   Callp     SMK42M3(e_Action:
     C                             e_Pck1:e_Pck2:e_Pck3:e_PckRet)
     C*
     C*-- Test with 4 Pck
     C                   When      e_PckNbr = 4
     C                   Callp     SMK42R4(e_Action:
     C                             e_Pck1:e_Pck2:e_Pck3:e_Pck4:e_PckRet)
     C*
     C                   Endsl
     C*
     C                   Eval      *INLR = '1'
     C                   Return
     C*---------------------------------------
