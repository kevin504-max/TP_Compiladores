%{
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include "muxtela.tab.h" // Inclusão do arquivo de cabeçalho gerado pelo Bison

extern FILE *yyin;
extern int quad_count;
extern char* temp();
%}

%%

"if"        { printf("Palavra chave 'if'\n"); return IF; }
"else"      { printf("Palavra chave 'else'\n"); return ELSE; }
"while"     { printf("Palavra chave 'while'\n"); return WHILE; }
"do"        { printf("Palavra chave 'do'\n"); return DO; }
"for"       { printf("Palavra chave 'for'\n"); return FOR; }
"int"       { printf("Palavra chave 'int'\n"); return INT; }
"+"         { printf("Operador de adicao\n"); return ADICAO; }
"-"         { printf("Operador de subtracao\n"); return SUBTRACAO; }
"*"         { printf("Operador de multiplicacao\n"); return MULTIPLICACAO; }
"/"         { printf("Operador de divisao\n"); return DIVISAO; }
"<"         { printf("Sinal de maior\n"); return MENOR; }
"<="        { printf("Sinal de maior igual\n"); return MENORIGUAL; }
">="        { printf("Sinal de menor igual\n"); return MAIORIGUAL; }
">"         { printf("Sinal de menor\n"); return MAIOR; }
"=="        { printf("Sinal de igual\n"); return IGUAL; }
"!="        { printf("Sinal de diferenca\n"); return DIFERENCA; }
"!"         { printf("Sinal de negacao\n"); return NEGACAO; }
"("         { printf("Parentese de abertura\n"); return LPAREN; }
")"         { printf("Parentese de fechamento\n"); return RPAREN; }
"{"         { printf("Chave de abertura\n"); return LBRACE; }
"}"         { printf("Chave de fechamento\n"); return RBRACE; }
";"         { printf("Ponto e virgula\n"); return PONTOEVIRGULA; }

[0-9]+      { printf("Num\n");yylval = atoi(yytext); return NUM; }
[a-zA-Z][a-zA-Z0-9]* { printf("Var\n");yylval = strdup(yytext); return ID; }

[ \t\n]     ; 

.           { fprintf(stderr, "Caractere não reconhecido: %s\n", yytext); }
%%

int yywrap(){
	return 1;
}