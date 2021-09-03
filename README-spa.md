# Visualizador de superficies

## Idioma
- [Español](README-spa.md)
- [English](README.md)
---

## Índice
1. [Resumen](#resumen)
2. [Instalación](#instalacion)
    1. [Requisitos previos](#requisitos-previos)
    2. [Proceso de instalación](#proceso-de-instalacion)
3. [Uso](#uso)
    1. [Controles](#controles)
        1. [Ratón](#raton)
        2. [Atajos de teclado](#atajos-de-teclado)
    2. [Idioma](#idioma)
    3. [Parametrización](#parametrizacion)
    4. [Visualización](#visualizacion)
    5. [Iluminación](#iluminacion)
---

<a name="resumen"></a>
## Resumen
*Surface Visualizer* es un programa para visualizar variedades 2-dimensionales mediante la definición previa de sus cartas, permitiendo parámetros de tiempo para ver homotopías. Tiene como objetivo representar correctamente la superficie, haciendo uso del teselado de triángulos. 

Además, permitirá ver algunas características de la función de Morse **altura** teniendo como dominio dicha superficie (en un futuro el usurario podrá definir la función de Morse).

<a name="instalacion"></a>
## Instalación

<a name="requisitos-previos"></a>
### Requisitos previos
Estos son los requisitos previos para la instalación del programa:
- SO Ubuntu 18.04 LTS o superior (o distribuciones similares).
- GPU: compatible con versión de OpenGL 4.4 o superior (para poder usar el tessellation shader, entre otros). Se puede ver la versión actualmente instalada (después de instalar como se indica más adelante) ejecutando el comando:
```
glxinfo | grep "core profile version string"
```
- Dependencias: `make`, para poder usar el makefile y `apt` para gestionar paquetes.

Las dependencias para compilar el programa son las siguientes, aunque se actualizarán de manera automática durante el proceso de instalación:
- gcc, g++, versión 11 o superior.
- flex.
- bison, versión 3.5 o superior (archivo de instalación incluido en el directorio).
- libglapi-mesa, mesa-utils y mesa-common-dev, implementación de código abierto de OpenGL.
- libglfw3 y libglfw3-dev, para que la aplicación pueda gestionar las ventanas del sistema.

<a name="proceso-de-instalacion"></a>
### Proceso de instalación
Clona este repositorio o descárgalo como zip. A continuación inicie la terminal en el directorio [programa](program) y ejecute el comando:
```
make install
```
el cual actualizará las dependencias e instalará **Bison** (para el programa *procesador*). Si la instalación no ha tenido éxito deberá revisar el apartado de [requisitos previos](#requisitos-previos).

En caso afirmativo, finalizar compilando el programa con el comando:
```
make
```
Como consecuencia se iniciará el programa.

<a name="uso"></a>
## Uso
Una vez instalado el programa, podemos iniciarlo con el comando `make` desde el directorio [program](program) o utilizar el comando:
```
./bin/program
```
Al iniciarse utilizará siempre la última parametrización compilada, que se almacena en el fichero [lastParam.in](program/manifolds/lastParam.in).

En caso de tener duda con algún elemento de la interfaz, basta con mantener el ratón encima de este durante unos segundos, para que aparezca una ventana aportando información relevante.

<a name="controles"></a>
### Controles
A continuación se indican los controles básicos de ratón y teclado.

<a name="raton"></a>
#### Ratón
Además de interactuar con la interfaz mediante el botón izquierdo, se podrá:
- Botón derecho: rotar la cámara entorno a la superficie (cámara orbital, sentido contrario al movimiento del ratón).
- Botón izquierdo: trasladar la cámara horizontalmente y verticalmente (sentido contrario al movimiento del ratón).
- Rueda: controla el zoom.
- Botón central: reiniciar la posición de la cámara.

<a name="atajos-de-teclado"></a>
#### Atajos de teclado
Para facilitar el uso del programa se han proporcionado atajos de teclado para algunas acciones típicas:
- `LCtrl + R`: activa/desactiva el modo de rotación automática.
- `LCtrl + P`: cambia entre los modos de visualización malla y relleno.
- `LCtrl + N`: activa/desactiva la visualización de normales.
- `LCtrl + L`: ejecuta el *procesador* y compila los shaders.

<a name="idioma"></a>
### Idioma
Se puede seleccionar el idioma que se desee, de entre los disponibles (directorio [languages](program/languages)), en la ventana **Menu** de la interfaz.

<a name="parametrizacion"></a>
### Parametrización
Podrá seleccionar una parametrización ya definida (existen varias de ejemplo en el directorio [manifolds](program/manifolds)) o crear una.

Si crea una desde cero, se iniciará el editor automáticamente con un código de ejemplo, para mostrar al usuario la estructura típica del código:
```
//-- Structure example with sphere parametrization --//

// Define constants
PI2 : real = 2*PI;

// Define aditional functions
compx(u, v : real) : real = cos(v*PI)*cos(u*PI2);
compy(u, v : real) : real = cos(v*PI)*sin(u*PI2);
compz(u, v : real) : real = sin(v*PI);

// Define de main function.
f(u, v : real) : vec3 = vec3(compx(u,v), compy(u,v), compz(u,v));

// You can use another function to redefine the domain instead of [0,1]x[0,1].
g(u, v : real, t0, t1 : real) : vec3 = f(t0 * (u-0.5), t1 * (v-0.5));

// To plot 'g', it must return a 'vec3' type and the first two arguments must be reals.
plot g;
```
Dicho editor se puede abrir en cualquier momento para cambiar la definición actual de la variedad. En caso de que contenga algún error léxico, sintáctico o semántico se mostrará en un diálogo dentro de la ventana de edición (se abrirá automáticamente).

Todo lo que se edite en dicha ventana, tras indicar que se compile, se almacenará en el fichero [lastParam.in](program/manifolds/lastParam.in). Para guardarlo en el fichero original deberá pulsar el botón **Save**.

A parte de los parámetros obligatorios para cada carta, es posible añadir parámetros adicionales para definir homotopías (parámetros de tiempo), que se podrán mostrar como una animación fluida.

Para cambiar estos parámetros manualmente o activar las animaciones (sinusoidales o lineales) en el dominio [0,1], se debe activar la casilla **Parameters** del la ventana principal de la interfaz. De esta forma aparecerá una ventana que lista todos los parámetros adicionales, en caso de que existan.

<a name="visualizacion"></a>
### Visualización
Estará disponible la visualización de:
- La superficie en modo relleno, con un color plano base (por defecto).
- La superficie en modo malla, siempre en color negro.
- Los siguientes vectores, para cada vértice de la malla inicial o de la generada, según se indique:
    - Tangente
    - Bitangente
    - Normal
- Área diferencial mediante color (simulando el eje real), es decir, el área de los triángulos transformados por las cartas (no es un invariante de la superficie, depende de la parametrización escogida).
- Curvatura de Gauss mediante color, invariante de la superficie.
- Función de Morse **altura** mediante color, mostrando niveles. Se puede indicar el nº de niveles deseado.
- Puntos críticos de la función de Morse **altura**, también mediante color.

<a name="iluminacion"></a>
### Iluminación
Se podrán modificar los coeficientes del modelo de iluminación Phong. Además, se podrá mostrar y modificar la posición de la luz (vector de luz), simplemente pinchando con el ratón sobre la ventana del vector y arrastrando (duncionalidad algo inestable).