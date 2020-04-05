all: extraiGIC lexgen
extraiGIC: extraiGIC.l
					flex extraiGIC.l
					gcc -o extraiGIC.exe lex.yy.c -ll

lexgen: lexgen.l
				flex lexgen.l
				gcc -o lexgen.exe lex.yy.c -ll


clean-extraiGIC:
						rm extraiGIC
						rm lex.yy.c

clean-lexgen:
						rm lexgen
						rm lex.yy.c
						rm output
