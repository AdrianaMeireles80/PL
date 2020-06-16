%{
#include "y.tab.h"
#include <stdio.h>
#include <string.h>
#include <ctype.h>
int flag = 0;
int i, j;

void strrev (char* s);

%}
%option noyywrap

%x Base
%x dicionario
%x PalPort
%%

<*>[ \t\n\r] ;

[ \:\-,] {return yytext[0];}

\_\_BEGIN\_\_ { 
                BEGIN dicionario;
                return START;
              }


<dicionario>^[a-zA-Z]* {  yylval.spal = strdup(yytext) ;
                          return PALING;
                       }

<dicionario>^[ ]+[,?a-zA-Z]+ { yylval.spal = strdup(yytext) ; 
                               return PALING; 
                             }

<dicionario>[a-zA-Z]* { yylval.spal = strdup(yytext) ; 
                    return PALPORT;
                  }

.                  {return ERRO;}

%%
