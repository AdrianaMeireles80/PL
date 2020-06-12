%{
#include "y.tab.h"
 int flag = 0;

%}
%option noyywrap

%x Base
%x dicionario
%x PalPort
%%

<*>[\t\n\r] ;

\_\_BEGIN\_\_ { BEGIN dicionario;
                return START;
              }
<dicionario>[A-Z] ;
<dicionario>^[a-zA-Z]*: { BEGIN Base;
                          yylval.sbase = strdup(yytext) ; yylval.sbase[yyleng - 1] = '\0'; flag =1;
                          return BASE;
                        }

<Base>^[a-zA-Z]+ { flag = 0; BEGIN PalPort;
                   yylval.spal = strdup(yytext) ;
                   return PALING;
                 }
<Base>^[a-zA-Z]*: { BEGIN Base;
                   yylval.sbase = strdup(yytext) ;
                   return BASE;
                 }

<Base>^[ ]+.+[ ]{2}[^a-zA-Z] { BEGIN PalPort;
                   yylval.spal = strdup(yytext) ;
                   return PALING;
                 }

<dicionario>^[a-zA-Z]*.+[ ]{2}[^a-zA-Z] { BEGIN PalPort;
                         yylval.spal = strdup(yytext) ;
                         return PALING;

                       }


<PalPort>[ ] ;
<PalPort>[a-zA-Z]+.* {yylval.spal = strdup(yytext) ;  if (flag == 1 )  BEGIN Base  ; else  BEGIN dicionario;
                   return PALPORT;
                 }

<*>.                     {return ERRO;}
