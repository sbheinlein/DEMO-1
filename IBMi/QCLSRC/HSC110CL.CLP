PGM
             DCL        VAR(&LIB) TYPE(*CHAR) LEN(10) VALUE('TH_SMPL')
             CPYF       FROMFILE(ARTICLE) +
                          TOFILE(&LIB/ARTICLESAV)
             dspmsg
             wrksplf
             /*test*/
ENDPGM
