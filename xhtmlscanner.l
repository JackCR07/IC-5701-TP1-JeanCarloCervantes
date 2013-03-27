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
"acronym"|"address"|"basefont"|"blockquote"|"caption"|"colgroup"|"fieldset"|"frameset"|"isindex"|"noframes"|"noscript"|"optgroup"|"textarea"|"applet"|"button"|"center"|"iframe"|"legend"|"object"|"option"|"script"|"select"|"strike"|"strong"|"frame"|"input"|"label"|"param"|"style"|"table"|"tbody"|"tfoot"|"thead"|"title"|"abbr"|"area"|"base"|"body"|"cite"|"code"|"font"|"form"|"head"|"html"|"link"|"menu"|"meta"|"samp"|"small"|"span"|"bdo"|"big"|"col"|"del"|"dfn"|"dir"|"div"|"img"|"ins"|"kbd"|"map"|"pre"|"sub"|"sup"|"var"|"br"|"dd"|"dl"|"dt"|"em"|"h1"|"h2"|"h3"|"h4"|"h5"|"h6"|"hr"|"li"|"ol"|"td"|"th"|"tr"|"tt"|"ul"|"a"|"b"|"i"|"p"|"q"|"s"|"u"				{chars+=strlen(yytext); yylval.stringConstant=strdup(yytext);return T_Elements;}
\"(\\.|[^\\"])*\" 				{ chars+=strlen(yytext); yylval.stringConstant=strdup(yytext);return T_Values; }
\'([^\']|\\.)?\'				{ printf("CHARACTER(%s) \n", yytext); chars+=strlen(yytext); }
[ \t\v\f]      					{ chars += strlen(yytext); }
. 								{ printf("ERROR: ROW: %d, COLUMN:%d\n", lines, chars); chars++; }

%%




static void PrintOneToken(TokenType token, const char *text, YYSTYPE value)
{
      char buffer[] = {'\'', token, '\'', '\0'};
      const char *name = token >= T_OpenSign ? gTokenNames[token - T_OpenSign] : buffer;
  

  

      printf("(name= %s , value = %s)\n", name, value.stringConstant); 
 
}

int main()
{

    TokenType token;
    while ((token = (TokenType)yylex()) != 0) 
        PrintOneToken(token, yytext, yylval);
}
