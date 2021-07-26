.SUFFIXES:

FILE?=../variedades/lastParam.in

all: analizador

read: $(FILE) analizador
	script -q -c "./analizador < '$(FILE)'" > ../error.log

analizador: y.tab.o semantico.o nodo.o elementos_predef.o
	gcc -o analizador -lfl y.tab.o semantico.o nodo.o elementos_predef.o

y.tab.o: y.tab.c lex.yy.c
	gcc -c y.tab.c

y.tab.c: semantico.y lex.yy.c
	bison -v -d -o y.tab.c semantico.y
	
elementos_predef.o: elementos_predef.c
	gcc -c elementos_predef.c

semantico.o: semantico.c
	gcc -c semantico.c
	
nodo.o: nodo.c
	gcc -c nodo.c

lex.yy.c: especificacion.lex
	lex -l especificacion.lex

clean:
	rm -f analizador y.tab.c lex.yy.c y.output *.o
