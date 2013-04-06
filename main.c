/* 
 * Instituto Tecnológico de Costa Rica
 * Escuela de Computación
 * Curso de Compiladores e Interpretes
 * Profesor Andrei Fuentes
 * Estudiante: Jean Carlo Cervantes
 * Tarea Programada #1
 * Archivo: main
 */


#include <stdio.h>
#include "scanner.h"

/* La funcion PrintToken recibe el tipo de token, el yytext
 * y el valor que se almacena en yylval, y la salida que es
 * el nombre del token y el valor de ser necesario de la 
 * funcion es por el stdout.
 */

static void PrintToken(TokenType token, const char *text, YYSTYPE value)
{
      char buffer[] = {'\'', token, '\'', '\0'};
      const char *name = token >= T_OpenSign ? gTokenNames[token - T_OpenSign] : buffer;
      if(token==T_Elements || token==T_Atributtes || token==T_Values || token==T_Text)
       printf("(name= %s , value = %s)\n", name, value.stringConstant);
      else
       printf("(name= %s)\n", name);
 
}

/* El main solo define las variables necesarias para la funcion
 * PrintToken, crea el archivo de errores y por medio del loop 
 * se toma cada token y su salida es por el stdout si no hay errores
 * o por stderr si los hay.
*/
int main()
{

    TokenType token;
    OpenErrorFile();
    while ((token = (TokenType)yylex()) != 0) 
        PrintToken(token, yytext, yylval);
    CloseErrorFile();
    return 0;
}
