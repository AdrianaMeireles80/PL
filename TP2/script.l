%{
#include "y.tab.h"
#include <stdio.h>
#include <string.h>
#include <ctype.h>
#include <unistd.h>
#include <fcntl.h>
#include <sys/types.h>

char* aux=NULL;
void yyerror(char* s);
void lower_string(char* s);

%}
%option noyywrap
%option yylineno


%x dicionario

acentos \xc3[\x80-\xbf]
palavraPort ([A-Z,;+\-\/]|{acentos})+([ ]+([A-Z(),;+\-\/]|{acentos})+)*[ ]*


%%


\_\_BEGIN\_\_ { 
                BEGIN dicionario;
                
                {printf("%s",yytext);}
              }

[^\n]+ {printf("%s",yytext);}

<*>[ \t\n\r] {printf("%s",yytext);}

<dicionario>[ ]{2,}{palavraPort}\n {
                                    lower_string(yytext);
                                    printf("%s",yytext);


                                   }      

<*>.                  {printf("%s",yytext);}

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

int main(){
  int fd = open("final4.txt",O_CREAT | O_WRONLY,0666);
  dup2(fd,1);
  close(fd);

  yylex();
  return 0 ;
}

