%{
#include <stdio.h>
#include <string.h>

extern int yylex();
extern int yylineno;
extern char *yytext;

int yyerror();
int erroSem(char*);
int i=0;
int atoi(char *);

%}

%union{
    char* spal;
}

%token ERRO  START PALAVRA
%type<spal>  Palavras ListaBase Portugues PALAVRA Ingles

%%

Dicionario : START  ListaPalavras
           ;

ListaPalavras : ListaPalavras  Palavras {printf("%s", $2);}
              | Palavras {printf("%s", $1);}
              ;

Palavras : PALAVRA '\t' Portugues  {asprintf(&$$, "EN %s\n%s\n", $1, $3);}
         | PALAVRA ':' ListaBase
         | PALAVRA ':' '\t' PALAVRA  ListaBase  { char* tokens = strtok ($5,"#");
                                                  char* aux[i] ;
                                                  char* values[i*3];
                                                  int j=0, size=0, k;

                                                  while( tokens != NULL && j<i) {

                                                    values[j] = strdup(tokens);

                                                    tokens = strtok(NULL, "#");
                                      	            values[j+1] = strdup(tokens);

                                                    tokens = strtok(NULL, "#");
                                                    values[j+2] = strdup(tokens);

                                                    switch (atoi(values[j]) ) {

                                                      case 1:
                                                        //printf("1- %s\n2- %s\n",values[j+1],values[j+2] );
                                                        asprintf(&aux[j], "EN %s %s\n+base %s\nPT %s\n", $1,values[j+1],$1,values[j+2]);
                                                        //printf("tou aqui1 %s\n", aux[j]);
                                       	                size += strlen(aux[j]);
                                                        break;

                                                      case 2:
                                                        asprintf(&aux[j], "EN %s %s\n+base %s\nPT %s\n",values[j+1],$1,$1,values[j+2]);
                                                        size += strlen(aux[j]);
                                                        break;

                                                      case 3:
                                                        asprintf(&$$, "EN en %s en\n+base %s\nPT pt\n", $1,$1);
                                                        break;
                                                    }

                                                    j=j+3;
                                                  }

                                                  $$ = malloc(sizeof(char)*size);

   									                              for(k=0; k < i; k++){
                                                    strcat($$,aux[k]);
   									                              }

   									                              i=0;
                                              }
         ;

ListaBase : ListaBase Ingles '\t' Portugues  { i++;asprintf(&$$, "%s\n%s\n%s", $1, $2,$4); }
          | Ingles '\t' Portugues            { i++; asprintf(&$$, "%s\n%s", $1, $3); }
          ;



Ingles : 'B' '-' PALAVRA         { asprintf(&$$, "1#%s", $3); }
       | 'B' PALAVRA '-'         { asprintf(&$$, "2#%s", $2); }
       | 'B' PALAVRA '-' PALAVRA { asprintf(&$$, "3#%s#%s",$2,$4); }
       ;

Portugues : PALAVRA             { asprintf(&$$, "PT %s\n", $1); }
          | PALAVRA ',' PALAVRA { asprintf(&$$, "PT %s\nPT %s", $1, $3); }
          | PALAVRA ';' PALAVRA { asprintf(&$$, "PT %s\nPT %s", $1, $3); }
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
    printf("Erro Sintático ou Léxico na linha: %d, com o texto: (%s)\n", yylineno, yytext);
    return 0;
}
