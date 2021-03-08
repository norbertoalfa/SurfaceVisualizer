
class Settings {
	private:
		unsigned int SCR_WIDTH;
		unsigned int SCR_HEIGHT;
		bool activePolMode;
		bool autoRotation;
		bool someChange;
		
	public:
		Settings(unsigned int width=800, unsigned int height=600){
			SCR_WIDTH = width;
			SCR_HEIGHT = height;
			activePolMode = false;
			autoRotation = false;
			someChange = true;
		}
		
		void setSomeChange(bool change){ someChange = change; }
		
		void setWidth(unsigned int width) { SCR_WIDTH = width; someChange = true; }
		
		void setHeight(unsigned int height) { SCR_HEIGHT = height; someChange = true; }
		
		void switchPolMode() { activePolMode = !activePolMode; }
		
		void switchAutoRot() { autoRotation = !autoRotation; }
		
		bool getActivePolMode() { return activePolMode; }
		
		bool getAutoRotation() { return autoRotation; }
		
		bool getSomeChange() { return someChange; }
		
		unsigned int getWidth() { return SCR_WIDTH; }
		
		unsigned int getHeight() { return SCR_HEIGHT; }
		
		void updateSomeChange(){
			someChange =  someChange || getActivePolMode() || getAutoRotation();
		}
};
