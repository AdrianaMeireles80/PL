%{
#include "y.tab.h"
%}
%option noyywrap

%x Base
%x dicionario
%x palavra
%%
[ \t\n\r] ;

\_\_BEGIN\_\_ { BEGIN dicionario;
                return START; 
              }

<dicionario>^[a-zA-Z]*: { BEGIN Base;  
                          yylval.sbase = strdup(yytext) ; 
                          return BASE; 
                        }

<Base>^[ ]+ { yylval.spal = strdup(yytext) ; 
              return PALING; }
              
<Base>^[a-zA-Z]*: { BEGIN Base;
                    yylval.sbase = strdup(yytext) ; 
                    return BASE;
                  }



<dicionario>^[a-zA-Z]*[ ]+ { BEGIN dicionario;  
                         yylval.spal = strdup(yytext) ; 
                         return PALING;
                       }


.                     {return ERRO;}
                    