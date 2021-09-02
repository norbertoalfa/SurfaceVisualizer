
#include "programStatus.h"


ProgramStatus::ProgramStatus(unsigned int width, unsigned int height)
{
	SCR_WIDTH = width;
	SCR_HEIGHT = height;

	sizeMap = 10;

	languagePath = "languages";
	actualLan = 0;
	updateLanguages();

	lastParamPath = "manifolds";
	lastParamFile = "lastParam.in";

	dirPath = "manifolds";
	paramFile = "lastParam.in";
	errorFile = "error.log";
	frRateFile = "frameRateInfo.txt";
	frRateInfo = "";

	changeWinTitle = true;
	changeSizeMap = false;
	hasError = showError = false;

	loadTextInterface();

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
	improvePerf = true;
	improvePerfEsp = false;
	autoUmbral = false;

	depth = 100.0f;
	near = 0.1f;
	fovy = glm::radians(45.0f);
	updateFovs();

	coeffArea = 20.0f;
	coeffK = 1.0f;
	coeffHeight = 10.0f;
	refHeight = 0.0f;
	nLayers = 10;

	tessDist = 25.0f;
	umbralLength = 0.01f;
	umbralEdge = 0.5f;
	expK = 0.25;
	lambda = 0.00005f;

	minLength = 0.000001f;
	maxLength = 0.05f;

	ptsLimit = 20;
	samplePts = 10;
	nPrimitives = 200;
	targetNP = 300000;

	ambientStrength = 0.2f;
	diffStrength = 0.5f;
	specularStrength = 0.3f;
	phongExp = 8.0f;

	fontColor = glm::vec3(1.0f, 1.0f, 1.0f);
	
	someChange = true;

	defaultText = 	std::string("//-- Structure example with sphere parameterization --//\n\n") + 
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

void ProgramStatus::updateLanguages() {
	DIR *dir;
	struct dirent *ent;

	nLanguages = 0;

	if ((dir = opendir (languagePath.c_str())) != NULL) {
		while ((ent = readdir (dir)) != NULL) {
			if (std::string(ent->d_name).compare(".") != 0 && std::string(ent->d_name).compare("..") != 0) {
				languages[nLanguages] = std::string(ent->d_name);
				languages[nLanguages] = languages[nLanguages].substr(0, languages[nLanguages].length() - 4);
				nLanguages++;
			}
		}
		closedir (dir);
	} else {
		perror("Error al leer el directorio.");
	}
}
		
bool ProgramStatus::getSomeAutoParam() {
	bool result = false;
	
	for(int i = 0; i < 10; i++) 
		result = result || (autoParams[i] != PARAM_MANUAL);

	return result;
}

void ProgramStatus::updateFovs() {
	float altura = 2 * near * tan(fovy*0.5);
	float base = altura * SCR_WIDTH / SCR_HEIGHT;
	float diagonal = pow(base*base + altura*altura, 0.5);

	fovx = 2 * atan(base * 0.5 / near);
	fovd = 2 * atan(diagonal*0.5 / near);
	dotVF = -cos(fovd*0.5); //-0.73;
}

void ProgramStatus::improveUmbral() {
	float diff = nPrimitives / ((float) targetNP) - 1.0;

	umbralLength += lambda*diff;
	umbralLength = std::max(umbralLength, minLength);
	umbralLength = std::min(umbralLength, maxLength);

	setSomeChange(true);
}

void ProgramStatus::updateLightCoeff() {
	float totalStrength = ambientStrength + diffStrength + specularStrength + 0.01;

	ambientStrength = ambientStrength / totalStrength;
	diffStrength = diffStrength / totalStrength;
	specularStrength = specularStrength / totalStrength;
}

int ProgramStatus::checkErrorLog() {
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

int ProgramStatus::loadTextInterface(){
	std::ifstream inFile;
	std::string label, data;

	inFile.open(languagePath + "/" + languages[actualLan] + ".txt");

	if (!inFile) {
		std::cerr << "No se ha podido abrir el archivo de parametrización para leer " << languagePath << "/" << languages[actualLan] << ".txt" <<std::endl;

		return -1;
	}

	fileText = "";

	while (inFile >> label && std::getline(inFile, data)) {
		data.erase(remove(data.begin(), data.end(), '\t'), data.end());
		textInterface[label] = data;
	}

	inFile.close();

	return 1;
}

int ProgramStatus::loadText(){
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

void ProgramStatus::saveFrRateInfo(int frRate, int nTriangles) {
	frRateInfo = frRateInfo + std::to_string(frRate) + "\t" + std::to_string(nTriangles) + "\n";
}

void ProgramStatus::saveFrRateInfo() {
	std::ofstream offFile;
	std::string name = "fr"  + std::to_string(sizeMap) + "_" + paramFile.substr(0, paramFile.size()-3) + "_";

	if (activePolMode) {
		name += "pol_";
	} else {
		name += "filled_";
	}

	if (improvePerf){
		if (improvePerfEsp) {
			name += "improve2.txt";
		} else {
			name += "improve1.txt";
		}
	} else {
		name += "bad.txt";
	}

	offFile.open(name);

	if (!offFile) {
		std::cerr << "No se ha podido abrir el archivo de parametrización para escribir." << std::endl;

		return;
	}
	
	offFile << frRateInfo;
	offFile.close();

	frRateInfo = "";
}

int ProgramStatus::saveText(std::string path, std::string file){
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