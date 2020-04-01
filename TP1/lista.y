
%{
#include <stdio.h>
extern int yylex();
int yyerror();
%}

%token ERRO INT DOISPONTOS LOL OLE
%%
Listas : Lista Listas			{rgrgs}
	   |
	   ;

Lista : '[' ']'
	  | '[' Elems ']'
	  ;

Elems : Elem
	  | Elems ',' Elems 		//mais eficiente do que Elem ',' Elems
	  | Lista
	  ;

Elem  : INT
	  | Intervalo
	  ;

Intervalo : INT DOISPONTOS INT
          |INT LOL INT
          |INT OLE INT
		  ;

%%
int main(){
	yyparse();
	return 0;
}

int yyerror(){
	printf("Erro sintatico...\n");
	return 0;
}
