     H*------------------------------------------------------------------------
     H* Test Pck procedures en 15,5
     H*------------------------------------------------------------------------
     D* Parameters
     D e_Action        s              1a
     D e_PckNbr        s              5p 0
     D e_Pck1          s             15p 5
     D e_Pck2          s             15p 5
     D e_Pck3          s             15p 5
     D e_Pck4          s             15p 5
     D e_PckRet        s             15p 5
     D*--------
     D wPck1           s             30p 9
     D wPck2           s             30p 9
     D wPck3           s             30p 9
     D wPck4           s             30p 9
     D wPckRet         s             30p 9
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
     C                   Eval      wPck1 = e_Pck1
     C                   Eval      wPck2 = e_Pck2
     C                   Eval      wPck3 = e_Pck3
     C                   Eval      wPck4 = e_Pck4
     C*
     C                   Call      'SMK42G1'
     C                   Parm                    e_Action
     C                   Parm                    e_PckNbr
     C                   Parm                    wPck1
     C                   Parm                    wPck2
     C                   Parm                    wPck3
     C                   Parm                    wPck4
     C                   Parm                    wPckRet
     C*
     C                   Eval      e_PckRet = wPckRet
     C*
     C                   Eval      *INLR = '1'
     C                   Return
     C*---------------------------------------
