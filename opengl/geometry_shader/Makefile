all: bin/prueba
	./bin/prueba

bin/prueba: obj/main.o obj/glad.o
	g++ -o bin/prueba obj/main.o obj/glad.o -W -Wall -Werror -lGLEW -lglut -lglfw -lGL -ldl -I./include

obj/main.o: src/main.cpp
	g++ -o obj/main.o -c src/main.cpp -I./include 

obj/glad.o: src/glad.c
	g++ -o obj/glad.o -c src/glad.c -I./include

clean:
	rm -rf bin/* obj/*
