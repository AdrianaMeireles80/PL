%{
#include "y.tab.h"
#include <stdio.h>
#include <string.h>
#include <ctype.h>

char* aux=NULL;
void yyerror(char* s);
void lower_string(char* s);
%}

%option noyywrap
%option yylineno

%x dicionario

acentos \xc3[\x80-\xbf]
palavraPort ([a-z\/\-+()]|{acentos})+([ ]([a-z\/\-+()]|{acentos})+)*

palavraIng [A-Z]+([ \-][A-Z()]+)*
%%

\_\_BEGIN\_\_ { 
                BEGIN dicionario;
                return START;
              }
[^\n]+ ;

<*>[ \t\n\r] ;

<dicionario>[\-] {
		  if(aux!=NULL){
		  	yylval.spal = strdup(aux);
			return BASEAUX;
		  }
		 }

<dicionario>[,;] { return yytext[0];}

<dicionario>^{palavraIng}: {
				yytext[yyleng-1] = '\0';
				lower_string(yytext);	
				yylval.spal = strdup(yytext);  
				aux = strdup(yytext);
				return BASE;
			   }

<dicionario>^{palavraIng} {  
				lower_string(yytext);
				yylval.spal = strdup(yytext) ;
                       	 	return DEFING;
                           }

<dicionario>{palavraIng} { 
				lower_string(yytext);
				yylval.spal = strdup(yytext) ;
				return PALING;
                         }

<dicionario>{palavraPort} { 
				yylval.spal = strdup(yytext) ; 
                            	return PALPORT;
                      	  }
			  
<*>.                  {yyerror("ERRO");}

%%

void lower_string(char* s) {
   int c = 0;
   
   while (s[c] != '\0') {
      if (s[c] >= 'A' && s[c] <= 'Z') {
         s[c] = s[c] + 32;
      }
      c++;
   }
}
