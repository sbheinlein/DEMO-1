      *------------------------------------------------------------------------
      * Procedures to handle  "Pck" values
      *------------------------------------------------------------------------
     H NoMain
     D* Prototype for exported procedures
     D/COPY SMK21M2_P
     P*------------------------------------------------------------------------
     P* Get_PckMin : get the minimum value from 2,3 or 4 Pck
     P*
     P*------------------------------------------------------------------------
     P Get_PckMin      B                   Export
     P*
     D Get_PckMin      Pi            30p 9
     D e_Pck1                        30p 9 Value
     D e_Pck2                        30p 9 Value
     D e_Pck3                        30p 9 Value
     D                                     Options(*Nopass)
     D e_Pck4                        30p 9 Value
     D                                     Options(*Nopass)
 
     D*--------
     D wPck            s             30p 9
     D*
     C*
     C                   Eval      wPck = e_Pck1
     C*
     C                   if        e_Pck2 < wPck
     C                   eval      wPck = e_Pck2
     C                   endif
     C*
     C                   if        %Parms >= 3
     C                             and e_Pck3 < wPck
     C                   eval      wPck = e_Pck3
     C                   endif
     C*
     C                   if        %Parms >= 4
     C                             and e_Pck4 < wPck
     C                   eval      wPck = e_Pck4
     C                   endif
     C*
     C                   return    WPck
     P Get_PckMin      E
     P*------------------------------------------------------------------------
     P* Get_PckMax : get the maximum value from 2,3 or 4 Pck
     P*------------------------------------------------------------------------
     P Get_PckMax      B                   Export
     P*
     D Get_PckMax      Pi            30p 9
     D e_Pck1                        30p 9 Value
     D e_Pck2                        30p 9 Value
     D e_Pck3                        30p 9 Value
     D                                     Options(*Nopass)
     D e_Pck4                        30p 9 Value
     D                                     Options(*Nopass)
 
     D*--------
     D wPck            s             30p 9
     D*
     C*
     C                   Eval      wPck = e_Pck1
     C*
     C                   if        e_Pck2 > wPck
     C                   eval      wPck = e_Pck2
     C                   endif
     C*
     C                   if        %Parms >= 3
     C                             and e_Pck3 > wPck
     C                   eval      wPck = e_Pck3
     C                   endif
     C*  Here's an error on the next test !
     C                   if        %Parms >= 4
     C                             and e_Pck4 < wPck
     C                   eval      wPck = e_Pck4
     C                   endif
     C*
     C                   return    WPck
     P Get_PckMax      E
 
