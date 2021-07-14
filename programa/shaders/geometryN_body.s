
void main() {

    for( int i=0; i<gl_in.length( ); i++ )
    {
        gl_Position = projection * view * model * gl_in[i].gl_Position;
        frag.FragPos = vertices[i].FragPos;
        frag.Normal = mat3(transpose(inverse(model))) * vertices[i].Normal;
        EmitVertex( );

        gl_Position = projection * view * model *(gl_in[i].gl_Position + vec4(vertices[i].Normal*0.1, 0.0));
        frag.FragPos = vertices[i].FragPos;
        frag.Normal = mat3(transpose(inverse(model))) * vertices[i].Normal;
        EmitVertex( );
    }

    EndPrimitive( );
    
}
