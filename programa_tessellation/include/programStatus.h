#ifndef PROGRAM_STATUS_H
#define PROGRAM_STATUS_H

#include <iostream>
#include <fstream>
#include <glm/glm.hpp>

enum AutoParamsType {PARAM_MANUAL, PARAM_SIN, PARAM_LINEAL};

class ProgramStatus
{
	private:
		unsigned int SCR_WIDTH;
		unsigned int SCR_HEIGHT;

		std::string paramFile, dirPath, fileText, defaultText;
		std::string lastParamFile, lastParamPath;
		std::string errorFile, errorText;
		std::string frRateFile, frRateInfo;

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
		AutoParamsType autoParams[10];

		bool hasError, showError;

		bool changeWinTitle;
		bool changeSizeMap;

		bool showDiffArea, showK, showHeight, showCritic;
		bool showTangents, showCotangents, showNormals, showVectorsPerV;
		bool invertNorm;
		bool tessGlobal, tessEdge, improvePerf;
		bool recordInfo;

		float umbralLength, umbralEdge;
		int ptsLimit;
		int nPrimitives;
		
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
			frRateFile = "frameRateInfo.txt";
			frRateInfo = "";

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
			recordInfo = false;

			totalFPlot = 1;
			totalParam = 0;

			invertNorm = false;

			showTangents = showCotangents = showNormals = false;
			showVectorsPerV = false;

			showDiffArea = false;
			showK = false;
			showHeight = false;
			showCritic = false;
			tessGlobal = true;
			tessEdge = false;
			improvePerf = false;

			coeffArea = 20.0f;
			coeffK = 1.0f;
			coeffHeight = 10.0f;
			refHeight = 0.0f;
			nLayers = 10;

			umbralLength = 0.01f;
			umbralEdge = 0.1f;
			ptsLimit = 7;
			nPrimitives = 200;

			ambientStrength = 0.2f;
			diffStrength = 0.5f;
			specularStrength = 0.3f;
			phongExp = 8.0f;

			fontColor = glm::vec3(1.0f, 1.0f, 1.0f);
			
			someChange = true;

			defaultText = 	std::string("//-- Structure example with sphere parametrization --//\n\n") + 
							std::string("// Define constants \n") + 
							std::string("PI2 : real = 2*PI;\n\n") + 
							std::string("// Define aditional functions \n") + 
							std::string("compx(u, v : real) : real = cos(v*PI)*cos(u*PI2);\n") + 
							std::string("compy(u, v : real) : real = cos(v*PI)*sin(u*PI2);\n") +
							std::string("compz(u, v : real) : real = sin(v*PI);\n\n") +
							std::string("// Define de main function.\n") + 
							std::string("f(u, v : real) : vec3 = vec3(compx(u,v), compy(u,v), compz(u,v));\n\n") +
							std::string("// You can use another function to redefine the domain instead of [0,1]x[0,1].\n") +
							std::string("g(u, v : real, t0, t1 : real) : vec3 = f(t0 * (u-0.5), t1 * (v-0.5));\n\n") +
							std::string("// To plot 'g', it must return a 'vec3' type and the first two arguments must be reals.\n") +
							std::string("plot g;");
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

		void setFileTextDefault() { fileText = defaultText; saveLastParam();}
		
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
				result = result || (autoParams[i] != PARAM_MANUAL);

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

		void updateLightCoeff() {
			float totalStrength = ambientStrength + diffStrength + specularStrength + 0.01;

			ambientStrength = ambientStrength / totalStrength;
			diffStrength = diffStrength / totalStrength;
			specularStrength = specularStrength / totalStrength;
		}

		void resetShow() {
			showDiffArea = showHeight = showCritic = showK = false;
		}

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

		void saveFrRateInfo(int frRate) {
			frRateInfo = frRateInfo + std::to_string(frRate) + "\n";
		}

		void saveFrRateInfo() {
			std::ofstream offFile;

			offFile.open(frRateFile);

			if (!offFile) {
				std::cerr << "No se ha podido abrir el archivo de parametrización para escribir." << std::endl;

				return;
			}
			
			offFile << frRateInfo;
			offFile.close();

			frRateInfo = "";
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