
class Light {
	private:
		glm::vec3 lightPos;
		glm::vec3 lightColor;
		bool posChange, colorChange;
		
	public:
		Light(glm::vec3 pos=glm::vec3(10.0f, 10.0f, 20.0f), glm::vec3 color=glm::vec3(0.75f, 0.75f, 0.75f)){
			lightPos = pos;
			lightColor = color;
			posChange = false;
			colorChange = false;
		}
		
		void setPos(glm::vec3 pos) { lightPos = pos; posChange = true; }
		
		void setColor(glm::vec3 color) { lightColor = color; colorChange = true; }
		
		void setPosChange(bool change) { posChange = change; }
		
		void setColorChange(bool change) { colorChange = change; }
		
		glm::vec3 getPos() { return lightPos; }
		
		glm::vec3 getColor() { return lightColor; }
		
		bool getPosChange() { return posChange; }
		
		bool getColorChange() { return colorChange; }
};
