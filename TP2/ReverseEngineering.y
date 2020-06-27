%{
#include <stdio.h>
#include <string.h>

extern int yylex();
extern int yylineno;
extern char *yytext;

void yyerror(char* s);

int i=0;
int atoi(char *);

%}

%union{
    char* spal;
}

%token   START  PALAVRA
%type<spal>  Palavras  ListaBase  Portugues PALAVRA Ingles

%%

Dicionario : START  ListaPalavras
            | START error {printf("bobo");}

           ;

ListaPalavras : ListaPalavras  Palavras {printf("%s", $2);}
              | Palavras {printf("%s", $1);}
              ;


Palavras : PALAVRA '\t' Portugues  {asprintf(&$$, "EN %s\n%s\n", $1, $3);}
         | error  {printf("coco\n ");}
         | PALAVRA ':' ListaBase
         | PALAVRA ':' '\t' Portugues  ListaBase  { asprintf(&$$, "EN %s\n%s\n", $1, $4);
                                                    char* tokens = strtok ($5,"#");

                                                  char* aux[i] ;
                                                  char* values[i*i*3];
                                                  int j=0, size=0, k;
                                                    /*
                                                  while( tokens != NULL && j<i*3) {

                                    	                values[j] = strdup(tokens);

                                                    switch (atoi(values[j]) ) {

                                                        case 1:
                                                            tokens = strtok(NULL, "\n");
                                      	                    values[j+1] = strdup(tokens);

                                                            tokens = strtok(NULL, "\n");
                                      	                    values[j+2] = strdup(tokens);
                                                            asprintf(&aux[j], "EN %s %s\n+base %s\nPT %S\n", $1,values[j+1],$1,values[j+2]);

                                       	                    size += strlen(aux[j]);

                                                        break;

                                                        case 2:
                                                            tokens = strtok(NULL, "\n");
                                      	                    values[j+1] = strdup(tokens);

                                                            tokens = strtok(NULL, "\n");
                                      	                    values[j+2] = strdup(tokens);
                                                            asprintf(&aux[j], "EN %s %s\n+base %s\n%s\n",values[j+1],$1,$1,values[j+2]);

                                                            size += strlen(aux[j]);
                                                        break;

                                                        case 3:
                                                            tokens = strtok(NULL, "#");
                                      	                    values[j+1] = strdup(tokens);

                                                            tokens = strtok(NULL, "\n");
                                      	                    values[j+2] = strdup(tokens);

                                                            tokens = strtok(NULL, "\n");
                                      	                    values[j+3] = strdup(tokens);
                                                            asprintf(&aux, "EN %s %s %s\n+base %s\n%s\n",values[j+1], $1, values[j+2],$1,values[j+3]);

                                                            size += strlen(aux[j]);
                                                            j++;
                                                        break;
                                                    }
                                                    j=j+3;


                                                  }*/

                                                  $$ = malloc(sizeof(char)*size);

   									            for(k=0; k < i; k++){

   										        strcat($$,aux[k]);
   									            }

   									            i=0;

                                                }
         ;

ListaBase : ListaBase Ingles '\t' Portugues  {i++;asprintf(&$$, "%s\n%s\n%s", $1, $2,$4); }
          | Ingles '\t' Portugues { i++; asprintf(&$$, "%s\n%s", $1, $3); }
          ;



Ingles : 'B' PALAVRA '-' {  asprintf(&$$, "2#%s", $2);}
       | 'B' '-' PALAVRA {asprintf(&$$, "1#%s", $3);}
       | 'B' PALAVRA '-'  PALAVRA {  asprintf(&$$, "3#%s#%s", $2,$4);}
       ;

Portugues : PALAVRA { asprintf(&$$, "PT %s\n", $1);}
          | PALAVRA ',' PALAVRA { asprintf(&$$, "PT %s\nPT %s", $1, $3);}
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

void yyerror(char* s){
   extern int yylineno;
   extern char* yytext;
   fprintf(stderr, "Linha %d: %s (%s)\n",yylineno,s,yytext);
}
