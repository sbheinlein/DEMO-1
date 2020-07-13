      *------------------------------------------------------------------------
      * Procedures for scan in Strings
      *------------------------------------------------------------------------
     H NoMain
     D* Prototype for exported procedures
     D/COPY SMK18M1_P
     D* Prototype for imported procedures
     D/COPY SMK25M1_P
     D*
     H*------------------------------------------------------------------------
     H* Str_ScanNonSensitive : Non sensitive scan for a string in another string
     H*  Return Value : '0' = not Found, '1'=Found
     H* Param. 1 : String in which to scan
     H* Param. 2 : String to scan for
     H* Param. 3 : length of string to scan for
     H* Param. 4 (Omissible) : If found : return the first position of the
     H*                            string
     H*------------------------------------------------------------------------
     P Str_ScanNonSensitive...
     P                 B                   Export
     P*
     D Str_ScanNonSensitive...
     D                 Pi             1N
     D e_String1                    100a   Const
     D e_String2                    100a   Const
     D e_String2Len                  10i 0 Const
     D e_FirstPosit                  10i 0 Options(*Omit)
     D*--------
     D wString1        s            100a
     D wString2        s            100a
     D wLen            s             10i 0
     D wPos            s             10i 0
     D*
     C* Convert the two strings to Upper
     C                   Eval      wString1 = Str_ToUpper(e_String1)
     C                   Eval      wString2 = Str_ToUpper(e_String2)
     C* scan
     C                   Eval      WLen = e_String2Len
     C     wString2:wLen Scan      wString1      wPos
     C* found
     C                   if        %Found
     C                   if        %Addr(e_FirstPosit) <> *null
     C                   Eval      e_FirstPosit = wPos
     C                   Endif
     C                   Return    '1'
     C* not found
     C                   Else
     C                   if        %Addr(e_FirstPosit) <> *null
     C                   Eval      e_FirstPosit = 0
     C                   Endif
     C                   Return    '0'
     C                   Endif
     C*
     P Str_ScanNonSensitive...
     P                 E
