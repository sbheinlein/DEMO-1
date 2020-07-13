     H
     H*------------------------------------------------------------------------
     H* Test string procedures
     H*------------------------------------------------------------------------
     D* Prototype for imported procedures
     D/COPY SMK25M1_P
     D/COPY SMK18M1_P
     D*
     D* Prototypes for internal procedures
     P*
     D Test_ToUpperLower...
     D                 Pr           100a
     D
     D                                1A   Value
     D                              100A   Value
     D*--------
     D* Global variable
     D* Parameters
     D e_Action        s              1a
     D e_Str1          s            100a
     D e_Str2          s            100a
     D e_RetNbr        s             10i 0
     D e_RetInd        s              1N
     D*  WStr (not used)
     D WStr            s            200a
     D*--------
     D*
     C*
     C*
     C     *ENTRY        PLIST
     C                   Parm                    e_Action                        L/U /  T /S
     C                   Parm                    e_Str1
     C                   Parm                    e_Str2
     C                   Parm                    e_RetNbr
     C                   Parm                    e_RetInd
     C*
     C                   Eval      e_RetNbr = 0
     C                   Eval      e_Retind = '0'
     C*
     C                   Select
     C*
     C*-- 'L' or 'U' --> Test of Proc. ToLower or ToUpper
     C                   When      e_Action = 'L' or e_Action = 'U'
     C                   Eval      e_Str2 = Test_ToUpperLower(
     C                             e_Action :
     C                             e_Str1)
     C*
     C*-- 'T' --> Test of the case of Str1
     C                   When      e_Action = 'T'
     C                   Exsr      SrTestTest
     C*
     C*-- 'S' --> Test of Str_ScanNonSensitive
     C                   When      e_Action = 'S'
     C                   Eval      e_RetInd =
     C                             Str_ScanNonSensitive(
     C                             e_Str1:
     C                             e_Str2:
     C                             %Len(%Trim(e_Str2)):
     C                             e_RetNbr)
     C                   Endsl
     C*
     C                   Eval      *INLR = '1'
     C                   Return
     C*---------------------------------------
     C*  Test the case of the string
     C     SrTestTest    Begsr
     C                   Select
     C                   When      Str_isUpper(e_Str1) = '1'
     C                   Eval      e_Str2 = 'All is UpperCase'
     C                   When      Str_isLower(e_Str1)
     C                   Eval      e_Str2 = 'All is LowerCase'
     C                   Other
     C                   Eval      e_Str2 = 'The string is in Mixed Case'
     C                   Endsl
     C                   Endsr
     C*---------------------------------------
     C**************************************************
     C* Test of Proc. Str_ToLower or Str_ToUpper
     C**************************************************
     P Test_ToUpperLower...
     P                 B
     D Test_ToUpperLower...
     D                 Pi           100a
     D e_Act                          1a   Value                                 'U'/'L'
     D e_Str                        100a   Value
     D*--------
     D* Local variable
     D WStr            s            100a
     D*--------
     D*
     C*
     C                   if        e_Act = 'U'
     C                   Exsr      SrTestUpper
     C                   return    WStr
     C                   else
     C                   return    Str_ToLower(e_Str)
     C                   endif
     C*---------------------------------------
     C*  Test the case of the string
     C     SrTestUpper   Begsr
     C                   Eval      WStr = Str_ToUpper(e_Str)
     C                   Endsr
     C*---------------------------------------
     P Test_ToUpperLower...
     P                 E
