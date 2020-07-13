     H
     H*------------------------------------------------------------------------
     H* Test procedures for 2 int
     H*------------------------------------------------------------------------
     D* Prototype for called procedures
     D/COPY SMK21M1_P
     D
     D* Parameters
     D e_Int1          s             10i 0
     D e_Int2          s             10i 0
     D e_Int3          s             10i 0
     D e_Int4          s             10i 0
     D e_Min           s             10i 0
     D e_Avg           s             12p 2
     D*--------
     D wIntTab         s             10i 0       Dim(4)
     D*--------
     D*
     C*
     C     *ENTRY        PLIST
     C                   Parm                    e_Int1
     C                   Parm                    e_Int2
     C                   Parm                    e_Int3
     C                   Parm                    e_Int4
     C                   Parm                    e_Min
     C                   Parm                    e_Avg
     C*
     C                   Eval      wIntTab(1) = e_Int1
     C                   Eval      wIntTab(2) = e_Int2
     C                   Eval      wIntTab(3) = e_Int3
     C                   Eval      wIntTab(4) = e_Int4
     C*
     C                   Callp     Anz_IntTab(
     C                             %Addr(wIntTab) :
     C                             %Elem(wIntTab) :
     C                             e_Min :
     C                             e_Avg )
     C*
     C                   Eval      *INLR = '1'
     C                   Return
     C*---------------------------------------
