#version 440 core
in fData {vec3 FragPos; vec3 Normal; float Area; float K; float Critic;} frag;

out vec4 FragColor;

uniform bool useLight;
uniform bool showHeight;
uniform bool showDataColors;

uniform float useDiff;
uniform float useK;
uniform float useCritic;

uniform float invCoeffArea;
uniform float invCoeffK;
uniform float invCoeffHeight;
uniform float refHeight;

uniform int nLayers;

uniform vec3 colorPol;
uniform vec3 colorVectors;

uniform vec3 lightPos; 
uniform vec3 viewPos; 
uniform vec3 lightColor;
uniform vec3 objectColor;

uniform float ambientStrength;
uniform float diffStrength;
uniform float specularStrength;
uniform float phongExp;


void main()
{
    vec3 color = objectColor;

    if (showHeight) {
        float hValue = max(frag.FragPos[1] * invCoeffHeight - refHeight * invCoeffHeight, 0.0);
        hValue = min(hValue, 1.0);
        hValue = floor(nLayers*hValue) / nLayers;

        if (hValue > 0.5) {
            color = vec3(2*hValue, 1.0, 0.0);
        } else {
            color = vec3(1.0, 2.0-2*hValue, 0.0);
        }
    } else if (showDataColors){        
        float alpha = dot(vec3(useDiff, useK, useCritic), vec3(   frag.Area * invCoeffArea, 
                                                            0.5 + useK * frag.K * invCoeffK,
                                                            frag.Critic));
        color = vec3(1.0 - alpha, 0.0, alpha);
    }

    vec3 result;

    if (useLight) {
        // ambient
        vec3 ambient = ambientStrength * lightColor;
        
        // diffuse 
        vec3 norm = normalize(frag.Normal);
        float distance = length(lightPos - frag.FragPos);
        vec3 lightDir = normalize(lightPos - frag.FragPos);
        float diff = max(dot(norm, lightDir), 0.0);
        vec3 diffuse = diffStrength * diff * lightColor;
        
        // specular
        vec3 viewDir = normalize(viewPos - frag.FragPos);
        vec3 reflectDir = reflect(-lightDir, norm);
        float spec = pow(max(dot(viewDir, reflectDir), 0.0), phongExp);
        vec3 specular = specularStrength * spec * lightColor;  
            
        result = (ambient + diffuse) * color + specular;
    } else {
        result = objectColor;
    }

    FragColor = vec4(result, 0.0);
} 
