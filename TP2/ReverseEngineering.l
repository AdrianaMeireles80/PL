%{
#include "y.tab.h"
#include <stdio.h>
#include <string.h>
#include <ctype.h>

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


<dicionario>[ ()a-zA-Z]+\n  { 
								yylval.spal = strdup(yytext) ; 
                            	return PALPORT;
                      		}

<dicionario>^[ ]+[ ,a-zA-Z]+ {
							 	yylval.spal = strdup(yytext) ; 
                             	return PALING; 
                             }

<dicionario>^[a-zA-Z]+ {  
						 yylval.spal = strdup(yytext) ;
                       	 return PALING;
                       }
 
.                  {return ERRO;}

%%
