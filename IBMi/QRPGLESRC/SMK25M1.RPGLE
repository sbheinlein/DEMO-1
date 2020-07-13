     H*------------------------------------------------------------------------
     H* Procedures for UpperCase/LowerCase Strings
     H*------------------------------------------------------------------------
     H NoMain
     D* Prototype for exported procedures
     D/COPY SMK25M1_P
     D*
     D Lower           C                   CONST('abcdefghijklmnopqrst-
     D                                     uvwxyz')
     D Upper           C                   CONST('ABCDEFGHIJKLMNOPQRST-
     D                                     UVWXYZ')
     P*------------------------------------------------------------------------
     P* Str_ToUpper : Convert a string to Uppercase
     P*     (max length = 100 char)
     P*------------------------------------------------------------------------
     P Str_ToUpper     B                   Export
     P*
     D Str_ToUpper     Pi           100A
     D e_String                     100a   Const
     D*--------
     D wString         s            100a
     D*
     C*
     C     Lower:Upper   Xlate     e_String      wString
     C*
     C                   Return    wString
     P Str_ToUpper     E
     P*------------------------------------------------------------------------
     P*------------------------------------------------------------------------
     P* Str_ToLower : Convert a string to Uppercase
     P*     (max length = 100 char)
     P*------------------------------------------------------------------------
     P Str_ToLower     B                   Export
     P*
     D Str_ToLower     Pi           100A
     D e_String                     100a   Const
     D*--------
     D wString         s            100a
     D*
     C*
     C     Upper:Lower   Xlate     e_String      wString
     C*
     C                   Return    wString
     P Str_ToLower     E
 
     P*------------------------------------------------------------------------
     P* Str_isUpper : Check whether a String is only in UpperCase
     P*------------------------------------------------------------------------
     P Str_isUpper     B                   Export
     P*
     D Str_isUpper     Pi             1N
     D e_String                     100a   Const
     D*--------
     D*
     C* Test if the string does not change when it is converted to Upper
     C                   if        e_String = Str_ToUpper(e_String)
     C                   return    *On
     C                   else
     C                   return    *Off
     C                   endif
     C*
     P Str_isUpper     E
     P*------------------------------------------------------------------------
     P* Str_isLower : Check whether a String is only in UpperCase
     P*------------------------------------------------------------------------
     P Str_isLower     B                   Export
     P*
     D Str_isLower     Pi             1N
     D e_String                     100a   Const
     D*--------
     D*
     C* Test if the string does not change when it is converted to Upper
     C                   if        e_String = Str_ToLower(e_String)
     C                   return    *On
     C                   else
     C                   return    *Off
     C                   endif
     C*
     P Str_isLower     E
     P*------------------------------------------------------------------------
