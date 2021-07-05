#include "interface.h"

#include <stdio.h>
#include <iostream>
#include <fstream>

#include <glad/glad.h>
#include <GLFW/glfw3.h>
#include <GL/glut.h>
#include <GL/gl.h>

#include <glm/glm.hpp>
#include <glm/gtc/matrix_transform.hpp>
#include <glm/gtc/type_ptr.hpp>

#include <shader.h>
#include <camera.h>
#include <programStatus.h>
#include <light.h>
#include <object.h>

std::fstream temp_file;

// Status
ProgramStatus status;

// Camera
Camera camera(glm::vec3(0.0f,0.0f,0.0f));
Light light;
Object object;
Shader *shader, *shaderNormals;

// timing
float deltaTime = 0.0f;
float lastFrame = 0.0f;

// Uniforms to pass
glm::mat4 projection = glm::perspective(glm::radians(45.0f), (float)status.getWidth() / (float)status.getHeight(), 0.1f, 100.0f);
glm::mat4 view = camera.getViewMatrix();
glm::mat4 model = glm::mat4(1.0f);
GLfloat params[10];

const int SIZE = 40;
const int SIZE_POINT = 2;
float step = 1.0/((float) SIZE);

const int N_SAMPLES = 4; // Nº de muestras para el multi-sampling

// Variables
GLFWwindow* window;
float vertex[2*(SIZE+1)*(SIZE+1) +2];
unsigned int indices[6*SIZE*SIZE];
unsigned int VBO, VAO, EBO;


// Functions

static void glfw_error_callback(int error, const char* description)
{
    fprintf(stderr, "Glfw Error %d: %s\n", error, description);
}

// process all input: query GLFW whether relevant keys are pressed/released this frame and react accordingly
// ---------------------------------------------------------------------------------------------------------
void processKeyInput(GLFWwindow* window, int key, int scancode, int action, int mods)
{
    if (glfwGetKey(window, GLFW_KEY_ESCAPE) == GLFW_PRESS) {
        glfwSetWindowShouldClose(window, true);
    }
        
    if (glfwGetKey(window, GLFW_KEY_W) == GLFW_PRESS) {
    	camera.processKeyboard(FORWARD, deltaTime);
    	status.setSomeChange(true);
	}
	
    if (glfwGetKey(window, GLFW_KEY_S) == GLFW_PRESS) {
    	camera.processKeyboard(BACKWARD, deltaTime);
    	status.setSomeChange(true);
	}
	
    if (glfwGetKey(window, GLFW_KEY_A) == GLFW_PRESS) {
    	camera.processKeyboard(LEFT, deltaTime);
    	status.setSomeChange(true);
    }
    
    if (glfwGetKey(window, GLFW_KEY_D) == GLFW_PRESS) {
    	camera.processKeyboard(RIGHT, deltaTime);
    	status.setSomeChange(true);
    }
    
    if (glfwGetKey(window, GLFW_KEY_R) == GLFW_PRESS) {
    	status.setFirstPress('R', true);
    	status.setSomeChange(true);
    }
    
    if (glfwGetKey(window, GLFW_KEY_P) == GLFW_PRESS) {
		status.setFirstPress('P', true);
		status.setSomeChange(true);
    }
    
    if (glfwGetKey(window, GLFW_KEY_N) == GLFW_PRESS) {
		status.setFirstPress('N', true);
		status.setSomeChange(true);
    }
    
    if (glfwGetKey(window, GLFW_KEY_R) == GLFW_RELEASE) {
    	if (status.getFirstPress('R')) {
    		status.switchAutoRot();
    		status.setFirstPress('R', false);
    	}
    }
    
    if (glfwGetKey(window, GLFW_KEY_P) == GLFW_RELEASE) {
    	if (status.getFirstPress('P')) {
    		status.switchPolMode();
    		status.setFirstPress('P', false);
    		status.setSomeChange(true);
    	}
    }
    
    if (glfwGetKey(window, GLFW_KEY_N) == GLFW_RELEASE) {
    	if (status.getFirstPress('N')) {
    		status.switchShowNormals();
    		status.setFirstPress('N', false);
    		status.setSomeChange(true);
    	}
    }
    
    if (glfwGetKey(window, GLFW_KEY_L) == GLFW_PRESS) {
    	status.setLoadShader(true);
    	status.setSomeChange(true);
    }
}

void processMouseKey(GLFWwindow* window, int button, int action, int mods)
{
    if (!ImGui::IsAnyWindowHovered()) {
        if (glfwGetMouseButton(window, GLFW_MOUSE_BUTTON_LEFT) == GLFW_PRESS) {
            status.setPerDisplace(true);
            status.setSomeChange(true);
        }
        
        if (glfwGetMouseButton(window, GLFW_MOUSE_BUTTON_RIGHT) == GLFW_PRESS) {
            status.setPerRotate(true);
            status.setSomeChange(true);
        }
        
        if (glfwGetMouseButton(window, GLFW_MOUSE_BUTTON_MIDDLE) == GLFW_PRESS) {
            camera.reset();
            status.setSomeChange(true);
        }
    }

    if (glfwGetMouseButton(window, GLFW_MOUSE_BUTTON_LEFT) == GLFW_RELEASE){
        status.setPerDisplace(false);
        status.setFirstMouse(true);
    }

    if (glfwGetMouseButton(window, GLFW_MOUSE_BUTTON_RIGHT) == GLFW_RELEASE){
        status.setPerRotate(false);
        status.setFirstMouse(true);
    }


}

// glfw: whenever the window size changed (by OS or user resize) this callback function executes
// ---------------------------------------------------------------------------------------------
void framebuffer_size_callback(GLFWwindow* window, int width, int height)
{
    glViewport(0, 0, width, height);
    status.setWidth(width);
    status.setHeight(height);
}

// glfw: whenever the mouse moves, this callback is called
// -------------------------------------------------------
void mouse_callback(GLFWwindow* window, double xpos, double ypos)
{
    float xoffset, yoffset;

	if (status.getPerDisplace() or status.getPerRotate()) {
		if (status.getFirstMouse()) {
			status.setLastMouseX(xpos);
			status.setLastMouseY(ypos);
            status.setFirstMouse(false);
		}

		xoffset = -xpos + status.getLastMouseX();
		yoffset = -status.getLastMouseY() + ypos;

		status.setLastMouseX(xpos);
		status.setLastMouseY(ypos);
		status.setSomeChange(true);
    }
	
    if (status.getPerDisplace()) {
    	camera.processMouseDisplace(xoffset, yoffset);
    } else if (status.getPerRotate()) {
		camera.processMouseRotate(xoffset, yoffset);
    }
}

// glfw: whenever the mouse scroll wheel scrolls, this callback is called
// ----------------------------------------------------------------------
void scroll_callback(GLFWwindow* window, double xoffset, double yoffset)
{
    if (!ImGui::IsAnyWindowHovered()) {
        camera.processMouseScroll(yoffset);
        status.setSomeChange(true);
    }
}

void setCallbacks()
{
    glfwSetFramebufferSizeCallback(window, framebuffer_size_callback);
	glfwSetKeyCallback(window, processKeyInput);
	glfwSetMouseButtonCallback(window, processMouseKey);
    glfwSetCursorPosCallback(window, mouse_callback);
	glfwSetScrollCallback(window, scroll_callback);
}

void updateUniforms(Shader *sh, bool showPol=false, bool showNormals=false)
{
    sh->setMat4("projection", projection);
    sh->setMat4("view", view);
    sh->setMat4("model", model);
    
    sh->setBool("showPol", showPol);
    sh->setBool("showNormals", showNormals);
    sh->setVec3("colorPol", glm::vec3(0.0f, 0.0f, 0.0f));
    sh->setVec3("colorNormals", glm::vec3(1.0f, 0.3f, 0.3f));

    sh->setVec3("objectColor", object.getColor());
    sh->setVec3("lightColor", light.getColor());
    sh->setVec3("lightPos", light.getPos());
    sh->setVec3("viewPos", camera.cameraLocation);
    
    sh->setFloat("STEP", step);
	sh->setArray("param_t", params, sizeof(params));
}

int initializeGLFW()
{
	// glfw: initialize and configure
    glfwInit();
    glfwSetErrorCallback(glfw_error_callback);
    glfwWindowHint(GLFW_CONTEXT_VERSION_MAJOR, 3);
    glfwWindowHint(GLFW_CONTEXT_VERSION_MINOR, 3);
    glfwWindowHint(GLFW_OPENGL_PROFILE, GLFW_OPENGL_CORE_PROFILE);
    glfwWindowHint(GLFW_SAMPLES, N_SAMPLES);

    // glfw window creation
    window = glfwCreateWindow(status.getWidth(), status.getHeight(), "LearnOpenGL", NULL, NULL);
    
    if (window == NULL) {
        std::cout << "Failed to create GLFW window" << std::endl;
        glfwTerminate();
        
        return -1;
    }
    
    glfwMakeContextCurrent(window);
    setCallbacks();
    
    // glad: load all OpenGL function pointers
    if (!gladLoadGLLoader((GLADloadproc)glfwGetProcAddress)) {
        std::cout << "Failed to initialize GLAD" << std::endl;
        
        return -1;
    }
    
    glfwSwapInterval(1); // Enable vsync
    
    // configure global opengl state
    glEnable(GL_DEPTH_TEST);
}

void plainDeclar()
{
    for(int i = 0; i < SIZE + 1; i++){
    	for(int j = 0; j < SIZE + 1; j++){
    		vertex[2 * ((SIZE + 1) * i + j)] = step * ((float) i);
    		vertex[2 * ((SIZE + 1) * i + j) + 1] = step * ((float) j);
    		//std::cout << vertex[2*((SIZE-1)*i+j)] << " " << vertex[2*((SIZE-1)*i+j)+1] <<std::endl;
    	}
    }
    
    for(int i = 0; i < SIZE; i++){
    	for(int j = 0; j < SIZE; j++){
    		indices[6 * (SIZE * i + j)] = (SIZE + 1) * i + j;
    		indices[6 * (SIZE * i + j) + 1] = (SIZE + 1) * i + j + 1;
    		indices[6 * (SIZE * i + j) + 2] = (SIZE + 1) * (i + 1) + j;
    		
    		indices[6 * (SIZE * i + j) + 3] = (SIZE + 1) * (i + 1) + j;
    		indices[6 * (SIZE * i + j) + 4] = (SIZE + 1) * i + j + 1;
    		indices[6 * (SIZE * i + j) + 5] = (SIZE + 1) * (i + 1) + j + 1;
    	}
    }
}

void initializeBuffers()
{    
    glGenVertexArrays(1, &VAO);
    glGenBuffers(1, &VBO);
    glGenBuffers(1, &EBO);
    
    glBindVertexArray(VAO);
    
    glBindBuffer(GL_ARRAY_BUFFER, VBO);
    glBufferData(GL_ARRAY_BUFFER, sizeof(vertex), &vertex, GL_STATIC_DRAW);
    
    glBindBuffer(GL_ELEMENT_ARRAY_BUFFER, EBO);
    glBufferData(GL_ELEMENT_ARRAY_BUFFER, sizeof(indices), &indices, GL_STATIC_DRAW);
    
    // position atribute
    glVertexAttribPointer(0, 3, GL_FLOAT, GL_FALSE, SIZE_POINT * sizeof(float), 0);
    glEnableVertexAttribArray(0);
    // normal atribute
    glVertexAttribPointer(1, 3, GL_FLOAT, GL_FALSE, SIZE_POINT * sizeof(float), (void*)(3*sizeof(float)));
    glEnableVertexAttribArray(0);
    
    glBindBuffer(GL_ARRAY_BUFFER, 0);
    glBindVertexArray(0);
}

void render()
{
	glClearColor(0.9f, 0.9f, 0.9f, 0.7f);
	glClear(GL_COLOR_BUFFER_BIT | GL_DEPTH_BUFFER_BIT);
    glLineWidth(1.2);

	if (status.getActivePolMode()) {
		glPolygonMode(GL_FRONT_AND_BACK, GL_LINE);
	} else {
		glPolygonMode(GL_FRONT_AND_BACK, GL_FILL);
	}

	// camera/view transformation
	if (status.getAutoRotation()) {
		view = camera.getAutoRotViewMatrix();
	} else {
		view = camera.getViewMatrix();
	}

	projection = glm::perspective(glm::radians(45.0f), (float)status.getWidth() / (float)status.getHeight(), 0.1f, 100.0f);
	
	params[0] = sin(glfwGetTime() / 2);
	params[1] = cos(glfwGetTime() / 2);
	
	if (status.getLoadShader()) {
		delete shader;
		system("cd procesador && make");
		shader = new Shader("shaders/vertex.s", "shaders/fragment.s", "shaders/geometry.s");
		status.setLoadShader(false);
        
        int n;

        temp_file.open ("temp", std::fstream::in);
        temp_file >> n;
        status.setTotalFPlot(n);
        temp_file >> n;
        status.setTotalParam(n);
        temp_file.close();
	}
	
    if (status.getShowNormals()) {
        // activate shader
        shaderNormals -> use();
        updateUniforms(shaderNormals, false, true);
        
        // render boxes
        glBindVertexArray(VAO);

        for (int i = 0; i < status.getTotalFPlot(); i++) {
            shader->setInt("funPlot", i);
            glDrawElements(GL_TRIANGLES, sizeof(indices), GL_UNSIGNED_INT, 0);
        }
    }

    // activate shader
	shader -> use();
	updateUniforms(shader, status.getActivePolMode());
	
	// render boxes
	glBindVertexArray(VAO);

	for (int i = 0; i < status.getTotalFPlot(); i++) {
		shader->setInt("funPlot", i);
		glDrawElements(GL_TRIANGLES, sizeof(indices), GL_UNSIGNED_INT, 0);
	}
}

void cleanBuffers()
{
    glDeleteVertexArrays(1, &VAO);
    glDeleteBuffers(1, &VBO);
    glDeleteBuffers(1, &EBO);
}

int main()
{
	initializeGLFW();
    
    initImGUI(window);
    plainDeclar();
    initializeBuffers();

    shaderNormals = new Shader("shaders/vertex.s", "shaders/fragment.s", "shaders/geometryNormals.s");
	shaderNormals -> use();
	updateUniforms(shaderNormals);

    shader = new Shader("shaders/vertex.s", "shaders/fragment.s", "shaders/geometry.s");
    shader -> use();
	updateUniforms(shader);
    
    int n;

    temp_file.open ("temp", std::fstream::in);
    temp_file >> n;
    status.setTotalFPlot(n);
    temp_file >> n;
    status.setTotalParam(n);
    temp_file.close();

    // render loop
    while (!glfwWindowShouldClose(window)) {
    	// per-frame time logic
    	float currentFrame = glfwGetTime();
        deltaTime = currentFrame - lastFrame;
        lastFrame = currentFrame;
        
    	//input
        glfwPollEvents();
    	
        // render
    	visualizeInterface();
    	render();
    	
    	for (int i = 0; i < 2; i++)
			visualizeInterface();
		
        // glfw: swap buffers and poll IO events (keys pressed/released, mouse moved etc.)
    	glfwSwapBuffers(window);
    	
    	status.setSomeChange(false);
        status.updateSomeChange();
        
        if (!status.getSomeChange())
        	glfwWaitEvents();
    }
	
	// Cleanup
    cleanImGUI();
    cleanBuffers();
    glfwTerminate();

    return 0;
}