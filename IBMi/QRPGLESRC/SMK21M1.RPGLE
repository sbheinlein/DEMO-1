      *------------------------------------------------------------------------
      * Procedures to handle  "int" values
      *------------------------------------------------------------------------
     H NoMain
     D* Prototype for exported procedures
     D/COPY SMK21M1_P
     P*------------------------------------------------------------------------
     P* Get_IntMin : get the minimum value from 2,3 or 4 int
     P*
     P*------------------------------------------------------------------------
     P Get_IntMin      B                   Export
     P*
     D Get_IntMin      Pi            10i 0
     D e_Int1                        10i 0 Value
     D e_Int2                        10i 0 Value
     D e_Int3                        10i 0 Value
     D                                     Options(*Nopass)
     D e_Int4                        10i 0 Value
     D                                     Options(*Nopass)
 
     D*--------
     D wInt            s             10i 0
     D*
     C*
     C                   Eval      wInt = e_Int1
     C*
     C                   if        e_Int2 < wInt
     C                   eval      wInt = e_Int2
     C                   endif
     C*
     C                   if        %Parms >= 3
     C                             and e_Int3 < wInt
     C                   eval      wInt = e_Int3
     C                   endif
     C*
     C                   if        %Parms >= 4
     C                             and e_Int4 < wInt
     C                   eval      wInt = e_Int4
     C                   endif
     C*
     C                   return    WInt
     P Get_IntMin      E
     P*------------------------------------------------------------------------
     P* Get_IntMax : get the maximum value from 2,3 or 4 int
     P*------------------------------------------------------------------------
     P Get_IntMax      B                   Export
     P*
     D Get_IntMax      Pi            10i 0
     D e_Int1                        10i 0 Value
     D e_Int2                        10i 0 Value
     D e_Int3                        10i 0 Value
     D                                     Options(*Nopass)
     D e_Int4                        10i 0 Value
     D                                     Options(*Nopass)
 
     D*--------
     D wInt            s             10i 0
     D*
     C*
     C                   Eval      wInt = e_Int1
     C*
     C                   if        e_Int2 > wInt
     C                   eval      wInt = e_Int2
     C                   endif
     C*
     C                   if        %Parms >= 3
     C                             and e_Int3 > wInt
     C                   eval      wInt = e_Int3
     C                   endif
     C*
     C                   if        %Parms >= 4
     C                             and e_Int4 > wInt
     C                   eval      wInt = e_Int4
     C                   endif
     C*
     C                   return    WInt
     P Get_IntMax      E
 
     P*------------------------------------------------------------------------
     P* Anz_IntTab : Analyze a table of int values
     P*  and return the minimal value and the average value
     P*
     P*------------------------------------------------------------------------
     P Anz_IntTab      B                   Export
     P*
     D Anz_IntTab      Pi
     D* in : Pointer to the address of a table of int :
     D e_pIntTab                       *   Value
     D* in : Number of element in the table :
     D e_nbElt                        5i 0 Value
     D* out : Return the minimum value :
     D e_Min                         10i 0
     D* out : Return the average with 2 decimals
     D e_Average                     12p 2
     D*--------
     D* Table based on the address of input table of int
     D wIntTab         s             10i 0 Dim(5000) Based(e_pIntTab)
     D*
     D Ix              s             10i 0
     D wSum            s             10i 0
     D wSum2           s             12p 2
     D*
     C*--------------
     C* Calculate the minimum value
     C*--------------
     C*     using Get_IntMin (funny method, just for the sample !)
     C*
     C                   Eval      Ix=1
     C                   Eval      e_Min=*hival
     C*
     C                   Dow       Ix <= e_NbElt
     C*
     C                   Select
     C*
     C                   When      Ix + 2 <= e_NbElt
     C                   Eval      e_Min=Get_IntMin(
     C                             e_Min:
     C                             wIntTab(Ix):
     C                             wIntTab(Ix+1):
     C                             wIntTab(Ix+2)  )
     C*
     C                   When      Ix + 1 = e_NbElt
     C                   Eval      e_Min=Get_IntMin(
     C                             e_Min:
     C                             wIntTab(Ix):
     C                             wIntTab(Ix+1) )
     C*
     C                   When      Ix  = e_NbElt
     C                   Eval      e_Min=Get_IntMin(e_Min:wIntTab(Ix))
     C                   Endsl
     C
     C                   Eval      Ix = Ix + 3
     C                   Enddo
     C*--------------
     C* Calculate the average
     C*--------------
     C*
     C                   Eval      WSum = 0
     C*
     C                   for       Ix = 1 to e_NbElt
     C                   Eval      WSum = WSum + wIntTab(Ix)
     C                   endfor
     C*
     C                   Eval      wSum2 = wSum
     C                   Eval(h)   e_Average = wSum2 / e_NbElt
     C* Exit
     C                   return
     P Anz_IntTab      E
 
 
