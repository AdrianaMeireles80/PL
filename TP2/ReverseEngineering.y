%{
#include <stdio.h>
#include <string.h>

extern int yylex();
extern int yylineno;
extern char *yytext;
int yyerror();
int erroSem(char*);
int i=1;

%}

%union{
    char* sbase;
    char* spal;


}

%token ERRO  START PALING PALPORT BASE

%type<sbase> Base
%type<spal>  Palvras PALPORT



%%

Dicionario : START  ListaPalavras
            ;

ListaPalavras : ListaPalavras Palvras {i=0;}
              | ListaPalavras Base {i=1;}
              | Palvras {i=0;}
              | Base    {i=1;}
              ;

Base : BASE Palvras { printf("EN %s\n+base %s\n",  $2,$$);}
     ;

Palvras : PALING  PALPORT { if(i==1) { printf("PT %s\n",$2 ); } else printf("EN %s\nPT %s\n",$$, $2 );}
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
