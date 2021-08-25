#ifndef PROGRAM_STATUS_H
#define PROGRAM_STATUS_H

#include <iostream>
#include <map>
#include <math.h>
#include <algorithm>
#include <fstream>
#include <glm/glm.hpp>

enum AutoParamsType {PARAM_MANUAL, PARAM_SIN, PARAM_LINEAL};

class ProgramStatus
{
	private:
		std::string paramFile, dirPath, fileText, defaultText;
		std::string lastParamFile, lastParamPath;
		std::string errorFile, errorText;
		std::string frRateFile, frRateInfo;
		std::string language, languagePath;
		std::map<std::string, std::string> textInterface;

		float lastMouseX;
		float lastMouseY;

		unsigned int SCR_WIDTH;
		unsigned int SCR_HEIGHT;

		int sizeMap;

		int totalFPlot;
		int totalParam;
		
		bool activePolMode;
		bool autoRotation;
		bool perDisplace;
		bool perRotate;
		bool loadShader;

		bool firstMouseDetected;
		bool firstTimePress[91];

		bool someChange;
		
	public:
		AutoParamsType autoParams[10];
		
		glm::vec3 fontColor;

		float params[10];

		float fovx, fovy, fovd, depth, near, dotVF;

		float ambientStrength, diffStrength, specularStrength, phongExp;

		float umbralLength, umbralEdge, expK, lambda;
		float minLength, maxLength;
		float tessDist;

		float coeffArea, coeffK, coeffHeight;
		float refHeight;

		int ptsLimit, samplePts;
		int nPrimitives, targetNP;
		int nLayers;

		bool hasError, showError;

		bool changeWinTitle;
		bool changeSizeMap;

		bool showDiffArea, showK, showHeight, showCritic;
		bool showTangents, showCotangents, showNormals, showVectorsPerV;
		bool tessGlobal, tessEdge, improvePerf, improvePerfEsp;
		bool invertNorm;
		bool recordInfo;
		bool autoUmbral;


		ProgramStatus(unsigned int width=1280, unsigned int height=720);
		
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
		
		void setLanguage(std::string lang) { language = lang; loadTextInterface(); }

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
		
		bool getSomeAutoParam();

		int getSizeMap() { return sizeMap; }
		
		unsigned int getWidth() { return SCR_WIDTH; }
		
		unsigned int getHeight() { return SCR_HEIGHT; }
		
		std::string getLanguage() { return language; }

		std::string getText(std::string label) { return textInterface[label]; }
		
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

		void updateFovs();

		void improveUmbral();

		void updateLightCoeff();

		void resetShow() { showDiffArea = showHeight = showCritic = showK = false; }

		void updateShowK() { showDiffArea = showHeight = showCritic = false; }

		void updateShowArea() { showK = showHeight = showCritic = false; }

		void updateShowHeight() { showDiffArea = showK = showCritic = false; }

		void updateShowCritic() { showDiffArea = showK = showHeight = false; }

		int checkErrorLog();

		int loadTextInterface();

		int loadText();

		void saveFrRateInfo(int frRate, int nTriangles);

		void saveFrRateInfo();

		int saveLastParam(){ return saveText(lastParamPath, lastParamFile); }

		int saveText(){ return saveText(dirPath, paramFile); }

		int saveText(std::string path, std::string file);

		void updateSomeChange(){ someChange =  someChange || getAutoRotation() || getSomeAutoParam(); }
};

#endif