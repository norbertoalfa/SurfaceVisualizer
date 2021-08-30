#version 440 core
layout (location = 0) in vec2 aPos;

out vData {vec2 Coord;} vertex;

void main() {
	vertex.Coord = aPos;
	gl_Position = vec4(aPos, 0.0, 0.0);
}