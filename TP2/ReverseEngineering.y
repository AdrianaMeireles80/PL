%{
#include <stdio.h>
#include <string.h>

extern int yylex();
extern int yylineno;
extern char *yytext;

int yyerror();
int erroSem(char*);
int i =0;

%}

%union{
    char* sbase;
    char* spal;

}

%token ERRO  START PALING PALPORT BASE 

%type<spal>  Palavras PALPORT PALING Portugues Ingles  



%%

Dicionario : START  ListaPalavras {printf("\n");}
           ;

ListaPalavras : ListaPalavras Palavras 

              | Palavras 
             
              ;


Palavras : Ingles  Portugues  {printf("\nEN %s\nPT %s\n", $1, $2);}
         | Ingles ':' Ingles Portugues {
                                    switch(i)
                                    {
                                        case 0 :
                                        printf("\n1-EN %s %s\n+base %s\nPT %s\n",$3,$1,$1,$4);
                                        break;

                                        case 1 :
                                        printf("\n2-EN %s %s\n+base %s\nPT %s\n",$1,$3,$1,$4);
                                        break;
                                        
                                    }
                                    }
         | Ingles ':' Portugues Palavras {printf("\EN %s\nPT %s\n", $1, $3);
                                        switch(i)
                                        {
                                            case 0 :
                                            printf("EN %s %s\n +base %s\n PT %s\n", , , ,$3);
                                            break;
                                            
                                            case 1 :
                                            printf("EN %s %s\n +base %s\n PT %s\n", , , ,$3);
                                        }
                                          }

         ;
         



Ingles : PALING '-'        {$$= $1; i=0; }
       | '-' PALING        {$$= $2;  i=1;}
       | PALING '-' PALING {$$= $1; i=2; }
       | PALING            {$$= $1;i=0;}
       
       ;

Portugues : PALPORT                             {$$= $1; }
          | PALPORT ',' PALPORT                 {$$= $1; }
          | PALPORT ',' PALPORT ',' PALPORT     {$$= $1; }
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
