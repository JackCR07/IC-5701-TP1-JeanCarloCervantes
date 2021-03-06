/* 
 * Instituto Tecnológico de Costa Rica
 * Escuela de Computación
 * Curso de Compiladores e Interpretes
 * Profesor Andrei Fuentes
 * Estudiante: Jean Carlo Cervantes
 * Tarea Programada #1
 * Archivo: flex
 */
 
%{
	#include "scanner.h"
	YYSTYPE yylval; 
        FILE * ErrorFile;
	int chars = 1;
	int lines = 1;
%}


 /* Definiciones */

Elemento	"acronym"|"address"|"basefont"|"blockquote"|"caption"|"colgroup"|"fieldset"|"frameset"|"isindex"|"noframes"|"noscript"|"optgroup"|"textarea"|"applet"|"button"|"center"|"iframe"|"legend"|"object"|"option"|"script"|"select"|"strike"|"strong"|"frame"|"input"|"label"|"param"|"style"|"table"|"tbody"|"tfoot"|"thead"|"title"|"abbr"|"area"|"base"|"body"|"cite"|"code"|"font"|"form"|"head"|"html"|"link"|"menu"|"meta"|"samp"|"small"|"span"|"bdo"|"big"|"col"|"del"|"dfn"|"dir"|"div"|"img"|"ins"|"kbd"|"map"|"pre"|"sub"|"sup"|"var"|"br"|"dd"|"dl"|"dt"|"em"|"h1"|"h2"|"h3"|"h4"|"h5"|"h6"|"hr"|"li"|"ol"|"td"|"th"|"tr"|"tt"|"ul"|"a"|"b"|"i"|"p"|"q"|"s"|"u"
Atributo	"accept-charset"|"xmlns"|"accept"|"accesskey"|"action"|"align"|"alink"|"archive"|"background"|"bgcolor"|"border"|"cellpadding"|"charoff"|"charset"|"checked"|"classid"|"clear"|"codebase"|"codetype"|"color"|"colspan"|"compact"|"content"|"coords"|"datetime"|"declare"|"defer"|"disabled"|"enctype"|"encoding"|"frameborder"|"headers"|"height"|"hreflang"|"hspace"|"http-equiv"|"ismap"|"label"|"language"|"longdesc"|"marginheight"|"marginwidth"|"maxlength"|"media"|"method"|"multiple"|"nohref"|"noresize"|"noshade"|"nowrap"|"object"|"onblur"|"onchange"|"onclick"|"ondblclick"|"onfocus"|"onkeydown"|"onkeypress"|"onkeyup"|"onload"|"onmousedown"|"onmousemove"|"onmouseout"|"onmouseover"|"onmouseup"|"onreset"|"onselect"|"onsubmit"|"onunload"|"profile"|"prompt"|"readonly"|"rowspan"|"rules"|"scheme"|"scope"|"scrolling"|"selected"|"shape"|"standby"|"start"|"style"|"summary"|"tabindex"|"target"|"title"|"type"|"usemap"|"valign"|"value"|"valuetype"|"version"|"vlink"|"vspace"|"width"|"frame"|"class"|"abbr"|"axis"|"char"|"cite"|"code"|"cols"|"data"|"face"|"href"|"lang"|"link"|"name"|"rows"|"size"|"span"|"text"|"src"|"alt"|"dir"|"for"|"rel"|"rev"|"id" 

/* Definicion de inicio de condiciones para el procesamiento de comentarios */
%x comment
%x single_line_comment

/* Reglas */
%%

"<"						{chars+=strlen(yytext); return T_OpenSign;}
">"						{chars+=strlen(yytext); return T_CloseSign;}
"-"						{chars+=strlen(yytext); return T_Minus;}
"="						{chars+=strlen(yytext); return T_Equal;}
":"						{chars+=strlen(yytext); return T_Colon;}
"/"						{chars+=strlen(yytext); return T_Slash;}
"?"						{chars+=strlen(yytext); return T_QuestionMark;}
"!"						{chars+=strlen(yytext); return T_ExclamationMark;}
"PUBLIC"					{chars+=strlen(yytext); return T_PublicIdentifier;}
"DOCTYPE"					{chars+=strlen(yytext); return T_DOCTYPE;}
{Elemento}					{chars+=strlen(yytext); yylval.stringConstant=strdup(yytext);return T_Elements;}
{Atributo}					{chars+=strlen(yytext); yylval.stringConstant=strdup(yytext);return T_Atributtes;}
"xml"						{chars+=strlen(yytext); return T_XML;}
\"(\\.|[^\\"])*\" 				{ chars+=strlen(yytext); yylval.stringConstant=strdup(yytext);return T_Values; }
"<!--"            				BEGIN(comment);
"//"            				BEGIN(single_line_comment);
[a-zA-Z0-9]+[a-zA-Z0-9]*    			{chars+=strlen(yytext); yylval.stringConstant=strdup(yytext);return T_Text;}
[+\-*\%;,.(){}\[\]_]				{chars+=strlen(yytext); yylval.stringConstant=strdup(yytext);return T_Text;}
<comment>[^-\n]*         		{} 
<comment>"-"+[^->\n]*    		{} 
<comment>\n              		{++lines;}
<comment>"--"+">"         		{BEGIN(INITIAL);}
<comment><<EOF>>        		{fprintf (ErrorFile,"ERROR: Unterminated comment ROW: %d", --lines);yyterminate();}
<single_line_comment>.   		{}
<single_line_comment>\n  		{++lines;BEGIN(INITIAL);}
[ \t\v\f]      					{ chars += strlen(yytext); }
[\n]       						{ lines++; chars = 1; }
. 								{ fprintf (ErrorFile,"ERROR: ROW: %d, COLUMN:%d\n", lines, chars); chars++; }

%%

void OpenErrorFile(){
 
	ErrorFile = fopen ("Errorfile.txt","w");
}

void CloseErrorFile(){
fclose(ErrorFile);
}
