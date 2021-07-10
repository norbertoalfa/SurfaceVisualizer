#version 440
layout (triangles) in;
layout (triangle_strip, max_vertices = 3) out;

in vData {vec3 FragPos; vec3 Normal; float Area;} vertices[];

out fData {vec3 FragPos; vec3 Normal; float Area;} frag;

uniform mat4 model;
uniform mat4 view;
uniform mat4 projection;

void main() {

    for( int i=0; i<gl_in.length( ); i++ )
    {
        gl_Position = projection * view * model * gl_in[i].gl_Position;
        frag.FragPos = vertices[i].FragPos;
        frag.Normal = mat3(transpose(inverse(model))) * vertices[i].Normal;
        frag.Area = vertices[i].Area;
        EmitVertex( );
    }

    EndPrimitive( );
    
}
