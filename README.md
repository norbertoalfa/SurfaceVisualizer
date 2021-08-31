# Visualizador de superficies

## Resumen

## Instalación

### Requisitos previos

### Proceso de instalación
Clona este repositorio o descárgalo como zip. A continuación inicie la terminal en el directorio [programa](programa) y ejecute el comando:
```
make install
```
el cual actualizará las dependencias e instalará **Bison** (para el programa *procesador*). Si la instalación no ha tenido éxito deberá revisar el apartado de [requisitos previos](##requisitos-previos).

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
Al iniciarse utilizará siempre la última parametrización compilada, que se almacena en el fichero [lastParam.in](programa/variedades/lastParam.in).

En caso de tener duda con algún elemento de la interfaz, basta con mantener el ratón encima de este durante unos segundos, para que aparezca una ventana aportando información relevante.

### Controles
A continuación se indican los controles básicos de ratón y teclado.

#### Ratón
Además de interactuar con la interfaz mediante el botón izquierdo, se podrá:
- Rotar la cámara entorno a la superficie (cámara orbital).

#### Atajos de teclado


### Idioma
Se puede seleccionar el idioma que se desee, de entre los disponibles (directorio [languages](program/languages)), en la ventana **Menu** de la interfaz.

### Parametrización
Podrá seleccionar una parametrización ya definida (existen varias de ejemplo en el directorio [variedades](programa/variedades)) o crear una.

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

Todo lo que se edite en dicha ventana, tras indicar que se compile, se almacenará en el fichero [lastParam.in](programa/variedades/lastParam.in). Para guardarlo en el fichero original deberá pulsar el botón **Save**.

A parte de los parámetros obligatorios para cada carta, es posible añadir parámetros adicionales para definir homotopías (parámetros de tiempo), que se podrán mostrar como una animación fluida.

Para cambiar estos parámetros manualmente o activar las animaciones (sinusoidales o lineales) en el dominio [0,1], se debe activar la casilla **Parameters** del la ventana principal de la interfaz. De esta forma aparecerá una ventana que lista todos los parámetros adicionales, en caso de que existan.

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

### Iluminación
Se podrán modificar los coeficientes del modelo de iluminación Phong. Además, se podrá mostrar y modificar la posición de la luz (vector de luz), simplemente pinchando con el ratón sobre la ventana del vector y arrastrando (duncionalidad algo inestable).