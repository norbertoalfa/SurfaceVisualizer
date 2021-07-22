

float triangleArea(vec3 p1, vec3 p2, vec3 p3) {
    return length(cross(p1-p3, p2-p3)) / 2.0;
}

float tetraVol(vec3 p1, vec3 p2, vec3 p3, vec3 p_medio) {
    return abs(determinant(mat3(p1-p_medio, p2-p_medio, p3-p_medio)))/6.0;
}

float calculateLength(vec2 p1, vec2 p2, int nIniPts){
    float longitud = 0;
    vec2 coord_o, coord_d;

    for (int i = 0; i < nIniPts; i++) {
        coord_o = ((nIniPts - i) * p1 + i * p2) / nIniPts;
        coord_d = ((nIniPts - i-1) * p1 + (i+1) * p2) / nIniPts;

        longitud += length(functionParam(coord_d) - functionParam(coord_o));
    }

    return longitud;
}

float bestNPts(vec2 p1, vec2 p2) {
    int fails = 0;
    int m = 1;
    float actualL = calculateLength(p1, p2, m);
    float oldL;

    oldL = calculateLength(p1, p2, 1);

    for (int i = 2; i < ptsLimit; i++) { //&& fails < failsLimit; i++) { // Para que haga menos cálculos
        if ((actualL - oldL) >= umbralLength) {
            oldL = actualL;
            m = i;
            fails++;
        } else {
            fails = 0;
        }

        actualL = calculateLength(p1, p2, i);
    }

    return m;
}

void main(void) {
    vec2 p1, p2, p3, p_medio12,  p_medio23,  p_medio31;
    float nPts12, nPts23, nPts31, nPtsInt;

    p1 = vertex[0].Coord;
    p2 = vertex[1].Coord;
    p3 = vertex[2].Coord;

    p_medio12 = (p1 + p2) / 2.0;
    p_medio23 = (p2 + p3) / 2.0;
    p_medio31 = (p3 + p1) / 2.0;

    if (gl_InvocationID == 0) {
        nPts12 = bestNPts(p1, p2);
        nPts23 = bestNPts(p2, p3);
        nPts31 = bestNPts(p3, p1);

        nPtsInt = bestNPts(p1, p_medio23);
        nPtsInt = max(nPtsInt, bestNPts(p2, p_medio31));
        nPtsInt = max(nPtsInt, bestNPts(p3, p_medio12));

        gl_TessLevelInner[0] = nPtsInt;
        gl_TessLevelOuter[0] = nPts23;
        gl_TessLevelOuter[1] = nPts31;
        gl_TessLevelOuter[2] = nPts12;
    }

    gl_out[gl_InvocationID].gl_Position = vec4(vertex[gl_InvocationID].Coord, 0.0, 0.0);
}
