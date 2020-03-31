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
int ntokensmax = 1;
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
				//printf("\nTokens: %s\n",yytext);
			}

\%\% BEGIN gen ;

<gen>\%\% BEGIN 0;

<gen>\{.*\} ;

<gen>.+ ; //MUDA AQUI PA FAZERES A CENA DOS ' '

<<EOF>> { criarFicheiro();
          return 0;   
        }

%%

void criarFicheiro(){

	int i;
	//printf("\n%s\n", "%%") ;

	printf("\nNUMERO TOKENS: %d\n",ntokens);

	for(i=0; i <= ntokens+1; i++){

        printf("\nFIXME { return  %s;}\n",tokens[i]);
        ntokens--;
		
   }

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
