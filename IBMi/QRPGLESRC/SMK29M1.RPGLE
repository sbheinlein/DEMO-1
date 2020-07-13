     H NoMain
     D* Prototype for exported procedures
     D/COPY SMK29M1_P
     P*------------------------------------------------------------------------
     P* Get_RandInt : get a random integer
     P*------------------------------------------------------------------------
     P Get_RandInt     B                   Export
     P*
     D Get_RandInt     Pi            10i 0
     D  e_IntMax                     10i 0 Value
 
     D*--------
 
     D*  Prototype for IBM C procedures
     Drand             Pr            10I 0 ExtProc('rand')
     D
     Dsrand            Pr                  ExtProc('srand')
     D                               10I 0  Value
     D*-------
     D IntRes          S             10I 0
     D*
     D Timexx          DS
     D Time                            T
     D Time06          S              6S 0
     D Mvr1            S              6S 0
     D*
     D FstCall         S              1A    inz('0') Static
     D
     C*   Init random only at the first time
     C                   If        FstCall  = '0'
     C                   Eval      FstCall  = '1'
     C                   Time                    Time
     C                   Move      Time          Time06
     C                   Div       32768         Time06
     C                   Mvr                     Mvr1
     C                   Callp     srand(Mvr1)
     C                   Endif
     C*   get the next random value
     C                   Eval      IntRes = rand
     C* adjust to max
     C                   If        e_IntMax > 0
     C                   Eval      INTRes = (Intres * e_IntMax) / 32768 + 1
     C                   Endif
     C*
     C                   Return    IntRes
     P Get_RandInt     E
