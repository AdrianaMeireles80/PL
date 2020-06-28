%{
#include <stdio.h>
#include <string.h>
#include <stdlib.h>

extern int yylex();
void yyerror(char*);
int erroSem(char*);

int i=0;

%}

%union{
    char* spal;
}

%token START PALING PALPORT BASEAUX BASE DEFING

%type<spal>  Palavras PALPORT PALING ListaBase Ingles Portugues BASEAUX BASE PortuguesAux InglesAux  Definicao DEFING

%%

Dicionario : START  ListaPalavras
           ;

ListaPalavras : ListaPalavras Palavras {printf("%s",$2);}
              | Palavras {printf("%s",$1);}
              ;

Palavras : DEFING Portugues {asprintf(&$$, "EN %s\n%s\n\n", $1, $2);}
         | error            {asprintf(&$$, "");}
         |  BASE Definicao ListaBase {	
	 				char* tokens = strtok ($3,"#");
					char* values[2];
					char* aux[i];
					int j=0,size=0;
					
					while( tokens != NULL && j<i) {
					
						values[0] = strdup(tokens);
						tokens = strtok(NULL, "#");
						values[1] = strdup(tokens);
						asprintf(&aux[j], "EN %s\n+base %s\n%s\n\n",values[0], $1,values[1]);
						size += strlen(aux[j]);
						j++;
						tokens = strtok(NULL, "#");
					}
					
                                    	if($2!=NULL){
					
						tokens = NULL;
						asprintf(&tokens, "EN %s\nPT %s\n\n",$1,$2);
						$$ = malloc(sizeof(char)*(size + strlen(tokens)));
						strcat($$,tokens);
                                    	}
					else $$ = malloc(sizeof(char)*size);
					
					for(j=0; j < i; j++){
						strcat($$,aux[j]);
					}
					
					i=0;
				}
           ;

Definicao: PALPORT {$$ = strdup($1);}
         | {$$=NULL;}
         ;

ListaBase : ListaBase Ingles Portugues {i++;asprintf(&$$, "%s%s#%s#", $1, $2,$3);}
          | Ingles Portugues           {i++;asprintf(&$$, "%s#%s#", $1, $2);}
          ;

Ingles : PALING BASEAUX InglesAux {
					if($3!=NULL)
						asprintf(&$$, "%s %s %s", $1,$2,$3);
					else
						asprintf(&$$, "%s %s", $1,$2);
				  }
				  
       | BASEAUX PALING        {asprintf(&$$, "%s %s", $1, $2);}
       ;
       
InglesAux : {$$=NULL;}
          | PALING {$$ = strdup($1);}
	  ;

Portugues : PALPORT  PortuguesAux { 
					if($2!=NULL)
						asprintf(&$$, "PT %s\n%s", $1,$2);
					else
						asprintf(&$$, "PT %s", $1);
				  }
          ;

PortuguesAux :  {$$=NULL;}
             |  ',' PALPORT {asprintf(&$$, "PT %s",$2);}
             |  ';' PALPORT {asprintf(&$$, "PT %s", $2);}
             ;
	     
%%
int main(){
    yyparse();
    return 0;
}

void yyerror(char* s){
   extern int yylineno;
   extern char* yytext;
   fprintf(stderr, "Linha %d: %s (%s)\n\n",yylineno,s,yytext);
}
