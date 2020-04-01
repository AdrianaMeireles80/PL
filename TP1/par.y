%{
#include <stdio.h>
extern int yylex();	
%}

%token ERRO
%%
Par : '(' Par ')' Par {o parentesis é gay}
	| 
	;

%%
int main(){
	yyparse();
	return 0;
}	

int yyerror(){
	printf("Erro sintático...\n");
	return 0;
}
...Codigo...
