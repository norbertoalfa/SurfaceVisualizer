

float triangleArea(vec3 p1, vec3 p2, vec3 p3) {
    return length(cross(p1-p3, p2-p3))/2.0;
}

float tetraVol(vec3 p1, vec3 p2, vec3 p3, vec3 p_medio) {
    return abs(determinant(mat3(p1-p_medio, p2-p_medio, p3-p_medio)))/6.0;
}

void main(void) {
    vec2 p1, p2, p3, p_medio;
    float area12, area23, area31;
    float nPts12, nPts23, nPts31;

    p1 = vertex[0].Coord;
    p2 = vertex[1].Coord;
    p3 = vertex[2].Coord;

    p_medio = (p1 + p2 + p3)/3.0;

    area12 = triangleArea(functionParam(p1), functionParam(p2), functionParam((p1 + p2)/2.0));
    area23 = triangleArea(functionParam(p2), functionParam(p3), functionParam((p2 + p3)/2.0));
    area31 = triangleArea(functionParam(p3), functionParam(p1), functionParam((p3 + p1)/2.0));
    
    nPts12 = floor(area12 / umbralArea) + 1;
    nPts23 = floor(area23 / umbralArea) + 1;
    nPts31 = floor(area31 / umbralArea) + 1;

    if (gl_InvocationID == 0) {
        gl_TessLevelInner[0] = max(nPts12, max(nPts23, nPts31));
        gl_TessLevelOuter[0] = nPts23;
        gl_TessLevelOuter[1] = nPts31;
        gl_TessLevelOuter[2] = nPts12;
    }

    gl_out[gl_InvocationID].gl_Position = vec4(vertex[gl_InvocationID].Coord, 0.0, 0.0); //gl_in[gl_InvocationID].gl_Position;

    control[gl_InvocationID].FragPos = vertex[gl_InvocationID].FragPos;
    control[gl_InvocationID].Normal = vertex[gl_InvocationID].Normal;
}
