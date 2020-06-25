%{
#include "y.tab.h"
#include <stdio.h>
#include <string.h>
#include <ctype.h>
char* aux=NULL;

%}
%option noyywrap
%option yylineno


%x dicionario

acentos \xc3[\x80-\xbf]
palavra ([a-zA-Z]|{acentos})+([ ]([a-zA-Z()]|{acentos})+)*
%%

<*>[ \t\n\r] ;


\_\_BEGIN\_\_ { 
                BEGIN dicionario;
                return START;
              }

<dicionario>[\-] {
					if(aux!=NULL){
                 		yylval.spal = strdup(aux); 
				 		return BASEAUX;
				 	}
				 }

<dicionario>[,;] { return yytext[0];}


<dicionario>^{palavra}: {
						yytext[yyleng-1] = '\0';	
						yylval.spal = strdup(yytext);  
						aux = strdup(yytext);
						//printf("base %s",aux);
				 		return BASE;
				 	    }

<dicionario>^{palavra} {  
						 yylval.spal = strdup(yytext) ;
                       	 return DEFING;
                       }


<dicionario>^[ ]+{palavra} {  
							 	yylval.spal = strdup(yytext) ;
                             	return PALING; 
                             }

<dicionario>{palavra}[ ]*\n  { 	yytext[yyleng-1] = '\0';
								yylval.spal = strdup(yytext) ; 
                            	return PALPORT;
                      		}



 
.                  {return ERRO;}

%%

