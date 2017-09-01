/********************************************************************/
/*                                                                  */
/* 5769SS1 V4R4M0 990521     Sortie RTVCLSRC     16/02/00 16:19:54  */
/*               test                                               */
/*                                                                ED*/
/********************************************************************/
     PGM
     OVRDBF FILE(HSLINVTA) SHARE(*YES)
     CALL PGM(HSR701)
     CPYFRMQRYF FROMOPNID(HSLINVTA) TOFILE(*PRINT)
     RETURN
     ENDPGM
