#version 440 core
in fData {vec3 FragPos; vec3 Normal; float Area;} frag;

out vec4 FragColor;
  
uniform vec3 lightPos; 
uniform vec3 viewPos; 
uniform vec3 lightColor;
uniform vec3 objectColor;
uniform float coeffArea;
uniform bool showPol;
uniform bool showNormals;
uniform bool showDiffArea;
uniform vec3 colorPol;
uniform vec3 colorNormals;

void main()
{
    //FragColor = vec4(0.0, 0.0, 0.0, 1.0);
    vec3 color = objectColor;

    if (showDiffArea) {
        color = vec3(1.0 - frag.Area/coeffArea, 0.0, frag.Area/coeffArea);
    } else if (showPol) {
        color = colorPol;
    }

    if (showPol) {
        FragColor = vec4(color, 0.0);
    } else if (showNormals) {
        FragColor = vec4(colorNormals, 0.0);
    } else if (showDiffArea) {
        FragColor = vec4(color, 0.0);
    } else {
        // ambient
        float ambientStrength = 0.4;
        vec3 ambient = ambientStrength * lightColor;
        
        // diffuse 
        vec3 norm = normalize(frag.Normal);
        float distance = length(lightPos - frag.FragPos);
        vec3 lightDir = normalize(lightPos - frag.FragPos);
        float diff = max(dot(norm, lightDir), 0.0);
        vec3 diffuse = diff * lightColor;
        
        // specular
        float specularStrength = 0.5;
        vec3 viewDir = normalize(viewPos - frag.FragPos);
        vec3 reflectDir = reflect(-lightDir, norm);
        float spec = pow(max(dot(viewDir, reflectDir), 0.0), 4);
        vec3 specular = specularStrength * spec * lightColor;  
            
        vec3 result = (ambient + diffuse + specular) * color;
        FragColor = vec4(result, 0.0);
    }
} 
