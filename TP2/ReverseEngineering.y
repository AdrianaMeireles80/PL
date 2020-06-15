%{
#include <stdio.h>
#include <string.h>

extern int yylex();
extern int yylineno;
extern char *yytext;
int yyerror();
int erroSem(char*);
char* aux;

%}

%union{
    char* sbase;
    char* spal;

}

%token ERRO  START PALING PALPORT BASE 

%type<sbase> Base BASE Pota
%type<spal>  Palavras PALPORT PALING PalPort PalIng ListaBase 



%%

Dicionario : START  ListaPalavras
           ;

ListaPalavras : ListaPalavras Palavras 
              | ListaPalavras Base 
              | Palavras 
              | Base    
              ;

Base :  Pota ListaBase  
                             

ListaBase : ListaBase PalIng PalPort  { if(($2)[0] == '-')
                                          printf("\nEN %s %s\n+base %s\nPT %s\n", $2,aux,aux, $3);

                                        else if(($2)[strlen($2)-1] == '-'){
                                          ($2)[strlen($2)-1] = '\0';
                                          printf("\nEN %s %s\n+base %s\nPT %s\n", $2,aux,aux, $3);
                                        }
                                       }
          |
          ;

Palavras :  PalIng  PalPort {printf("\nEN %s\nPT %s\n\n", $1, $2);}
         ;

PalPort : PALPORT
        ;

PalIng :  PALING  
       ;

Pota : BASE { aux = strdup($1); };

%%
int main(){
    yyparse();
    return 0;
}

int erroSem(char *s){
    printf("Erro Semântico na linha: %d, %s...\n", yylineno, s);
    
}

int yyerror(){
    printf("Erro Sintático ou Léxico na linha: %d, com o texto: %s\n", yylineno, yytext);
    
}
