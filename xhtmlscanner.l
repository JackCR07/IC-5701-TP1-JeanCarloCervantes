/* 
 * Instituto Tecnológico de Costa Rica
 * Escuela de Computación
 * Curso de Compiladores e Interpretes
 * Profesor Andrei Fuentes
 * Estudiante: Jean Carlo Cervantes
 * Tarea Programada #1
 */
 


 /* Definiciones */
alpha  	[a-zA-Z]
 
 
/* Reglas */
%%
[aA]		printf("4");
[bB]		printf("8");
[cC]		printf("<");
[dD]		printf(")");
[eE]		printf("3");
[fF]		printf("|=");
[gG]		printf("6");
[hH]		printf("#");
[iI]		printf("1");
[jJ]		printf("_|");
[kK]		printf("|<");
[lL]		printf("|_");
[mM]		printf("[]V[]");
[nN]		printf("|-_|");
[ñÑ]            
[oO]		printf("0");
[pP]		printf("|D");
[qQ]		printf("(,)");
[rR]		printf("|2");
[sS]		printf("5");
[tT]		printf("7");
[uU]		printf("µ");
[vV]		printf("√");
[wW]		printf("|_|_/");
[xX]		printf("><");
[yY]		printf("`/");
[zZ]		printf("2");
^alpha		printf(yytext);
\n		printf("\n");
%%



int main()
{
  yylex();
  return 0;
}
