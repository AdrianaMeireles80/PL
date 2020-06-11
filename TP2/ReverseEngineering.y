%{
#include <stdio.h>
#include <string.h>

extern int yylex();
extern int yylineno;
extern char *yytext;
int yyerror();
int erroSem(char*);
%}

%union{
    char* sbase;
    char* spal;
 
}
%token ERRO  START 
%token<spal> PALING 
%token<sbase> BASE
%type<sbase> Base
%type<spal> PalIng


%%

Dicionario : START  ListaPalIng 
            ;

ListaPalIng : ListaPalIng PalIng 
            | ListaPalIng Base  
            | PalIng    
            | Base   
            ;

Base : BASE PalIng  
     ;

PalIng : PALING  
       ;



%%
int main(){
    yyparse();
    return 0;
}

int erroSem(char *s){
    printf("Erro Semântico na linha: %d, %s...\n", yylineno, s);
    return 0;
}

int yyerror(){
    printf("Erro Sintático ou Léxico na linha: %d, com o texto: %s\n", yylineno, yytext);
    return 0;
}