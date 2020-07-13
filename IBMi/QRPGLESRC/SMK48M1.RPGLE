     H*------------------------------------------------------------------------
     H* Test call to Proc for System Value
     H*------------------------------------------------------------------------
     D* Prototype for imported procedures
     D/COPY SMK28X1_P
     D*--------
     C*
     C     *ENTRY        PLIST
     C                   Parm                    e_SysValNam      10
     C                   Parm                    e_Value        5000
     C*
     C*
     C                   Callp     SMK28X1(e_SysValNam:e_Value)
     C                   Eval      *INLR = '1'
     C                   Return
     C*---------------------------------------
