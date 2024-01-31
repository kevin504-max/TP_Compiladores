%{
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

extern FILE *yyin;
extern int yylex();
void yyerror(const char *s);

char* nextBuffer(){
    static int countBuffer = 0;
    char *nameBuffer = (char*)malloc(8);

    snprintf(nameBuffer, 8, "_temp %d", countBuffer);
    countBuffer++;
    
    return nameBuffer;
}

typedef struct {
    char op;
    char *arg1;
    char *arg2;
    char *result;
} quadrupla;


%}

// Definindo os tokens do analisador léxico
%token INT ID IF ELSE WHILE DO FOR
%token ADICAO SUBTRACAO MULTIPLICACAO DIVISAO LPAREN RPAREN LBRACE RBRACE PONTOEVIRGULA
%token NUM NEGACAO E OU IGUAL DIFERENCA MENOR MENORIGUAL MAIORIGUAL MAIOR

// Definindo os tipos de dados
%left ADICAO SUBTRACAO
%left MULTIPLICACAO DIVISAO
%right IGUAL

%%

// Regras para declarações de variáveis
inicializa: INT ID {  $$ = $1 };

// Regras para expressões aritméticas
expressao:
    LPAREN expressao RPAREN
    | inicializa IGUAL expressao
    {
        $$ = nextBuffer();
        gerar('=', $1.str, $3.str, $$);
    }
    | ID IGUAL expressao // Expressão de atribuição
    {
        $$ = nextBuffer();
        gerar('=', $1.str, $3.str, $$);
    }
    | termo ADICAO expressao // Expressão de adição
    {
        $$ = nextBuffer();
        gerar('+', $1.str, $3.str, $$);
    }
    | termo SUBTRACAO expressao // Expressão de subtração
    {
        $$ = nextBuffer();
        gerar('-', $1.str, $3.str, $$);
    }
    ;

termo: 
    fator // Fator simples (número ou variável)
    | fator MULTIPLICACAO termo // Expressão de multiplicação entre fatores
    {
        $$ = nextBuffer();
        gerar('*', $1.str, $3.str, $$);
    }
    | fator DIVISAO termo // Expressão de divisão entre fatores
    {
        $$ = nextBuffer();
        gerar('/', $1.str, $3.str, $$);
    }
    ;

fator: 
    NUM // Número inteiro (constante)
    {
        $$ = nextBuffer();
        gerar('=', $1.num, '_', $$);
    }
    | ID // Variável (identificador)
    {
        $$ = $1.str;
    }
    ;

// Regras para expressões lógicas
comparacao: 
    expressao // Comparação simples
    | comparacao E comparacao // Expressão lógica AND
    {
        $$ = nextBuffer();
        gerar('&&', $1.str, $3.str, $$);
    }
    | comparacao OU comparacao // Expressão lógica OR
    {
        $$ = nextBuffer();
        gerar('||', $1.str, $3.str, $$);
    }
    | NEGACAO LPAREN comparacao RPAREN // Expressão lógica NOT
    {
        $$ = nextBuffer();
        gerar('!', $3.str, '_', $$);
    }
    | comparacao IGUAL comparacao // Expressão de igualdade
    {
        $$ = nextBuffer();
        gerar('==', $1.str, $3.str, $$);
    }
    | comparacao DIFERENCA comparacao // Expressão de diferença
    {
        $$ = nextBuffer();
        gerar('!=', $1.str, $3.str, $$);
    }
    | comparacao MENOR comparacao // Expressão de menor
    {
        $$ = nextBuffer();
        gerar('<', $1.str, $3.str, $$);
    }
    | comparacao MENORIGUAL comparacao // Expressão de menor ou igual
    {
        $$ = nextBuffer();
        gerar('<=', $1.str, $3.str, $$);
    }
    | comparacao MAIOR comparacao // Expressão de maior
    {
        $$ = nextBuffer();
        gerar('>', $1.str, $3.str, $$);
    }
    | comparacao MAIORIGUAL comparacao // Expressão de maior ou igual
    {
        $$ = nextBuffer();
        gerar('>=', $1.str, $3.str, $$);
    }
    ;

// Regras para declarações
declaracao:
    expressao PONTOEVIRGULA
    | expressao PONTOEVIRGULA declaracao // Declaração de expressão simples seguida de ponto e vírgula
    | IF LPAREN comparacao RPAREN LBRACE declaracao RBRACE // Declaração IF
    | IF LPAREN comparacao RPAREN LBRACE declaracao RBRACE ELSE LBRACE declaracao RBRACE // Declaração IF-ELSE
    | WHILE LPAREN comparacao RPAREN LBRACE declaracao RBRACE // Loop WHILE
    | DO LBRACE declaracao RBRACE WHILE LPAREN comparacao RPAREN PONTOEVIRGULA // Loop DO-WHILE
    | FOR LPAREN expressao PONTOEVIRGULA comparacao PONTOEVIRGULA expressao RPAREN LBRACE declaracao RBRACE // Loop FOR
    ;

%%

void yyerror(const char *s) {
    fprintf(stderr, "Erro: %s", s);
}

int main(int argc, char *argv[]) {

    FILE *input_file = fopen("teste1.txt", "r");

      if (!input_file) {
        system("PAUSE");
        perror("Erro ao abrir o arquivo");
        return 1;
    }

    yyin = input_file;

    yyparse(); 

    puts(input_file);

    fclose(input_file);

    system("PAUSE");

    return 0;
}
