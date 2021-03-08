
class Object {
	private:
		glm::vec3 color;
		bool colorChange;
		
	public:
		Object(glm::vec3 objColor=glm::vec3(0.1f, 0.75f, 0.1f)) {
			color = objColor;
			colorChange = false;
		}
		
		void setColor(glm::vec3 objColor) {	color = objColor; colorChange = true; }
		
		void setColorChange(bool change) { colorChange = change; }
				
		glm::vec3 getColor() { return color; }
		
		bool getColorChange() { return colorChange; }
};
