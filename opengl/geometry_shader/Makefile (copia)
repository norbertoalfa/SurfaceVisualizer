all: shader prueba
	
	
prueba: bin/prueba
	./bin/prueba

bin/prueba: obj/main.o obj/glad.o
	g++ -o bin/prueba obj/main.o obj/glad.o -W -Wall -Werror -lGLEW -lglut -lglfw -lGL -ldl -I./include

obj/main.o: src/main.cpp include/settings.h include/camera.h include/object.h include/light.h
	g++ -o obj/main.o -c src/main.cpp -I./include 

obj/glad.o: src/glad.c
	g++ -o obj/glad.o -c src/glad.c -I./include
	
shader: parametrizacion.in
	cd ./procesador/ && $(MAKE)
	cd ..

clean:
	rm -rf bin/* obj/*
	cd ./procesador/ && $(MAKE) clean
	cd ..
