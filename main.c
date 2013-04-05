/* Archivo main.c
 */

#include <stdio.h>
#include "scanner.h"

/* Function: PrintOneToken()
 * Usage: PrintOneToken(T_Double, "3.5", val, loc);
 * -----------------------------------------------
 * We supply this function to print information about the tokens returned
 * by the lexer as part of pp1.  Do not modifiy it.
 */

static void PrintOneToken(TokenType token, const char *text, YYSTYPE value)
{
      char buffer[] = {'\'', token, '\'', '\0'};
      const char *name = token >= T_OpenSign ? gTokenNames[token - T_OpenSign] : buffer;
      if(token==T_Elements || token==T_Atributtes || token==T_Values || token==T_Text)
       printf("(name= %s , value = %s)\n", name, value.stringConstant);
      else
       printf("(name= %s)\n", name);
 
}

int main()
{

    TokenType token;
    OpenErrorFile();
    while ((token = (TokenType)yylex()) != 0) 
        PrintOneToken(token, yytext, yylval);
    CloseErrorFile();
}
