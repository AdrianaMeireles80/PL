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


%x dicionario

%%

<*>[ \t\n\r] ;



\_\_BEGIN\_\_ { 
                BEGIN dicionario;
                return START;
              }

<dicionario>[:\-,] { return yytext[0];}
<dicionario>^[a-zA-Z]* {  yylval.spal = strdup(yytext) ;
                          return PALING;
                       }



<dicionario>^[ ]+[,?a-zA-Z]+ { yylval.spal = strdup(yytext) ; printf("asd %s\n",yylval.spal );
                               return PALING; 
                             }

<dicionario>[a-zA-Z]* { yylval.spal = strdup(yytext) ; 
                    return PALPORT;
                  }

.                  {return ERRO;}

%%
