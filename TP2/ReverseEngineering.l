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


\_\_BEGIN\_\_ { 
                BEGIN dicionario;
                return START;
              }


<dicionario>^[a-zA-Z]*: { 
                          BEGIN Base;
                          yylval.sbase = strdup(yytext);
                          yylval.sbase[yyleng - 1] = '\0';  
                          flag =1;
                          
                          return BASE;
                        }

<Base>^[a-zA-Z]+ { 
                   flag = 0; 
                   BEGIN PalPort;
                   yylval.spal = strdup(yytext) ;
                   return PALING;
                 }

<Base>^[a-zA-Z]*: {
                  BEGIN Base;
                  yylval.sbase = strdup(yytext) ;
                  yylval.sbase[yyleng - 1] = '\0';

                  return BASE;
                  }


<Base>^[ ]+[ \-a-zA-Z]+[ ]{2}[^a-zA-Z] { 
                               BEGIN PalPort;
                               char* aux = malloc(sizeof(char)*yyleng);
                               for(i = 0, j = 0; i < yyleng - 1; i++){
                                  if(isalpha(yytext[i]) || yytext[i] == '-'){
                                      aux[j++] = yytext[i];
                                  }
                                  else if(yytext[i] == ' ' && isalpha(yytext[i+1]) && isalpha(yytext[i-1]) && i > 0){
                                      aux[j++] = yytext[i];
                                  }
                               }
                               aux[j++] = '\0';
                               yylval.spal = strdup(aux);

                               return PALING;
                             }

<dicionario>^[a-zA-Z]*.+[ ]{2}[^a-zA-Z] { 
                                          BEGIN PalPort;

                                          char* aux = malloc(sizeof(char)*yyleng);
                                          for(i = 0, j = 0; i < yyleng - 1; i++){
                                              if(isalpha(yytext[i]) || yytext[i] == '-'){
                                                  aux[j++] = yytext[i];
                                              }
                                          }
                                          aux[j++] = '\0';
                                          yylval.spal = strdup(aux);

                                          return PALING;
                                        }



<PalPort>[a-zA-Z]+.* {
                      yylval.spal = strdup(yytext) ;
                      if (flag == 1 )  BEGIN Base  ;
                      else  BEGIN dicionario;
                      return PALPORT;
                     }

<*>.                  {return ERRO;}

%%
