#ifndef OBJECT_H
#define OBJECT_H
#include <glm/glm.hpp>

class Object {
	private:
		bool colorChange;
		
	public:
		glm::vec3 color;

		Object(glm::vec3 objColor=glm::vec3(0.5f, 0.5f, 0.5f)) {
			color = objColor;
			colorChange = false;
		}
		
		void setColor(glm::vec3 objColor) {	color = objColor; colorChange = true; }
		
		void setColorChange(bool change) { colorChange = change; }
				
		glm::vec3 getColor() { return color; }
		
		bool getColorChange() { return colorChange; }
};

#endif