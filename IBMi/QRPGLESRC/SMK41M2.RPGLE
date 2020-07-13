     H
     H*------------------------------------------------------------------------
     H* Test procedures for 2 int
     H*------------------------------------------------------------------------
     D* Prototype for called procedures
     D/COPY SMK21M1_P
     D
     D* Parameters
     D e_Action        s              1a
     D e_Int1          s             10i 0
     D e_Int2          s             10i 0
     D e_IntRet        s             10i 0
     D*--------
     D*
     C*
     C     *ENTRY        PLIST
     C                   Parm                    e_Action                          1=Min: 2=Max
     C                   Parm                    e_Int1
     C                   Parm                    e_Int2
     C                   Parm                    e_IntRet
     C*
     C                   Select
     C*
     C*-- Min
     C                   When      e_Action = '1'
     C                   Eval      e_IntRet = Get_IntMin(
     C                             e_Int1:e_Int2)
     C*-- Max
     C                   When      e_Action = '2'
     C                   Eval      e_IntRet = Get_IntMax(
     C                             e_Int1:e_Int2)
     C*
     C                   Endsl
     C*
     C                   Eval      *INLR = '1'
     C                   Return
     C*---------------------------------------
