.SUFFIXES:

all: analizador_sint
	./analizador_sint < prueba.c

analizador_sint: y.tab.o
	g++ -o analizador_sint -lfl y.tab.o

y.tab.o: y.tab.c lex.yy.c
	gcc -c y.tab.c

y.tab.c: sintactico.y lex.yy.c
	bison -v -d -o y.tab.c sintactico.y

lex.yy.c: especificacion.lex
	lex -l especificacion.lex

clean:
	rm -f analizador_sint y.tab.o y.tab.c lex.yy.c y.output
