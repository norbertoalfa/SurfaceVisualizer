
class Object {
	private:
		glm::vec3 color;
		bool colorChange;
		
	public:
		Object(glm::vec3 objColor=glm::vec3(0.5f, 0.5f, 0.5f)) {
			color = objColor;
			colorChange = false;
		}
		
		void setColor(glm::vec3 objColor) {	color = objColor; colorChange = true; }
		
		void setColorChange(bool change) { colorChange = change; }
				
		glm::vec3 getColor() { return color; }
		
		bool getColorChange() { return colorChange; }
};
