#ifndef PROGRAM_STATUS_H
#define PROGRAM_STATUS_H

#include <iostream>
#include <fstream>
#include <glm/glm.hpp>

class ProgramStatus
{
	private:
		unsigned int SCR_WIDTH;
		unsigned int SCR_HEIGHT;

		std::string paramFile, dirPath, fileText;
		std::string lastParamFile, lastParamPath;
		std::string errorFile, errorText;

		int sizeMap;

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
		bool firstTimePress[91];

		bool someChange;
		
	public:
		float params[10];
		bool autoParams[10];

		bool hasError, showError;

		bool changeWinTitle;
		bool changeSizeMap;

		bool showDiffArea, showK, showHeight, showCritic;
		bool showTangents, showCotangents, showNormals;
		bool invertNorm;
		bool tessGlobal, tessEdge;

		float umbralLength, umbralEdge;
		int ptsLimit;
		int failsLimit;
		
		float coeffArea, coeffK, coeffHeight;
		float refHeight;
		int nLayers;

		float ambientStrength, diffStrength, specularStrength, phongExp;

		glm::vec3 fontColor;


		ProgramStatus(unsigned int width=1280, unsigned int height=720)
		{
			SCR_WIDTH = width;
			SCR_HEIGHT = height;

			sizeMap = 10;

			lastParamPath = "variedades";
			lastParamFile = "lastParam.in";

			dirPath = "variedades";
			paramFile = "lastParam.in";
			errorFile = "error.log";
			changeWinTitle = true;
			changeSizeMap = false;
			hasError = showError = false;

			if (loadText() == -1) {
				paramFile = "toro.in";
				loadText();
			}

			lastMouseX = width / 2.0f;
			lastMouseY = height / 2.0f;

			firstMouseDetected = true;
			
			for (int i = 0; i < 91; i++) {
				firstTimePress[i] = false;
			}

			activePolMode = false;
			autoRotation = false;
			perDisplace = false;
			perRotate = false;
			loadShader = true;

			totalFPlot = 1;
			totalParam = 0;

			invertNorm = false;

			showTangents = showCotangents = showNormals = false;

			showDiffArea = false;
			showK = false;
			showHeight = false;
			showCritic = false;
			tessGlobal = true;
			tessEdge = false;

			coeffArea = 20.0f;
			coeffK = 1.0f;
			coeffHeight = 10.0f;
			refHeight = 0.0f;
			nLayers = 10;

			umbralLength = 0.01f;
			umbralEdge = 0.1f;
			ptsLimit = 20;
			failsLimit = 5;

			ambientStrength = 0.2f;
			diffStrength = 0.5f;
			specularStrength = 0.3f;
			phongExp = 8.0f;

			fontColor = glm::vec3(1.0f, 1.0f, 1.0f);
			
			someChange = true;
		}
		
		// Seters

		void setPerDisplace(bool pDispl){ perDisplace = pDispl; }

		void setPerRotate(bool pRotate){ perRotate = pRotate; }

		void setLoadShader(bool loadSh){ loadShader = loadSh; }

		void setFirstMouse(bool value){ firstMouseDetected = value; }

		void setFirstPress(char c, bool value){ firstTimePress[c] = value; }

		void setSomeChange(bool change){ someChange = change; }

		void setSizeMap(int n) { sizeMap = n; }
		
		void setWidth(unsigned int width) { SCR_WIDTH = width; someChange = true; }
		
		void setHeight(unsigned int height) { SCR_HEIGHT = height; someChange = true; }
		
		void setParamFile(std::string file) { paramFile = file; changeWinTitle = true; someChange = true; }

		void setParamPath(std::string path) { dirPath = path; }
		
		void setFileText(std::string text) { fileText = text; saveLastParam();}
		
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

		int getSizeMap() { return sizeMap; }
		
		unsigned int getWidth() { return SCR_WIDTH; }
		
		unsigned int getHeight() { return SCR_HEIGHT; }
		
		std::string getParamFile() { return paramFile; }
		
		std::string getParamPath() { return dirPath; }
		
		std::string getLastParamFile() { return lastParamFile; }
		
		std::string getLastParamPath() { return lastParamPath; }
		
		std::string getFileText() { return fileText; }
		
		std::string getErrorText() { return errorText; }

		int getTotalFPlot() { return totalFPlot; }

		int getTotalParam() { return totalParam; }

		float getLastMouseX() { return lastMouseX; }

		float getLastMouseY() { return lastMouseY; }
		
		
		// Methods

		void updateShowK() {
			showDiffArea = showHeight = showCritic = false;
		}

		void updateShowArea() {
			showK = showHeight = showCritic = false;
		}

		void updateShowHeight() {
			showDiffArea = showK = showCritic = false;
		}

		void updateShowCritic() {
			showDiffArea = showK = showHeight = false;
		}

		int checkErrorLog() {
			std::ifstream inFile;
			std::string data;
			int retCode = 1;

			hasError = showError = false;

			inFile.open(errorFile);

			if (inFile) {
				errorText = "";

				while (std::getline(inFile, data)) {
					hasError = showError = true;
					retCode = -1;
					errorText += data + "\n";
				}
			} else {
				retCode = -1;
			}

			inFile.close();

			return retCode;
		}

		int loadText(){
			std::ifstream inFile;
			std::string data;

			inFile.open(dirPath + "/" + paramFile);

			if (!inFile) {
				std::cerr << "No se ha podido abrir el archivo de parametrización para leer " << dirPath << "/" << paramFile <<std::endl;

				return -1;
			}

			fileText = "";

			while (std::getline(inFile, data)) {
				fileText += data + "\n";
			}

			inFile.close();

			return 1;
		}

		int saveLastParam(){
			return saveText(lastParamPath, lastParamFile);
		}

		int saveText(){
			return saveText(dirPath, paramFile);
		}

		int saveText(std::string path, std::string file){
			std::ofstream offFile;

			offFile.open(path + "/" + file);

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