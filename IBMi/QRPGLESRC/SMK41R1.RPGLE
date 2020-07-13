     H*------------------------------------------------------------------------
     H* Test int procedures
     H*------------------------------------------------------------------------
     D* Prototype for called module and program
     D/COPY SMK41M3_P
     D/COPY SMK41R4_P
     D* Parameters
     D e_Action        s              1a
     D e_IntNbr        s              5i 0
     D e_Int1          s             10i 0
     D e_Int2          s             10i 0
     D e_Int3          s             10i 0
     D e_Int4          s             10i 0
     D e_IntRet        s             10i 0
     D*--------
     D*
     C*
     C     *ENTRY        PLIST
     C                   Parm                    e_Action                       1=Min: 2=Max
     C                   Parm                    e_IntNbr
     C                   Parm                    e_Int1
     C                   Parm                    e_Int2
     C                   Parm                    e_Int3
     C                   Parm                    e_Int4
     C                   Parm                    e_IntRet
     C*
     C                   Eval      e_IntRet = 0
     C*
     C                   Select
     C*
     C*-- Test with 2 int
     C                   When      e_IntNbr = 2
     C                   CallB     'SMK41M2'
     C                   Parm                    e_Action
     C                   Parm                    e_Int1
     C                   Parm                    e_Int2
     C                   Parm                    e_IntRet
     C*
     C*-- Test with 3 int
     C                   When      e_IntNbr = 3
     C                   Callp     MOD_SMK41M3(e_Action:
     C                             e_Int1:e_Int2:e_Int3:e_IntRet)
     C*
     C*-- Test with 4 int
     C                   When      e_IntNbr = 4
     C                   Callp     PGM_SMK41R4(e_Action:
     C                             e_Int1:e_Int2:e_Int3:e_Int4:e_IntRet)
     C*
     C                   Endsl
     C*
     C                   Eval      *INLR = '1'
     C                   Return
     C*---------------------------------------
