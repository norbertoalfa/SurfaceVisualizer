
bool containsZero(float a, float b, float umbral) {
    float inf, sup;
    if (a < b) {
        inf = a;
        sup = b;
    } else {
        inf = b;
        sup = a;
    }

    return  (inf <= -umbral && sup >= -umbral) ||
            (inf <=  umbral && sup >=  umbral) ||
            (inf >=  -umbral && sup <=  umbral);
}

float calculateMaxK(vec2 p1, vec2 p2){
    float maxK = 0;
    vec2 coord;

    for (int i = 0; i <= samplePts; i++) {
        coord = mix(p1, p2, i*sampleCoct); 

        maxK = max(maxK, abs(curvatureParam(coord)));
    }

    return pow(maxK, expK);
}

float maxDotLight(vec2 p1, vec2 p2){
    vec2 coord;
    float maxDot = -1.0;

    for (int i = 0; i <= samplePts; i++) {
        coord = mix(p1, p2, i*sampleCoct); 

        // Diffuse
        maxDot = max(maxDot, dot(signNormal*normalParam(coord), normalize(lightPos - functionParam(coord))));
    }

    return maxDot;
}

float bestNPtsK(vec2 p1, vec2 p2, vec3 vision1, vec3 vision2, float dotP1, float dotP2,
                float lengthReal, float umbralEye) {
    
    float maxK, maxDot = 1.0;
    float bestN = 1.0;

    bool hidden, wthLight, outVF, isEdge;

    isEdge = true;
    hidden = wthLight = outVF = false;

    if (improvePerf) {
        if (improvePerfEsp) {
            hidden = dotP1 > 0.5 && dotP2 > 0.5;
        }
        outVF = (dot(Front, vision1) > -0.8) && (dot(Front, vision2) > -0.8);

        if (!hidden && !outVF) {
            // Calculates if it is a visual edge.
            isEdge = containsZero(dotP1, dotP2, umbralEdge);

            maxDot = maxDotLight(p1, p2);
            wthLight = maxDot < -0.1;
        }
    }

    if (!outVF && !hidden && (!wthLight || isEdge )) {
        maxK = calculateMaxK(p1, p2);

        // Calculate bestN with Gauss curvature and 
        bestN = floor((maxK * lengthReal) / umbralEye) + 1.0f;
    }

    // If it's not a edge, reduce bestN
    if (!isEdge && maxDot < 0.5) {
        bestN = floor(0.667*bestN) + 1.0f;
    }

    return bestN;
}

void main(void) {
    vec2 p1, p2, p3, p_medio12,  p_medio23,  p_medio31;
    vec3 imageP1, imageP2, imageP3, imagePM12, imagePM23, imagePM31;
    vec3 vision1, vision2, vision3, visionM12, visionM23, visionM31;
    vec3 eyeDists, umbralEyes, umbralEyesM;
    
    float lengthReal12, lengthReal23, lengthReal31;
    float lengthRealM12, lengthRealM23, lengthRealM31;
    float dotP1, dotP2, dotP3, dotPM12, dotPM23, dotPM31;
    float nPts12, nPts23, nPts31, nPtsInt;

    nPts12 = nPts23 = nPts31 = nPtsInt = 1;

    if (gl_InvocationID == 0) {
        if (tessGlobal && (!showVectors || showVectorsPerV)) {
            p1 = vertex[0].Coord;
            p2 = vertex[1].Coord;
            p3 = vertex[2].Coord;

            imageP1 = functionParam(p1);
            imageP2 = functionParam(p2);
            imageP3 = functionParam(p3);

            vision1 = imageP1-viewPos;
            vision2 = imageP2-viewPos;
            vision3 = imageP3-viewPos;

            eyeDists = 0.5 * eyeMatrix * vec3(length(vision1), length(vision2), length(vision3));

            if (min(eyeDists.x, min(eyeDists.y, eyeDists.z)) < tessDist) {
                p_medio12 = p1*0.5 + p2*0.5;
                p_medio23 = p2*0.5 + p3*0.5;
                p_medio31 = p3*0.5 + p1*0.5;

                imagePM12 = functionParam(p_medio12);
                imagePM23 = functionParam(p_medio23);
                imagePM31 = functionParam(p_medio31);

                visionM12 = imagePM12-viewPos;
                visionM23 = imagePM23-viewPos;
                visionM31 = imagePM31-viewPos;

                umbralEyesM = umbralLength * 0.05 * vec3(   length(visionM12) + length(vision3),
                                                            length(visionM23) + length(vision1),
                                                            length(visionM31) + length(vision2));

                vision1 = normalize(vision1);
                vision2 = normalize(vision2);
                vision3 = normalize(vision3);
                visionM12 = normalize(visionM12);
                visionM23 = normalize(visionM23);
                visionM31 = normalize(visionM31);

                dotP1 = dot(vision1, signNormal * normalParam(p1));
                dotP2 = dot(vision2, signNormal * normalParam(p2));
                dotP3 = dot(vision3, signNormal * normalParam(p3));
                dotPM12 = dot(visionM12, signNormal * normalParam(p_medio12));
                dotPM23 = dot(visionM23, signNormal * normalParam(p_medio23));
                dotPM31 = dot(visionM31, signNormal * normalParam(p_medio31));

                lengthRealM12 = length(imagePM12 - imageP3);
                lengthRealM23 = length(imagePM23 - imageP1);
                lengthRealM31 = length(imagePM31 - imageP2);

                nPtsInt = dot(  vec3(   bestNPtsK(p1, p_medio23, vision1, visionM23, dotP1, dotPM23, lengthRealM23, umbralEyesM.y), 
                                        bestNPtsK(p2, p_medio31, vision2, visionM31, dotP2, dotPM31, lengthRealM31, umbralEyesM.z), 
                                        bestNPtsK(p3, p_medio12, vision3, visionM12, dotP3, dotPM12, lengthRealM12, umbralEyesM.x)),
                                vec3(1));
                nPtsInt = floor(nPtsInt/3.0);
            

                umbralEyes = umbralLength * 0.1 * eyeDists;

                if (eyeDists.x < tessDist) {
                    lengthReal12 = length(imageP2 - imageP1);
                    nPts12 = bestNPtsK(p1, p2, vision1, vision2, dotP1, dotP2, lengthReal12, umbralEyes.x);
                }

                if (eyeDists.y < tessDist) {
                    lengthReal23 = length(imageP3 - imageP2);
                    nPts23 = bestNPtsK(p2, p3, vision2, vision3, dotP2, dotP3, lengthReal23, umbralEyes.y);
                }

                if (eyeDists.z < tessDist) {
                    lengthReal31 = length(imageP1 - imageP3);
                    nPts31 = bestNPtsK(p3, p1, vision3, vision1, dotP3, dotP1, lengthReal31, umbralEyes.z);
                }
            }
        }

        gl_TessLevelInner[0] = nPtsInt;
        gl_TessLevelOuter[0] = nPts23;
        gl_TessLevelOuter[1] = nPts31;
        gl_TessLevelOuter[2] = nPts12;
    }

    gl_out[gl_InvocationID].gl_Position.xy = vertex[gl_InvocationID].Coord;
}