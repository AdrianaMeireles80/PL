%{
#include <stdio.h>
#include <stdlib.h>
%}

%x gram
%option noyywrap 

%%
	BEGIN 0;
	
[ \t\n\r] ;

\%\% BEGIN gram;

<gram>\%\% BEGIN 0;

<gram>\{.*\} ;

.+ ;

%%

int main(){
	yylex();
	return 0;
}


