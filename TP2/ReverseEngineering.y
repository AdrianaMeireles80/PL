%{
#include <stdio.h>
#include <string.h>

extern int yylex();
extern int yylineno;
extern char *yytext;

int yyerror();
int erroSem(char*);
char* buf=NULL;

%}

%union{
    char* spal;
}

%token ERRO  START PALING PALPORT 

%type<spal>  Palavras PALPORT PALING Portugues  

%%

Dicionario : START  ListaPalavras {printf("\n");}
           ;

ListaPalavras : ListaPalavras Palavras 

              | Palavras 
             
              ;


Palavras : PALING  Portugues  {printf("EN %s\nPT %s\n", $1, $2);}
         | PALING ':' '-' PALING Portugues {

                                            printf("EN %s %s\n +base %s\nPT %s\n",$1,$4,$1,$5);
                     }

         | PALING ':' PALING '-' Portugues  {

                                            printf("EN %s %s\n +base %s\nPT %s\n",$3,$1,$1,$5);
                                            }

         | PALING ':' PALING '-' PALING Portugues {

                                            printf("EN %s %s %s\n +base %s\nPT %s\n",$3,$1,$5,$1,$6);
                                             }

        | PALING ':' Portugues  {
                                printf("EN %s\nPT %s\n", $1, $3);
                                //falta por os casos da base
                                }

         ;


Portugues : PALPORT                             {
                                                buf = malloc(sizeof(char)*(strlen($1)+1));
                                                sprintf(buf,"%s\n",$1);
                                                $$= strdup(buf); 
                                                }

          | PALPORT ',' PALPORT                 {
                                                buf = malloc(sizeof(char)*(strlen($1)+strlen($3)+4));
                                                sprintf(buf,"%s\nPT %s\n",$1, $3);
                                                $$ = strdup(buf);
                                                }

          | PALPORT ',' PALPORT ',' PALPORT     {
                                                buf = malloc(sizeof(char)*(strlen($1)+strlen($3)+strlen($5)+8));
                                                sprintf(buf,"%s\nPT %s\nPT %s\n",$1, $3,$5); 
                                                $$ = strdup(buf);
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
