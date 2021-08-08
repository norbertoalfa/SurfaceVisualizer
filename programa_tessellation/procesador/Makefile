.SUFFIXES:

FILE?=../variedades/lastParam.in
EXE=bin/analizador
SRC=src
OBJ=obj
FLAGS=-I./include

all: $(EXE)

read: $(FILE) $(EXE)
	script -q -c "./$(EXE) < '$(FILE)'" > ../error.log
	#./$(EXE) < '$(FILE)'

$(EXE): $(OBJ)/y.tab.o $(OBJ)/semantico.o $(OBJ)/nodo.o $(OBJ)/elementos_predef.o
	gcc -o $@ -lfl $^ $(FLAGS)

$(OBJ)/y.tab.o: $(SRC)/y.tab.c include/lex.yy.c 
	mkdir -p obj
	gcc -o $@ -c $< $(FLAGS)

$(SRC)/y.tab.c: $(SRC)/semantico.y include/lex.yy.c
	bison -v -d -o $@ $<
	
$(OBJ)/elementos_predef.o: $(SRC)/elementos_predef.c
	mkdir -p obj
	gcc -o $@ -c $< $(FLAGS)

$(OBJ)/semantico.o: $(SRC)/semantico.c
	mkdir -p obj
	gcc -o $@ -c $< $(FLAGS)
	
$(OBJ)/nodo.o: $(SRC)/nodo.c
	mkdir -p obj
	gcc -o $@ -c $< $(FLAGS)

include/lex.yy.c: $(SRC)/especificacion.lex
	lex -o $@ -l $<

clean:
	rm -rf bin/* obj/* $(SRC)/y.tab.c include/lex.yy.c $(SRC)/y.output
