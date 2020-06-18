%{
#include "y.tab.h"
#include <stdio.h>
#include <string.h>
#include <ctype.h>

%}
%option noyywrap


%x dicionario
acentos \xc3[\x80-\xbf]
palavra ([a-zA-Z]|{acentos})+([ ]([a-zA-Z()]|{acentos})+)?
%%

<*>[ \t\n\r] ;


\_\_BEGIN\_\_ { 
                BEGIN dicionario;
                return START;
              }

<dicionario>[:\-,] { char* a = strdup(yytext); printf("porque %s \n",a);return yytext[0];}


<dicionario>{palavra}[ ]*\n  { 	
								yylval.spal = strdup(yytext) ; printf("\nboas javardos %s\n", yylval.spal);
                            	return PALPORT;
                      		}

<dicionario>^[ ]+{palavra} {  
							 	yylval.spal = strdup(yytext) ; printf("\nboas people %s\n",yylval.spal);
                             	return PALING; 
                             }

<dicionario>^{palavra} {  
						 yylval.spal = strdup(yytext) ;printf("\nboas macacos %s\n", yylval.spal);
                       	 return PALING;
                       }
 
.                  {return ERRO;}

%%

