%{
#include <stdio.h>
#include <stdlib.h>
#include<string.h>
#include <unistd.h>   
#include <fcntl.h>
int ifd;
int ofd;

%}

%x gram
%option noyywrap 

%%

				BEGIN 0;
	
[ \t\n\r] 		;

\%\% 			BEGIN gram;

<gram>\%\% 		BEGIN 0;

<gram>'[^ ]+' 	printf("%s", yytext);

<gram>\{.*\} 	;

<gram>[^{'%]+   printf("%s", yytext);

<*>.|\n|\r|\t	;

%%

int main(int argc,char *argv[]){

	if ( argc != 2 ){
       printf ("Usage : ./ exe <ficheiro yacc> \n");
	   return 0;
	}

	ifd = open(argv[1],O_RDONLY);
	ofd = open("gram.txt", O_CREAT | O_WRONLY | O_TRUNC, 0666); 

	int res = dup2(ifd, STDIN_FILENO);
	int res2 = dup2(ofd, STDOUT_FILENO);	

	yylex();

	return 0;
}