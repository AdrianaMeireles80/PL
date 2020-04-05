%{
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
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
int eliminarep(char **);
void alocaMem();
%}

%x gen tok

%option noyywrap

%%

				BEGIN 0;

[ \t\n\r] 		;

\%token 		BEGIN tok;

<tok>\n 		BEGIN 0;

<tok>\ 			;

<tok>[^ \n]+ 	{
					if(ntokens == 0){
						tokens = malloc(ntokensmax*sizeof(char*));
					}

					if(ntokens == ntokensmax){
						alocaMem(tokens,ntokens,ntokensmax);
					}

					tokens[ntokens] = malloc(yyleng*sizeof(char));
					tokens[ntokens] = strdup(yytext);
					ntokens++;
				}

\%\% 			BEGIN gen;

<gen>\%\% 		BEGIN 0;

<gen>\{.*\} 	;

<gen>'[^ ]+' 	{
					yytext[yyleng-1]='\0';
					if(nterminais == 0){
						terminais = malloc(nterminaismax*sizeof(char*));
					}

					if(nterminais == nterminaismax){
						alocaMem(terminais,nterminais,nterminaismax);
					}

					terminais[nterminais] = malloc(yyleng*sizeof(char));

					terminais[nterminais] = strdup(yytext+1);
					nterminais++;
				}    

<*>.|\t|\n|\r 	;

<<EOF>> 		{
					criarFicheiro();
          			return 0;
        		}

%%

// Função responsável pela alocação de Memória de um vetor de strings dado o seu tamanho e o máximo inicial

void alocaMem(char **v,int num,int max){

	char** aux = malloc(max*sizeof(char*));

					for(i = 0; i < max; i++)
						aux[i] = strdup(v[i]);

					free(v);
					max += max;

					v = malloc(max*sizeof(char*));

					for(i = 0; i < num; i++)
						v[i] = strdup(aux[i]);

					free(aux);
}

// Função responsável por eliminar os símbolos terminais repetidos dado o vetor de strings 

int eliminarep(char ** a){
	int i, j, k;
	int tam = nterminais;

	 for( i = 0; i < tam; i++ )
	 {
			 for( j = i + 1; j < tam; )
			 {
					 if(	strcmp(terminais[j],terminais[i]) == 0 )
					 {
							 for( k = j; k < tam; k++ )
									 terminais[k] = terminais[k + 1];

							 tam--;
					 }
					 else
							 j++;
			 }
	 }

	 return tam;
}

// Função responsável pela estrutura do ficheiro output resultante da leitura dos vetores de strings dos tokens e símbolos terminais

void criarFicheiro(){
	int tam = eliminarep(terminais);
	int i;

	printf("\n%s\n", "%%") ;

	for(i=0; i < ntokens; i++){

			printf("FIXME { return	%s;}\n",tokens[i]);
 	}

	 printf("[");
	 for(i=0; i<tam; i++){

				printf("%s", terminais[i]);

	 }
	 printf("] { return  yytext[0];}");

   printf("\n%s\n", "%%") ;
}

int main(int argc,char *argv[]){

	if ( argc != 2 ){

       printf ("Usage : ./ exe <ficheiro yacc> \n");
	   return 0;
	}

	ifd=open(argv[1],O_RDONLY);
    ofd = open("output.l", O_CREAT | O_WRONLY | O_TRUNC, 0666);

	int res1 = dup2(ifd, STDIN_FILENO);
	int res2 = dup2(ofd, STDOUT_FILENO);

	close(ifd);
	close(ofd);

	yylex();

	return 0;
}
