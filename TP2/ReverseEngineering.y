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

%type<sbase> Base BASE
%type<spal>  Palavras PALPORT PALING



%%

Dicionario : START  ListaPalavras
           ;

ListaPalavras : ListaPalavras Palavras {i=0;}
              | ListaPalavras Base {i=1;}
              | Palavras {i=0;}
              | Base    {i=1;}
              ;

Base : BASE Palavras {
                  
                    
                    if(($2)[0] == '-')
                        printf("EN %s %s\n+base %s\n", $1, ($2)+1, $1);

                    else if(($2)[strlen($2)-1] == '-'){
                       
                        ($2)[strlen($2)-1] = '\0';
                        printf("EN %s %s\n+base %s\n", $2, $1, $1);
                      }
                    }

     ; 

Palavras : PALING  PALPORT {  char* aux;
                              if(($1)[0] == '-')
                                aux = strdup(($1)+1);

                              else if(($1)[strlen($1)-1] == '-'){
                                aux = strdup($1);
                                aux[strlen(aux)-1] = '\0';
                              }
                              else
                                aux = strdup($1);

                              if(i == 1) { 
                                printf("PT %s\n", $2);
                              } 
                              else 
                                printf("EN %s\nPT %s\n\n", aux, $2);
                            }
         ;


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
