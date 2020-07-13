      *------------------------------------------------------------------------
      * Prototype for Procedures for scan in Strings
      *------------------------------------------------------------------------
     D*------------------------------------------------------------------------
     D* Str_ScanNonSensitive : Non sensitive scan for a string in another string
     D*  Return Value : '0' = not Found, '1'=Found
     D* Param. 1 : String in which to scan
     D* Param. 2 : String to scan for
     D* Param. 3 : length of string to scan for
     D* Param. 4 (Omissible) : If found : return the first position of the
     D*                            string
     D*------------------------------------------------------------------------
     P*
     D Str_ScanNonSensitive...
     D                 Pr             1N
     D e_String1                    100a   Const
     D e_String2                    100a   Const
     D e_String2Len                  10i 0 Const
     D e_FirstPosit                  10i 0 Options(*Omit)
     D*--------
 
