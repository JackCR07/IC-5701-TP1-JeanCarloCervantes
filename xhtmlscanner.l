/* 
 * Instituto Tecnológico de Costa Rica
 * Escuela de Computación
 * Curso de Compiladores e Interpretes
 * Profesor Andrei Fuentes
 * Estudiante: Jean Carlo Cervantes
 * Tarea Programada #1
 */
 
%{
	#include "scanner.h"
	int i = 0;
	int chars = 1;
	int lines = 1;
%}


 /* Definiciones */


/* Reglas */
%%

[<][!][-][-]([^-]|[-]+[^>])*[-][-][>] 	{ i=0; while(i<strlen(yytext)){if (yytext[i]=='\n'){ lines++; chars=0; };chars++; i++;};printf("lineas:%d y chars=;%d",lines,chars); }
[\n]       						{ lines++; chars = 1; }
\"(\\.|[^\\"])*\" 				{ printf("STRING(%s) \n", yytext); chars+=strlen(yytext); }
\'([^\']|\\.)?\'				{ printf("CHARACTER(%s) \n", yytext); chars+=strlen(yytext); }
[ \t\v\f]      					{ chars += strlen(yytext); }
. 								{ printf("ERROR: ROW: %d, COLUMN:%d\n", lines, chars); chars++; }

%%



int main()
{
  yylex();
  return 0;
}
