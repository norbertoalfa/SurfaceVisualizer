#ifndef PROGRAM_STATUS_H
#define PROGRAM_STATUS_H

#include <iostream>
#include <fstream>

class ProgramStatus
{
	private:
		unsigned int SCR_WIDTH;
		unsigned int SCR_HEIGHT;

		std::string paramFile, fileText;

		int totalFPlot;
		int totalParam;

		float lastMouseX;
		float lastMouseY;
		
		bool activePolMode;
		bool showNormals;
		bool autoRotation;
		bool perDisplace;
		bool perRotate;
		bool loadShader;

		bool firstMouseDetected;
		bool firstTimePress[91];

		bool someChange;
		
	public:
		float params[10];
		bool autoParams[10];
		
		float coeffArea;
		float umbralArea;
		bool showDiffArea;

		ProgramStatus(unsigned int width=1280, unsigned int height=720)
		{
			SCR_WIDTH = width;
			SCR_HEIGHT = height;

			paramFile = "parametrizacion.in";
			loadText();

			totalFPlot = 1;
			totalParam = 0;

			lastMouseX = width / 2.0f;
			lastMouseY = height / 2.0f;

			coeffArea = 20.0f;
			umbralArea = 0.5f;
			coeffArea = false;

			activePolMode = false;
			showNormals = false;
			autoRotation = false;
			perDisplace = false;
			perRotate = false;
			loadShader = true;

			firstMouseDetected = true;
			
			for (int i = 0; i < 91; i++) {
				firstTimePress[i] = false;
			}
			
			someChange = true;
		}
		
		// Seters

		void setPerDisplace(bool pDispl){ perDisplace = pDispl; }

		void setPerRotate(bool pRotate){ perRotate = pRotate; }

		void setLoadShader(bool loadSh){ loadShader = loadSh; }

		void setFirstMouse(bool value){ firstMouseDetected = value; }

		void setFirstPress(char c, bool value){ firstTimePress[c] = value; }

		void setSomeChange(bool change){ someChange = change; }
		
		void setWidth(unsigned int width) { SCR_WIDTH = width; someChange = true; }
		
		void setHeight(unsigned int height) { SCR_HEIGHT = height; someChange = true; }
		
		void setParamFile(std::string file) { paramFile = file; someChange = true; }

		void setFileText(std::string text) { fileText = text; }
		
		void setTotalFPlot(int nplot) { totalFPlot = nplot; }

		void setTotalParam(int nparam) { totalParam = nparam; }

		void setLastMouseX(float lastX) { lastMouseX = lastX; }

		void setLastMouseY(float lastY) { lastMouseY = lastY; }
		

		// Switch

		void switchPolMode() { activePolMode = !activePolMode; }

		void switchShowNormals() { showNormals = !showNormals; }
		
		void switchAutoRot() { autoRotation = !autoRotation; }
		

		// Getters

		bool getActivePolMode() { return activePolMode; }

		bool getShowNormals() { return showNormals; }
		
		bool getAutoRotation() { return autoRotation; }

		bool getPerDisplace() { return perDisplace; }
		
		bool getPerRotate() { return perRotate; }
		
		bool getLoadShader() { return loadShader; }

		bool getFirstMouse(){ return firstMouseDetected; }

		bool getFirstPress(char c){ return firstTimePress[c]; }
		
		bool getSomeChange() { return someChange; }
		
		bool getSomeAutoParam() {
			bool result = false;
			
			for(int i = 0; i < 10; i++) 
				result = result || autoParams[i];

			return result;
		}
		
		unsigned int getWidth() { return SCR_WIDTH; }
		
		unsigned int getHeight() { return SCR_HEIGHT; }
		
		std::string getParamFile() { return paramFile; }
		
		std::string getFileText() { return fileText; }

		int getTotalFPlot() { return totalFPlot; }

		int getTotalParam() { return totalParam; }

		float getLastMouseX() { return lastMouseX; }

		float getLastMouseY() { return lastMouseY; }
		
		
		// Methods

		int loadText(){
			std::ifstream inFile;
			std::string data;

			inFile.open(paramFile);

			if (!inFile) {
				std::cerr << "No se ha podido abrir el archivo de parametrización para leer." << std::endl;

				return -1;
			}

			fileText = "";

			while (std::getline(inFile, data)) {
				fileText += data + "\n";
			}

			inFile.close();

			return 1;
		}

		int saveText(){
			std::ofstream offFile;

			offFile.open(paramFile);

			if (!offFile) {
				std::cerr << "No se ha podido abrir el archivo de parametrización para escribir." << std::endl;

				return -1;
			}
			
			offFile << fileText;
			offFile.close();

			return 1;
		}

		void updateSomeChange(){ someChange =  someChange || getAutoRotation() || getSomeAutoParam(); }
};

#endif