
class Settings {
	private:
		unsigned int SCR_WIDTH;
		unsigned int SCR_HEIGHT;
		bool activePolMode;
		bool projectionChange;
		bool viewChange;
		bool modelChange;
		bool autoRotation;
		
	public:
		Settings(unsigned int width=800, unsigned int height=600){
			SCR_WIDTH = width;
			SCR_HEIGHT = height;
			activePolMode = false;
			projectionChange = false;
			viewChange = false;
			modelChange = false;
			autoRotation = false;
		}
		
		void setViewChange() { viewChange = true; }
		
		void setWidth(unsigned int width) { SCR_WIDTH = width; projectionChange = true; }
		
		void setHeight(unsigned int height) { SCR_HEIGHT = height; projectionChange = true; }
		
		void switchPolMode() { activePolMode = !activePolMode; }
		
		void switchChProjection() { projectionChange = !projectionChange; }
		
		void switchModelChange() { modelChange = !modelChange; }
		
		void switchViewChange() { viewChange = !viewChange; }
		
		void switchAutoRot() { autoRotation = !autoRotation; }
		
		bool getActivePolMode() { return activePolMode; }
		
		bool getChProjection() { return projectionChange; }
		
		bool getViewChange() { return viewChange; }
		
		bool getModelChange() { return modelChange; }
		
		bool getAutoRotation() { return autoRotation; }
		
		unsigned int getWidth() { return SCR_WIDTH; }
		
		unsigned int getHeight() { return SCR_HEIGHT; }
};
