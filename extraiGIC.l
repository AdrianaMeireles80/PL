%{
#include <stdio.h>
#include <stdlib.h>
#include<string.h>
#include <unistd.h>   
#include <fcntl.h>
int fd;

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

int main(int argc,char *argv[]){

	if ( argc != 2 ){

       printf ("Usage : ./ exe <ficheiro yacc> \n");
	   return 0;
	}

	fd=open(argv[1],O_RDONLY); 

	int res = dup2(fd, STDIN_FILENO);	

	yylex();

	return 0;
}


