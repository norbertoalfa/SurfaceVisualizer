#version 440 core
layout (location = 0) in vec2 aPos;

out vData {vec2 Coord;} vertex;

void main() {
	vertex.Coord = aPos;
}