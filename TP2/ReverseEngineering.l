%{
#include "y.tab.h"
#include <stdio.h>
#include <string.h>
#include <ctype.h>
void yyerror(char* s);
%}
%option noyywrap
%option yylineno


%x dicionario
%x pal

acentos \xc3[\x80-\xbf]
palavra ([a-zA-Z]|{acentos})+([ ]([a-zA-Z()]|{acentos})+)*
%%

<*>[\n\r] ;


\_\_BEGIN\_\_ {
                BEGIN dicionario;
                return START;
              }


<dicionario>[:\-,;] { return yytext[0];}

<dicionario>[\t]+ {return '\t';}

<dicionario>{palavra} {  yylval.spal = strdup(yytext) ;
                       	 return PALAVRA;
                       }

<dicionario>^[ ]+ {return 'B';}

.                       {yyerror("Carater inválido.");}

%%
