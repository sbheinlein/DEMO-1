     H
     H*------------------------------------------------------------------------
     H* Test procedures for 3 int
     H*------------------------------------------------------------------------
     D* Prototype for this module
     D/COPY SMK41M3_P
     D* Prototype for called procedures
     D/COPY SMK21M1_P
     D*
     D* Parameters interface for this module
     D MOD_SMK41M3     Pi
     D* 1=Min, 2=Max
     D e_Action                       1a
     D e_Int1                        10i 0
     D e_Int2                        10i 0
     D e_Int3                        10i 0
     D e_IntRet                      10i 0
     D*--------
     D*
     C*
     C                   Select
     C*
     C*-- Min
     C                   When      e_Action = '1'
     C                   Eval      e_IntRet = Get_IntMin(
     C                             e_Int1:e_Int2:e_Int3)
     C*-- Max
     C                   When      e_Action = '2'
     C                   Eval      e_IntRet = Get_IntMax(
     C                             e_Int1:e_Int2:e_Int3)
     C*
     C                   Endsl
     C*
     C                   Eval      *INLR = '1'
     C                   Return
     C*---------------------------------------
