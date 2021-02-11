.SUFFIXES:

all: analizador
	./analizador < prueba.c

analizador: y.tab.o semantico.o
	gcc -o analizador -lfl y.tab.o semantico.o

y.tab.o: y.tab.c lex.yy.c
	gcc -c y.tab.c

y.tab.c: semantico.y lex.yy.c
	bison -v -d -o y.tab.c semantico.y

semantico.o: semantico.c
	gcc -c semantico.c

lex.yy.c: especificacion.lex
	lex -l especificacion.lex

clean:
	rm -f analizador y.tab.o y.tab.c lex.yy.c y.output semantico.o
