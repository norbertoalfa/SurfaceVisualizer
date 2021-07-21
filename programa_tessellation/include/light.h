
#ifndef LIGHT_H
#define LIGHT_H

class Light {
	private:
		glm::vec3 lightDir;
		glm::vec3 lightPos;
		glm::vec3 lightColor;
		float lightDist;
		bool posChange, colorChange;
		
	public:
		Light(glm::vec3 pos=glm::vec3(0.5f, 0.5f, 1.0f), glm::vec3 color=glm::vec3(0.75f, 0.75f, 0.75f)){
			lightDist = 2000.0;
			lightDir = glm::normalize(pos);
			lightPos = lightDir * lightDist;
			lightColor = color;
			posChange = false;
			colorChange = false;
		}
		
		void setDist(float d) { lightDist = d; lightPos = lightDir * lightDist; posChange = true; }
		
		void setDir(glm::vec3 dir) {
			lightDir = dir;
			lightPos = lightDir * lightDist;
			posChange = true;
		}
		
		void setPos(glm::vec3 pos) {
			lightPos = pos;
			lightDir = glm::normalize(pos); 
			lightDist = glm::length(pos); 
			posChange = true;
		}
		
		void setColor(glm::vec3 color) { lightColor = color; colorChange = true; }
		
		void setPosChange(bool change) { posChange = change; }
		
		void setColorChange(bool change) { colorChange = change; }
		
		glm::vec3 getDir() { return lightDir; }
		
		glm::vec3 getPos() { return lightPos; }
		
		glm::vec3 getColor() { return lightColor; }
		
		bool getPosChange() { return posChange; }
		
		bool getColorChange() { return colorChange; }
};

#endif