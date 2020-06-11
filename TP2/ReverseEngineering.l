%{
#include "y.tab.h"
 int flag = 0;
%}
%option noyywrap

%x Base
%x dicionario
%x PalPort
%%
[ \t\n\r] ;

\_\_BEGIN\_\_ { BEGIN dicionario;
                return START; 
              }

<dicionario>^[a-zA-Z]*: { BEGIN Base; 
                          yylval.sbase = strdup(yytext) ; flag =1;
                          return BASE;
                        }

<Base>^[a-zA-Z]+ { flag = 0; BEGIN PalPort; 
                   yylval.spal = strdup(yytext) ; 
                   return PALING;
                 }

<Base>^[ ]+.+[ ] { BEGIN PalPort; 
                   yylval.spal = strdup(yytext) ; 
                   return PALING;
                 }

<dicionario>^[a-zA-Z]* { BEGIN PalPort; 
                         yylval.spal = strdup(yytext) ; 
                         return PALING;
                       }
                       
<PalPort>[^\n]+  {yylval.spal = strdup(yytext) ;  if (flag == 1 )  BEGIN Base  ; else  BEGIN dicionario; 
                   return PALPORT; 
                 }

.                     {return ERRO;}
                    