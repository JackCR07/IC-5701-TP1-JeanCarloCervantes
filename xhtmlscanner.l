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
	YYSTYPE yylval; 
	int i = 0;
	int chars = 1;
	int lines = 1;
%}


 /* Definiciones */


/* Reglas */
%%

[<][!][-][-]([^-]|[-]+[^>])*[-][-][>] 	{ i=0; while(i<strlen(yytext)){if (yytext[i]=='\n'){ lines++; chars=0; };chars++; i++;};printf("lineas:%d y chars=%d",lines,chars); }
[\n]       						{ lines++; chars = 1; }
"<"						{chars+=strlen(yytext); return T_OpenSign;}
">"						{chars+=strlen(yytext); return T_CloseSign;}
"a"|"abbr"|"acronym"|"address"|"applet"|"area"|"b"|"base"|"basefont"|"bdo"|"big"|"blockquote"|"body"|"br"|"button"|"caption"|"center"|"cite"|"code"|"col"|"colgroup"|"dd"|"del"|"dfn"|"dir"|"div"|"dl"|"dt"|"em"|"fieldset"|"font"|"form"|"frame"|"frameset"|"h1"|"h2"|"h3"|"h4"|"h5"|"h6"|"head"|"hr"|"html"|"i"|"iframe"|"img"|"input"|"ins"|"isindex"|"kbd"|"label"|"legend"|"li"|"link"|"map"|"menu"|"meta"|"noframes"|"noscript"|"object"|"ol"|"optgroup"|"option"|"p"|"param"|"pre"|"q"|"s"|"samp"|"script"|"select"|"small"|"span"|"strike"|"strong"|"style"|"sub"|"sup"|"table"|"tbody"|"td"|"textarea"|"tfoot"|"th"|"thead"|"title"|"tr"|"tt"|"u"|"ul"|"var"				{chars+=strlen(yytext); yylval.stringConstant=strdup(yytext);return T_Elements;}
\"(\\.|[^\\"])*\" 				{ printf("STRING(%s) \n", yytext); chars+=strlen(yytext); }
\'([^\']|\\.)?\'				{ printf("CHARACTER(%s) \n", yytext); chars+=strlen(yytext); }
[ \t\v\f]      					{ chars += strlen(yytext); }
. 								{ printf("ERROR: ROW: %d, COLUMN:%d\n", lines, chars); chars++; }

%%




static void PrintOneToken(TokenType token, const char *text, YYSTYPE value)
{
  

  

      printf("(value = %s)\n", value.stringConstant); 
 
}

int main(int argc, char *argv[])
{

    TokenType token;
    while ((token = (TokenType)yylex()) != 0) 
        PrintOneToken(token, yytext, yylval);
}
