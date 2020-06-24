%{
#include <stdio.h>
#include <string.h>

extern int yylex();
extern int yylineno;
extern char *yytext;

int yyerror();
int erroSem(char*);
int i=0;

%}

%union{
    char* spal;
}

%token ERRO  START PALING PALPORT 

%type<spal>  Palavras PALPORT PALING ListaBase Ingles Portugues 

%%

Dicionario : START  ListaPalavras 
           ;

ListaPalavras : ListaPalavras Palavras {printf("%s\n", $2);}
              | Palavras {printf("%s\n", $1);}
             
              ;


Palavras : PALING PALPORT {asprintf(&$$, "EN %s\nPT %s\n", $1, $2);}
         | PALING ':' ListaBase {printf("ehehe");}
         | PALING ':' PALPORT  ListaBase {char* tokens = strtok ($4,"\n");
                                                
                                                char* values[i*2];
                                                int j=0;
                                                values[0] = strdup(tokens);
                                                while( tokens != NULL && j<i) {
      
    
                                                tokens = strtok(NULL, "\n");
                                                j++;
   }
                                                tokens = strtok (NULL, "\n");
                                                values[1] = strdup(tokens); asprintf(&$$, "EN %s\nPT %s\n\nEn %s %s\n+base %s\nPT %s", $1, $3, values[0],$1,$1, values[1]);
                                                for(j=0;j<i*2; j++){
                                                    printf("j %d\n",j);
                                                    
                                                    printf("e %s\n",values[j]);
                                                }}


         ;

ListaBase : ListaBase Ingles Portugues {i++;asprintf(&$$, "%s \n%s\n%s\n", $1, $2,$3);}
          | Ingles Portugues { i++; asprintf(&$$, "%s\n%s", $1, $2);}
          ;



Ingles : PALING '-' 
       
       | '-' PALING 
       | PALING
       ;

Portugues : PALPORT 
          | PALPORT ',' PALPORT { asprintf(&$$, "%s\n%s", $1, $3);}
          | PALPORT ';' PALPORT { asprintf(&$$, "%s\n%s", $1, $3);}
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
    return 0;
}
