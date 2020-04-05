all: extraiGIC lexgen
extraiGIC: extraiGIC.l
					flex extraiGIC.l
					gcc -o extraiGIC.exe lex.yy.c -ll

lexgen: lexgen.l
				flex lexgen.l
				gcc -o lexgen.exe lex.yy.c -ll


clean-extraiGIC:
						rm -f extraiGIC
						rm -f lex.yy.c
						rm -f gram.txt
						rm -f extraiGIC.exe

clean-lexgen:
						rm -f lexgen
						rm -f lex.yy.c
						rm -f output.l
						rm -f lexgen.exe
