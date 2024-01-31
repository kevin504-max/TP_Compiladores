%{
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

extern FILE *yyin;
extern int yylex();
void yyerror(const char *s);

char* next_temp(){
    static int temp_count=0;
    char*temp_name=(char*)malloc(8);
    snprintf(temp_name,8,"_temp %d",temp_count);
    temp_count++;
    return temp_name;
}

typedef struct {
    char op;
    char *arg1;
    char *arg2;
    char *result;
} quadrupla;


%}

// Definições dos tokens
%token INT ID IF ELSE WHILE DO FOR
%token MAIS MENOS VEZES DIV LPAREN RPAREN LBRACE RBRACE PONTOEVIRGULA
%token NUM NAO E OU IGUAL DIFERENTE MENOR MENORIGUAL MAIORIGUAL MAIOR

// Definição das associações
%left MAIS MENOS
%left VEZES DIV
%right IGUAL

%%

// Regra para inicialização de variáveis
inicializa: INT ID {  $$ = $1 };

// Regras para expressões matemáticas
expressao:
    LPAREN expressao RPAREN
    | inicializa IGUAL expressao // atribuição
    {
        $$ = next_temp();
        gerar('=', $1.str, $3.str, $$);
    }
    | ID IGUAL expressao // Expressão de adição
    {
        $$ = next_temp();
        gerar('=', $1.str, $3.str, $$);
    }
    | termo MAIS expressao // Expressão de adição
    {
        $$ = next_temp();
        gerar('+', $1.str, $3.str, $$);
    }
    | termo MENOS expressao // Expressão de adição
    {
        $$ = next_temp();
        gerar('-', $1.str, $3.str, $$);
    }
    ;

termo: 
    fator // Termo em parênteses
    | fator VEZES termo // Termo multiplicado por fator
    {
        $$ = next_temp();
        gerar('*', $1.str, $3.str, $$);
    }
    | fator DIV termo // Termo dividido por fator
    {
        $$ = next_temp();
        gerar('/', $1.str, $3.str, $$);
    }
    ;

fator: 
    NUM // Número
    {
        $$ = next_temp();
        gerar('=', $1.num, '_', $$);
    }
    | ID // Identificador (variável)
    {
        $$ = $1.str;
    }
    ;

// Regras para operações de comparação e lógica
comparacao: 
    expressao // Comparação simples
    | comparacao E comparacao // Expressão lógica AND
    {
        $$ = next_temp();
        gerar('&&', $1.str, $3.str, $$);
    }
    | comparacao OU comparacao // Expressão lógica OR
    {
        $$ = next_temp();
        gerar('||', $1.str, $3.str, $$);
    }
    | NAO LPAREN comparacao RPAREN // Expressão lógica NOT
    {
        $$ = next_temp();
        gerar('!', $3.str, '_', $$);
    }
    | comparacao IGUAL comparacao // Expressão de igualdade
    {
        $$ = next_temp();
        gerar('==', $1.str, $3.str, $$);
    }
    | comparacao DIFERENTE comparacao // Expressão de diferença
    {
        $$ = next_temp();
        gerar('!=', $1.str, $3.str, $$);
    }
    | comparacao MENOR comparacao // Expressão de menor que
    {
        $$ = next_temp();
        gerar('<', $1.str, $3.str, $$);
    }
    | comparacao MENORIGUAL comparacao // Expressão de menor ou igual
    {
        $$ = next_temp();
        gerar('<=', $1.str, $3.str, $$);
    }
    | comparacao MAIOR comparacao // Expressão de maior que
    {
        $$ = next_temp();
        gerar('>', $1.str, $3.str, $$);
    }
    | comparacao MAIORIGUAL comparacao // Expressão de maior ou igual
    {
        $$ = next_temp();
        gerar('>=', $1.str, $3.str, $$);
    }
    ;

// Regras para declarações
declaracao:
    expressao PONTOEVIRGULA
    | expressao PONTOEVIRGULA declaracao // Declaração de expressão simples seguida de ponto e vírgula
    | IF LPAREN comparacao RPAREN LBRACE declaracao RBRACE // Declaração IF
    | IF LPAREN comparacao RPAREN LBRACE declaracao RBRACE ELSE LBRACE declaracao RBRACE // Declaração IF-ELSE
    | WHILE LPAREN comparacao RPAREN LBRACE declaracao RBRACE // Declaração WHILE
    | DO LBRACE declaracao RBRACE WHILE LPAREN comparacao RPAREN PONTOEVIRGULA // Loop DO-WHILE
    | FOR LPAREN expressao PONTOEVIRGULA comparacao PONTOEVIRGULA expressao RPAREN LBRACE declaracao RBRACE // Loop FOR
    ;

%%

void yyerror(const char *s) {
    fprintf(stderr, "Erro: %s", s);
}

int main(int argc, char *argv[]) {

    FILE *input_file = fopen("./teste1.txt", "r");

    puts(input_file);

    fclose(input_file);

    system("PAUSE");

    return 0;
}
