#version 440 core
in fData {vec3 FragPos; vec3 Normal; float Area; float K;} frag;

out vec4 FragColor;

uniform bool showPol;
uniform bool showNormals;
uniform bool showDiffArea;
uniform bool showK;

uniform vec3 lightPos; 
uniform vec3 viewPos; 
uniform vec3 lightColor;
uniform vec3 objectColor;

uniform vec3 colorPol;
uniform vec3 colorNormals;

uniform float coeffArea;
uniform float coeffK;

uniform float ambientStrength;
uniform float diffStrength;
uniform float specularStrength;
uniform float phongExp;

void main()
{
    //FragColor = vec4(0.0, 0.0, 0.0, 1.0);
    vec3 color = objectColor;

    if (showDiffArea) {
        color = vec3(1.0 - frag.Area/coeffArea, 0.0, frag.Area/coeffArea);
    }else if (showK) {
        color = vec3(0.5 - frag.K/coeffK, 0.0, 0.5 + frag.K/coeffK);
    } else if (showPol) {
        color = colorPol;
    }

    if (showPol) {
        FragColor = vec4(color, 0.0);
    } else if (showNormals) {
        FragColor = vec4(colorNormals, 0.0);
    } else {
        float totalStrength = ambientStrength + diffStrength + specularStrength + 0.01;
        // ambient
        vec3 ambient = (ambientStrength / totalStrength) * lightColor;
        
        // diffuse 
        vec3 norm = normalize(frag.Normal);
        float distance = length(lightPos - frag.FragPos);
        vec3 lightDir = normalize(lightPos - frag.FragPos);
        float diff = max(dot(norm, lightDir), 0.0);
        vec3 diffuse = (diffStrength / totalStrength) * diff * lightColor;
        
        // specular
        vec3 viewDir = normalize(viewPos - frag.FragPos);
        vec3 reflectDir = reflect(-lightDir, norm);
        float spec = pow(max(dot(viewDir, reflectDir), 0.0), phongExp);
        vec3 specular = (specularStrength / totalStrength) * spec * lightColor;  
            
        vec3 result = (ambient + diffuse) * color + specular;
        FragColor = vec4(result, 0.0);
    }
} 
