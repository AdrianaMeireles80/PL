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

%type<sbase> Base BASE 
%type<spal>  Palavras PALPORT PALING Portugues Ingles  



%%

Dicionario : START  ListaPalavras {printf("\n");}
           ;

ListaPalavras : ListaPalavras Palavras {printf("\n");}
              | ListaPalavras Base   {printf("ssss");}
              | Palavras {printf("potas\n");}
              | Base    {printf("aaaaa");}
              ;


Palavras :  Ingles  Portugues {printf("asdfghn\n");}
         ;

Base : Ingles ':' Ingles {printf("+base \nPT " );}
     | Ingles ':' Portugues {printf("+base \nPT " );}

     ;

Portugues : PALPORT                             {$$= $1; printf("PT   %s\n",$1);}
          | PALPORT ',' PALPORT                 {$$= $1; printf("PT   %s\n",$1);}
          | PALPORT ',' PALPORT ',' PALPORT     {$$= $1; printf("PT   %s\n",$1);}
          ;

Ingles : PALING '-' Portugues          {$$= $1; printf("EN   %s\n",$1);}
       | '-' PALING Portugues           {$$= $2; printf("EN   %s\n",$2);}
       | PALING '-' PALING Portugues    {$$= $1; printf("EN   %s\n",$1);}
       | PALING  Portugues              {$$= $1; printf("EN   %s\n",$1);}
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
