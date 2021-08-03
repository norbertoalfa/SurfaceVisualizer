

float triangleArea(vec3 p1, vec3 p2, vec3 p3) {
    return length(cross(p1-p3, p2-p3)) / 2.0;
}

float tetraVol(vec3 p1, vec3 p2, vec3 p3, vec3 p_medio) {
    return abs(determinant(mat3(p1-p_medio, p2-p_medio, p3-p_medio)))/6.0;
}

float calculateMaxK(vec2 p1, vec2 p2, int nIniPts){
    float maxK = 0;
    vec2 coord;

    for (int i = 0; i <= nIniPts; i++) {
        coord = ((nIniPts - i) * p1 + i * p2) / nIniPts;

        maxK = max(maxK, abs(curvatureParam(coord)));
    }

    return maxK;
}

float bestNPtsK(vec2 p1, vec2 p2) {
    float longitud = length(functionParam(p2) - functionParam(p1));

    return floor((calculateMaxK(p1, p2, ptsLimit) * longitud) / umbralLength) + 1;
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
        nPts12 = bestNPtsK(p1, p2);
        nPts23 = bestNPtsK(p2, p3);
        nPts31 = bestNPtsK(p3, p1);

        nPtsInt = bestNPtsK(p1, p_medio23);
        nPtsInt = max(nPtsInt, bestNPtsK(p2, p_medio31));
        nPtsInt = max(nPtsInt, bestNPtsK(p3, p_medio12));

        gl_TessLevelInner[0] = nPtsInt;
        gl_TessLevelOuter[0] = nPts23;
        gl_TessLevelOuter[1] = nPts31;
        gl_TessLevelOuter[2] = nPts12;
    }

    gl_out[gl_InvocationID].gl_Position = vec4(vertex[gl_InvocationID].Coord, 0.0, 0.0);
}
