%{
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include "parser.tab.h" // Inclua o header gerado pelo Bison
 
extern FILE *yyin;
extern int quad_count;
extern char* temp();
%}

%%

"if"        { return IF; }
"else"     { return ELSE; }
"while"  { return WHILE; }
"do"       { return DO; }
"for"      { return FOR; }
"int"       { return INT; }

"+"         { return MAIS; }
"-"         { return MENOS; }
"*"         { return VEZES; }
"/"         { return DIV; }
"<"         { return MENOR; }
"<="        { return MENORIGUAL; }
">="        { return MAIORIGUAL; }
">"         { return MAIOR; }
"=="        { return IGUAL; }
"!="        { return DIFERENTE; }
"!"         { return NAO; }
"("         { return LPAREN; }
")"         { return RPAREN; }
"{"         { return LBRACE; }
"}"         { return RBRACE; }
";"         { return PONTOEVIRGULA; }

[0-9]+      { yylval = atoi(yytext); return NUM; }
[a-zA-Z][a-zA-Z0-9]* { yylval = strdup(yytext); return ID; }

[ \t\n]     ; 

.           { fprintf(stderr, "Caractere não reconhecido: %s\n", yytext); }
%%

int yywrap(){
	return 1;
}