ReverseEngineering : y.tab.o lex.yy.o
	gcc -o ReverseEngineering y.tab.o lex.yy.o

y.tab.o : y.tab.c
	gcc -c y.tab.c

lex.yy.o : lex.yy.c
	gcc -c lex.yy.c

y.tab.c y.tab.h : ReverseEngineering.y
	yacc -d ReverseEngineering.y

lex.yy.c : ReverseEngineering.l y.tab.h
	flex ReverseEngineering.l

clean:
	rm -f ReverseEngineering lex.yy.c lex.yy.o y.tab.h y.tab.o y.tab.c
						
