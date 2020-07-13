      *------------------------------------------------------------------------
      * Protototype of Procedures to handle  "int" values
      *------------------------------------------------------------------------
     D*------------------------------------------------------------------------
     D* Get_IntMin : get the minimum value from 2,3 or 4 int
     D*
     D*------------------------------------------------------------------------
     D Get_IntMin      Pr            10i 0
     D e_Int1                        10i 0 Value
     D e_Int2                        10i 0 Value
     D e_Int3                        10i 0 Value
     D                                     Options(*Nopass)
     D e_Int4                        10i 0 Value
     D                                     Options(*Nopass)
     D*------------------------------------------------------------------------
     D* Get_IntMax : get the maximum value from 2,3 or 4 int
     D*------------------------------------------------------------------------
     D Get_IntMax      Pr            10i 0
     D e_Int1                        10i 0 Value
     D e_Int2                        10i 0 Value
     D e_Int3                        10i 0 Value
     D                                     Options(*Nopass)
     D e_Int4                        10i 0 Value
     D                                     Options(*Nopass)
     D*------------------------------------------------------------------------
     D* Anz_IntTab : Analyze a table of int values
     D*  and return the minimal value and the average value
     D*
     D*------------------------------------------------------------------------
     D Anz_IntTab      Pr
     D* in : Pointer to the address of a table of int :
     D e_pIntTab                       *   Value
     D* in : Number of element in the table :
     D e_nbElt                        5i 0 Value
     D* out : Return the minimum value :
     D e_Min                         10i 0
     D* out : Return the average with 2 decimals
     D e_Average                     12p 2
     D*--------
