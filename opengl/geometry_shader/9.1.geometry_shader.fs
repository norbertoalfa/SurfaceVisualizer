#version 330 core
out vec4 FragColor;

//in vec3 fColor;
uniform vec3 COLOR;

void main()
{
    FragColor = vec4(COLOR, 1.0);   
}
