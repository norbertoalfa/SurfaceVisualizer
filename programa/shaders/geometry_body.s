
void genVertex(vec2 p) {
    gl_Position = projection * view * model * vec4(functionParam(p), 1.0);
    frag.FragPos = functionParam(p);
    frag.Normal = mat3(tr_inv_model) * normalParam(p);
    frag.Area = 1.0;

    EmitVertex( );
}

void genTriangle(vec2 p1, vec2 p2, vec2 p3){
    genVertex(p1);
    genVertex(p2);
    genVertex(p3);

    EndPrimitive();
}

float triangleArea(vec3 p1, vec3 p2, vec3 p3) {
    return length(cross(p1-p3, p2-p3))/2.0;
}

float tetraVol(vec3 p1, vec3 p2, vec3 p3, vec3 p_medio) {
    return abs(determinant(mat3(p1-p_medio, p2-p_medio, p3-p_medio)))/6.0;
}

/*void checkTriangle3(vec2 p1, vec2 p2, vec2 p3){
    vec2 p_medio = (p1 + p2 + p3)/3.0;
    float vol = tetraVol(functionParam(p1), functionParam(p2), functionParam(p3), functionParam(p_medio));
    
    if (vol > umbralArea) {
        genTriangle(p1, p2, p_medio);
        genTriangle(p2, p3, p_medio);
        genTriangle(p3, p1, p_medio);
    } else {
        genTriangle(p1, p2, p3);
    }
}

void checkTriangle2(vec2 p1, vec2 p2, vec2 p3){
    vec2 p_medio = (p1 + p2 + p3)/3.0;
    float vol = tetraVol(functionParam(p1), functionParam(p2), functionParam(p3), functionParam(p_medio));
    
    if (vol > umbralArea) {
        checkTriangle3(p1, p2, p_medio);
        checkTriangle3(p2, p3, p_medio);
        checkTriangle3(p3, p1, p_medio);
    } else {
        genTriangle(p1, p2, p3);
    }
}

void checkTriangle(vec2 p1, vec2 p2, vec2 p3){
    vec2 p_medio = (p1 + p2 + p3)/3.0;
    float vol = tetraVol(functionParam(p1), functionParam(p2), functionParam(p3), functionParam(p_medio));
    
    if (vol > umbralArea) {
        checkTriangle2(p1, p2, p_medio);
        checkTriangle2(p2, p3, p_medio);
        checkTriangle2(p3, p1, p_medio);
    } else {
        genTriangle(p1, p2, p3);
    }
}*/

void checkTriangle3(vec2 p1, vec2 p2, vec2 p3){
    vec2 p_medio12, p_medio23, p_medio31;
    float area12, area23, area31;

    p_medio12 = (p1 + p2)/2.0;
    p_medio23 = (p2 + p3)/2.0;
    p_medio31 = (p3 + p1)/2.0;

    area12 = triangleArea(functionParam(p1), functionParam(p2), functionParam(p_medio12));
    area23 = triangleArea(functionParam(p2), functionParam(p3), functionParam(p_medio23));
    area31 = triangleArea(functionParam(p3), functionParam(p1), functionParam(p_medio31));
    
    if (area12 > umbralArea) {
        genTriangle(p1, p_medio12, p3);
        genTriangle(p_medio12, p2, p3);
    } else if (area23 > umbralArea) {
        genTriangle(p2, p_medio23, p1);
        genTriangle(p_medio23, p3, p1);
    } else if (area31 > umbralArea) {
        genTriangle(p3, p_medio31, p2);
        genTriangle(p_medio31, p1, p2);
    } else {
        genTriangle(p1, p2, p3);
    }
}

void checkTriangle2(vec2 p1, vec2 p2, vec2 p3){
    vec2 p_medio12, p_medio23, p_medio31;
    float area12, area23, area31;

    p_medio12 = (p1 + p2)/2.0;
    p_medio23 = (p2 + p3)/2.0;
    p_medio31 = (p3 + p1)/2.0;

    area12 = triangleArea(functionParam(p1), functionParam(p2), functionParam(p_medio12));
    area23 = triangleArea(functionParam(p2), functionParam(p3), functionParam(p_medio23));
    area31 = triangleArea(functionParam(p3), functionParam(p1), functionParam(p_medio31));
    
    if (area12 > umbralArea) {
        checkTriangle3(p1, p_medio12, p3);
        checkTriangle3(p_medio12, p2, p3);
    } else if (area23 > umbralArea) {
        checkTriangle3(p2, p_medio23, p1);
        checkTriangle3(p_medio23, p3, p1);
    } else if (area31 > umbralArea) {
        checkTriangle3(p3, p_medio31, p2);
        checkTriangle3(p_medio31, p1, p2);
    } else {
        genTriangle(p1, p2, p3);
    }
}

void checkTriangle(vec2 p1, vec2 p2, vec2 p3){
    vec2 p_medio, step;
    vec2 p_medio12, p_medio23, p_medio31;
    float area12, area23, area31;
    float nPts12, nPts23, nPts31;

    p_medio = (p1 + p2 + p3)/3.0;
    p_medio12 = (p1 + p2 + p_medio)/3.0;
    p_medio23 = (p2 + p3 + p_medio)/3.0;
    p_medio31 = (p3 + p1 + p_medio)/3.0;

    area12 = triangleArea(functionParam(p1), functionParam(p2), functionParam((p1 + p2)/2.0));
    area23 = triangleArea(functionParam(p2), functionParam(p3), functionParam((p2 + p3)/2.0));
    area31 = triangleArea(functionParam(p3), functionParam(p1), functionParam((p3 + p1)/2.0));
    
    nPts12 = floor(area12 / umbralArea) + 1;
    nPts23 = floor(area23 / umbralArea) + 1;
    nPts31 = floor(area31 / umbralArea) + 1;
    
    if (nPts12 + nPts23 + nPts31 > 3) {
        step = (p2 - p1) / nPts12;

        for (int i = 0; i < nPts12; i++) {
            genTriangle(p1 + i*step, p1 + (i+1)*step, p_medio12);
        }
        
        step = (p3 - p2) / nPts23;

        for (int i = 0; i < nPts23; i++) {
            genTriangle(p2 + i*step, p2 + (i+1)*step, p_medio23);
        }
        
        step = (p1 - p3) / nPts31;

        for (int i = 0; i < nPts31; i++) {
            genTriangle(p3 + i*step, p3 + (i+1)*step, p_medio31);
        }

        genTriangle(p1, p_medio12, p_medio31);
        genTriangle(p2, p_medio23, p_medio12);
        genTriangle(p3, p_medio31, p_medio23);

        genTriangle(p_medio12, p_medio23, p_medio31);
    } else {
        genTriangle(p1, p2, p3);
    }
}

void main() {

    checkTriangle(vertices[0].Coord, vertices[1].Coord, vertices[2].Coord);

    /*for( int i=0; i<gl_in.length( ); i++ )
    {
        gl_Position = projection * view * model * gl_in[i].gl_Position;
        frag.FragPos = vertices[i].FragPos;
        frag.Normal = mat3(tr_inv_model) * vertices[i].Normal;
        frag.Area = vertices[i].Area;
        EmitVertex( );
    }

    EndPrimitive( );*/
    
}
