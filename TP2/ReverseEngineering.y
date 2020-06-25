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

%token ERRO  START PALING PALPORT BASEAUX BASE

%type<spal>  Palavras PALPORT PALING ListaBase Ingles Portugues BASEAUX BASE PortuguesAux InglesAux InglesAux2 Definicao

%%

Dicionario : START  ListaPalavras 
           ;

ListaPalavras : ListaPalavras Palavras {printf("%s", $2);}
              | Palavras {printf("%s", $1);}             
              ;


Palavras : PALING PALPORT {asprintf(&$$, "EN %s\nPT %s\n\n", $1, $2);}
         
         |  BASE Definicao ListaBase {	
         							char* tokens = strtok ($3,"#");
                                                
                                    char* values[2];

                                    char* aux[i];
                                    int j=0,size=0; 
                                                                 

                                    while( tokens != NULL && j<i) {  

                                    	values[0] = strdup(tokens);

    
                                      	tokens = strtok(NULL, "#");

                                      	values[1] = strdup(tokens);

                                      	//printf("values 0 %s,values 1 %s\n",values[0],values[1]);

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
                             
                                               
                                    }
           ;

Definicao: PALPORT {$$ = strdup($1);}
         | {$$=NULL;}
         ;


ListaBase : ListaBase Ingles Portugues {i++;asprintf(&$$, "%s%s#%s#", $1, $2,$3);}
          | Ingles Portugues           {i++;asprintf(&$$, "%s#%s#", $1, $2);}
          ;



Ingles : PALING InglesAux       {if($2!=NULL)
										asprintf(&$$, "%s %s", $1,$2);
									else 
										asprintf(&$$, "%s", $1);} 

       | BASEAUX PALING        {asprintf(&$$, "%s %s", $1, $2);}
       
       ;

InglesAux 	:  BASEAUX InglesAux2 {if($2!=NULL)
										asprintf(&$$, "%s %s", $1,$2);
									else 
										asprintf(&$$, "%s", $1);
								   }

       	    |              	      {$$=NULL;}
       		;

InglesAux2 : {$$=NULL;}
		   | PALING {$$ = strdup($1);}
		   ;

Portugues : PALPORT  PortuguesAux { if($2!=NULL)
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

int erroSem(char *s){
    printf("Erro Semântico na linha: %d, %s...\n", yylineno, s);
    
}

int yyerror(){
    printf("Erro Sintático ou Léxico na linha: %d, com o texto: %s\n", yylineno, yytext);
    return 0;
}
