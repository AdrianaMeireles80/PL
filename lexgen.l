%{

#include <stdio.h>
#include <stdlib.h>
#include<string.h>
#include <unistd.h>   
#include <fcntl.h>
int ifd;
int ofd;
char **tokens;
int ntokens=0;
int i;
void criarFicheiro();

%}

%x gen tok

%option noyywrap

%%

	BEGIN 0;
	
[ \t\n\r] ;

\%token BEGIN tok;


<tok>\n BEGIN 0;

<tok>\ ; 

<tok>[^ \n]+ {tokens = malloc(yyleng*sizeof(char)); tokens[ntokens] = strdup(yytext); ntokens++; printf("\nTokens: %s\n",yytext);}

\%\% {BEGIN gen ; printf("%%\n"); }



<gen>\%\% {BEGIN 0;  printf("%%\n"); }

<<EOF>> { criarFicheiro();
          return 0;   
        }

%%

void criarFicheiro(){

	int i;

	printf("\nNUMERO TOKENS: %d\n",ntokens);

	for(i=0; i < ntokens; i++){

		printf("\nFICHEIRO: %s\n",tokens[i]);
   }
}

int main(int argc,char *argv[]){

	if ( argc != 2 ){

       printf ("Usage : ./ exe <ficheiro yacc> \n");
	   return 0;
	}

	ifd=open(argv[1],O_RDONLY); 
    ofd = open("output.txt", O_CREAT | O_WRONLY | O_TRUNC, 0666);

	int res1 = dup2(ifd, STDIN_FILENO);
	int res2 = dup2(ofd, STDOUT_FILENO);

	close(ifd);
	close(ofd);

	yylex();

	return 0;
}
