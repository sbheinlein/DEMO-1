     H
     H*------------------------------------------------------------------------
     H* Test procedures for 2 Pck
     H*------------------------------------------------------------------------
     D* Prototype for called procedures
     D/COPY SMK21M2_P
     D
     D* Parameters
     D e_Action        s              1a
     D e_Pck1          s             30p 9
     D e_Pck2          s             30p 9
     D e_PckRet        s             30p 9
     D*--------
     D*
     C*
     C     *ENTRY        PLIST
     C                   Parm                    e_Action                          1=Min: 2=Max
     C                   Parm                    e_Pck1
     C                   Parm                    e_Pck2
     C                   Parm                    e_PckRet
     C*
     C                   Select
     C*
     C*-- Min
     C                   When      e_Action = '1'
     C                   Eval      e_PckRet = Get_PckMin(
     C                             e_Pck1:e_Pck2)
     C*-- Max
     C                   When      e_Action = '2'
     C                   Eval      e_PckRet = Get_PckMax(
     C                             e_Pck1:e_Pck2)
     C*
     C                   Endsl
     C*
     C                   Eval      *INLR = '1'
     C                   Return
     C*---------------------------------------
