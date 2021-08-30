class ProgramStatus
{
	private:
		unsigned int SCR_WIDTH;
		unsigned int SCR_HEIGHT;

		int totalFPlot;
		int totalParam;

		float lastMouseX;
		float lastMouseY;
		
		bool activePolMode;
		bool autoRotation;
		bool perDisplace;
		bool perRotate;
		bool loadShader;

		bool firstMouseDetected;
		bool firstTimePressR;
		bool firstTimePressP;

		bool someChange;
		
	public:
		ProgramStatus(unsigned int width=800, unsigned int height=600)
		{
			SCR_WIDTH = width;
			SCR_HEIGHT = height;

			totalFPlot = 1;
			totalParam = 0;

			lastMouseX = width / 2.0f;
			lastMouseY = height / 2.0f;

			activePolMode = false;
			autoRotation = false;
			perDisplace = false;
			perRotate = false;
			loadShader = true;

			firstMouseDetected = true;
			firstTimePressR = false;
			firstTimePressP = false;
			
			someChange = true;
		}
		
		// Seters

		void setPerDisplace(bool pDispl){ perDisplace = pDispl; }

		void setPerRotate(bool pRotate){ perRotate = pRotate; }

		void setLoadShader(bool loadSh){ loadShader = loadSh; }

		void setFirstMouse(bool value){ firstMouseDetected = value; }

		void setFirstPressR(bool value){ firstTimePressR = value; }

		void setFirstPressP(bool value){ firstTimePressP = value; }

		void setSomeChange(bool change){ someChange = change; }
		
		void setWidth(unsigned int width) { SCR_WIDTH = width; someChange = true; }
		
		void setHeight(unsigned int height) { SCR_HEIGHT = height; someChange = true; }
		
		void setTotalFPlot(int nplot) { totalFPlot = nplot; }

		void setTotalParam(int nparam) { totalParam = nparam; }

		void setLastMouseX(float lastX) { lastMouseX = lastX; }

		void setLastMouseY(float lastY) { lastMouseY = lastY; }
		

		// Switch

		void switchPolMode() { activePolMode = !activePolMode; }
		
		void switchAutoRot() { autoRotation = !autoRotation; }
		

		// Getters

		bool getActivePolMode() { return activePolMode; }
		
		bool getAutoRotation() { return autoRotation; }

		bool getPerDisplace() { return perDisplace; }
		
		bool getPerRotate() { return perRotate; }
		
		bool getLoadShader() { return loadShader; }

		bool getFirstMouse(){ return firstMouseDetected; }

		bool getFirstPressR(){ return firstTimePressR; }

		bool getFirstPressP(){ return firstTimePressP; }
		
		bool getSomeChange() { return someChange; }
		
		unsigned int getWidth() { return SCR_WIDTH; }
		
		unsigned int getHeight() { return SCR_HEIGHT; }

		int getTotalFPlot() { return totalFPlot; }

		int getTotalParam() { return totalParam; }

		float getLastMouseX() { return lastMouseX; }

		float getLastMouseY() { return lastMouseY; }
		
		
		// Methods

		void updateSomeChange(){ someChange =  someChange || getAutoRotation(); }
};
