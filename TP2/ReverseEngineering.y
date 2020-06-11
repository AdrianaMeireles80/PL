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
%token<spal> PALPORT
%token<sbase> BASE
%type<sbase> Base
%type<spal> PalIng
%type<spal> PalPort



%%

Dicionario : START  ListaPalIng 
            ;

ListaPalIng : ListaPalIng PalIng 
            | ListaPalIng Base  
            | PalIng    
            | Base   
            ;

Base : BASE PalIng  {printf("+base %s\n", $$);}
     ;

PalIng : PALING  PalPort {printf("EN %s\n", $$);}
       ;

PalPort : PALPORT {printf("PT %s\n", $$);}
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