/* Header para la declarion de las constantes, 
   variables tipos y funciones que se usan por
   el scanner generado de lex
 */

#ifndef _H_scanner
#define _H_scanner

#include <stdio.h>


  
/* Definicion de las constantes para los diferentes tipos de tokens.
 * Los numeros inician en 256, ya que de 0-255 estan reservados para
 * valores de single character token. 
 */
typedef enum { 
    T_OpenSign = 256,
    T_CloseSign, T_Elements, T_Atributtes, T_Values, T_Text, T_Equal, T_Colon,
    T_Slash, T_QuestionMark, T_PublicIdentifier,
    T_NumTokenTypes
} TokenType;

 
// Lista de los printable names para cada valor del token definido anteriormente.
 
static const char *gTokenNames[T_NumTokenTypes] = {
  "T_OpenSign", "T_CloseSign", "T_Elements", "T_Atributtes", "T_Values", "T_Text", "T_Equal", "T_Colon",
  "T_Slash", "T_QuestionMark", "T_PublicIdentifier"
};

 
/* Definicion del tipo union usado por el scanner para almacenar
 * informacion de los atributos sobre los tokens como van siendo escaneados.
 */
typedef union {
    char *stringConstant;
} YYSTYPE;

 
// yylval contiene informacion del lexema escaneado

extern YYSTYPE yylval;

extern char *yytext;      // Texto del lexema escaneado


int yylex();              // Definido en el archivo lex.yy.c generado


 
#endif
