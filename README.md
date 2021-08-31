# Visualizador de superficies

## Resumen

## Instalación

### Requisitos previos

### Proceso de instalación
Clona este repositorio o descárgalo como zip. A continuación inicia la terminal en el directorio [programa](programa) y ejecuta el comando:
```
make install
```
el cual actualizará las dependencias e instalará **Bison** (para el programa *procesador*). Si la instalación no ha tenido éxito debería revisar el apartado de [requisitos previos](##requisitos-previos).
En caso afirmativo, finalizar compilando el programa con el comando:
```
make
```
Como consecuencia se iniciará el programa.

## Uso
Una vez instalado el programa, podemos iniciarlo con el comando `make` desde el directorio [programa](programa) o utilizar el comando:
```
./bin/program
```
Al iniciarse utilizará siempre la última parametrización procesada con éxito, que se almacena en el fichero [lastParam.in](programa/variedades/lastParam.in).
Se puede seleccionar el idioma que se desee, de entre los disponibles (directorio [languages](program/languages)), en la ventana **Menu** de la interfaz.