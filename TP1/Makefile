all: extraiGIC lexgen
	
extraiGIC: extraiGIC.l
					flex extraiGIC.l
					gcc -o extraiGIC.exe lex.yy.c -ll

lexgen: lexgen.l
					flex lexgen.l
					gcc -o lexgen.exe lex.yy.c -ll


clean:
					rm -f extraiGIC.exe
					rm -f lex.yy.c
					rm -f gram.txt
					rm -f lexgen.exe
					rm -f output.l
						