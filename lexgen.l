%{

#include <stdio.h>
#include <stdlib.h>
#include<string.h>
#include <unistd.h>
#include <fcntl.h>
int ifd;
int ofd;
char **tokens;
char **terminais;
int ntokens=0;
int ntokensmax = 1;
int nterminais =0;
int nterminaismax = 1;
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

<tok>[^ \n]+ {
				if(ntokens == 0){
					tokens = malloc(ntokensmax*sizeof(char*));
				}

				if(ntokens == ntokensmax){
					char** aux = malloc(ntokensmax*sizeof(char*));

					for(i = 0; i < ntokensmax; i++)
						aux[i] = strdup(tokens[i]);

					free(tokens);
					ntokensmax += ntokensmax;

					tokens = malloc(ntokensmax*sizeof(char*));

					for(i = 0; i < ntokens; i++)
						tokens[i] = strdup(aux[i]);

					free(aux);
				}

				tokens[ntokens] = malloc(yyleng*sizeof(char));
				tokens[ntokens] = strdup(yytext);
				ntokens++;
			}

\%\% BEGIN gen ;

<gen>\%\% BEGIN 0;

<gen>\{.*\} ;

<gen>\'[^a-zA-Z0-9]\' {
				yytext[yyleng-1]='\0';
				if(nterminais == 0){
					terminais = malloc(nterminaismax*sizeof(char*));
				}

				if(nterminais == nterminaismax){
					char** aux = malloc(nterminaismax*sizeof(char*));

					for(i = 0; i < nterminaismax; i++)
						aux[i] = strdup(terminais[i]);

					free(terminais);
					nterminaismax += nterminaismax;

					terminais = malloc(nterminaismax*sizeof(char*));

					for(i = 0; i < nterminais; i++)
						terminais[i] = strdup(aux[i]);

					free(aux);
				}

				terminais[nterminais] = malloc(yyleng*sizeof(char));

				terminais[nterminais] = strdup(yytext+1);
				nterminais++;
			}    ;

<*>.|\n;

<<EOF>> { criarFicheiro();
          return 0;
        }

%%


void criarFicheiro(){


int i;
	int maxtokens = ntokens;
printf("\n%s\n", "%%") ;

printf("\nNUMERO TOKENS: %d\n",ntokens);

for(i=0; i < maxtokens; i++){

			printf("FIXME { return	%s;}\n",tokens[i]);
			ntokens--;

 }

	 printf("[");
	 for(i=0; i<nterminais; i++){

				printf("%s", terminais[i]);

	 }

	 printf("] { return	yytext[0];}");



   printf("\n%s\n", "%%") ;
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
