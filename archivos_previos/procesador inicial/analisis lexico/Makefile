all: generate_lex
	./analizador_lex < prueba.c

generate_lex: especificacion.lex
	lex -il especificacion.lex
	gcc -lfl lex.yy.c -o analizador_lex

clean:
	rm -rf lex.yy.c analizador_lex
