# Surface Visualizer

## Language
- [Español](README-spa.md)
- [English](README.md)
---

## Table of contents
1. [Summary](#resumen)
2. [Install](#instalacion)
    1. [Previous requirements](#requisitos-previos)
    2. [Install process](#proceso-de-instalacion)
3. [Usage](#uso)
    1. [Controls](#controles)
        1. [Mouse](#raton)
        2. [Keyboard shortcuts](#atajos-de-teclado)
    2. [Language](#idioma)
    3. [Parameterization](#parametrizacion)
    4. [Visualization](#visualizacion)
    5. [Lighting](#iluminacion)
---

<a name="resumen"></a>
## Summary
*Surface Visualizer* is a program for visualizing 2-manifolds, defined with charts, allowing homotopies representation. Its objective is represent correctly the surface, using triangle tessellation. 

Also, it will show some characteristics of the Morse function **height**, which domain is this surface (in the future the user will be able to define their own Morse function).

<a name="instalacion"></a>
## Instalation

<a name="requisitos-previos"></a>
### Previous requirements
These are the previous requirements to install de program:
- Ubuntu 18.04 LTS OS or later (or similar).
- GPU: compatible with OpenGL 4.4 version or later (for tessellation shader, etc).
- Dependencies: `make`, to run makefile and `apt` to install packages.

For the compilation of the program, it will need the following dependencies, although they will be automatically upgrade during the installation process:
- gcc, g++, version 11 or later.
- flex.
- bison, version 3.5 or later (source files are included in the folder).
- libglapi-mesa, mesa-utils y mesa-common-dev, free software implementation of OpenGL.
- libglfw3 y libglfw3-dev, required for OS window management.

<a name="proceso-de-instalacion"></a>
### Install process
Clone or download this repository. Then initialize the command line in the folder [program](program) and run the following command:
```
make install
```
which will update all dependencies and install **Bison** (used on *processor* program). If the installation goes wrong, you need to review the [previous requirements](#requisitos-previos).

If the installation goes well, you must finalize installation by compiling the project, using this command:
```
make
```
As a consequence, the program will start.

<a name="uso"></a>
## Usage
After installing the program, we can start it by using `make` on the folder [program](program) or running the next command:
```
./bin/program
```
At start, it will use the last compiled parameterization, always saved on the file [lastParam.in](program/manifolds/lastParam.in).

If you don't know how some interface element works, just let the mouse over it for a few seconds and an information window will appear explaining its functionality.

<a name="controles"></a>
### Controls
In this section I will explain the basic mouse and keyboard controls.

<a name="raton"></a>
#### Mouse
In addition to interacting with the interface, you will be able to:
- Right button: rotate the camera around the surface (orbital camera).
- Left button: move the camera horizontally and vertically.
- Scroll: zoom control.
- Middle button: reset camera position.

<a name="atajos-de-teclado"></a>
#### Keyboard shortcuts
I added some shortcuts for a more comfortable use:
- `LCtrl + R`: activate/deactivate auto-rotation.
- `LCtrl + P`: switch between polygon and filled modes.
- `LCtrl + N`: activate/deactivate normal visualization.
- `LCtrl + L`: run the *processor* and compile shaders.

<a name="idioma"></a>
### Language
You can select the language you want, if it is available on the folder [languages](program/languages), on **Menu** window.

<a name="parametrizacion"></a>
### Parameterization
You will be able to select a predefined parameterization (exists some examples on the folder [manifolds](program/manifolds)) or create one.

If you decide to create one, edit window will appear with the following example code, showing a typical parameterization scheme:
```
//-- Structure example with sphere parameterization --//

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
You can open this editor whenever you want, to do some change on the actual surface's definition. If there are any errors (lexical, syntactical or semantical) it will be shown in this window.

All the changes will be automatically saved on the file [lastParam.in](program/manifolds/lastParam.in). If you want to save it in the original file, press the button **Save**.

In addition to the base params, you can use *time* parameters, which objective is to allow representations of homotopies (in a smooth animation). You can change those parameters in the **Parameters** window (fixed domain [0,1]).

<a name="visualizacion"></a>
### Visualization
You can visualize the following characteristics:
- Filled surface, with a plain base color (by default).
- Polygon mode, always in dark.
- The following vectors, for all initial mesh vertexs or all generated vertexs (it depends on the respective button):
    - Tangent
    - Bitangent
    - Normal
- Differential area, by using color (simulating the real axis), in other words, the area of the transformed triangles via the parameterization (directly depends on the parameterization).
- Gauss curvature, by using color, it not depends on the parameterization.
- Morse function **height**, by using color, showing levels. You can indicate the number of leves you want.
- Critical points of the Morse function **height**, also by using color.

<a name="iluminacion"></a>
### Lighting
You can change every Phong coefficient (from the Phong lighting model). Also you will be able to change the light position with the item **light vector** (unstable functionality).