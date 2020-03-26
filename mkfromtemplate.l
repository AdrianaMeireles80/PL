%{
#include <string.h>
#include <stdlib.h>
#include <stdio.h>


char *email;
char *author;
char *name;

%}

%option noyywrap
%s META TREE 

%%
[ \n\t\r] ;

"\=\=\= meta" BEGIN META ;printf("META\n");

<META>[^email :].*    { email = strdup(yytext); printf("Email é:%s\n", yytext+9);}
<META>[^author :].*   { author = strdup(yytext); printf("Autor é:%s\n", yytext + 9);}

"\=\=\= tree" BEGIN TREE ; printf("TREE\n");

<TREE>name\/ ;
<TREE>\-name.fl ;
<TREE>\-\-name.md ;
<TREE>\-exemplo\/ ;
<TREE>\-Makefile ;

<*>.|\n;

%%

int main(int argc, char *argv[]){

	int res;
	

	if(argc != 2){
		 printf ("Usage : ./mk.exe <name> \n");
	   return 0;
	}

	name = argv[1];

   yylex();

   return 0;
}

