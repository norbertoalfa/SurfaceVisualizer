#include <glad/glad.h>
#include <GLFW/glfw3.h>
#include <GL/glut.h>
#include <GL/gl.h>

#include <glm/glm.hpp>
#include <glm/gtc/matrix_transform.hpp>
#include <glm/gtc/type_ptr.hpp>

#include <shader.h>
#include <camera.h>
#include <settings.h>
#include <light.h>
#include <object.h>

#include <iostream>


// Settings
Settings settings;
bool perDisplace = false;
bool perRotate = false;
bool loadShader = true;
int totalFPlot = 1;

// Camera
Camera camera(glm::vec3(0.0f,0.0f,0.0f));
float lastX = settings.getWidth() / 2.0f;
float lastY = settings.getHeight() / 2.0f;
bool firstMouse = true;
bool firstTime_R = false;
bool firstTime_P = false;

// timing
float deltaTime = 0.0f;	
float lastFrame = 0.0f;

// Light properties
Light light;

// Object properties
Object object;

// Shader
Shader *shader;

// Uniforms to pass
glm::mat4 projection = glm::perspective(glm::radians(45.0f), (float)settings.getWidth() / (float)settings.getHeight(), 0.1f, 100.0f);
glm::mat4 view = camera.getViewMatrix();
glm::mat4 model = glm::mat4(1.0f);
GLfloat params[10];

const int SIZE = 40;
const int SIZE_POINT = 2;
float step = 1.0/((float) SIZE);

// Variables
GLFWwindow* window;
float vertex[2*(SIZE+1)*(SIZE+1) +2];
unsigned int indices[6*SIZE*SIZE];
unsigned int VBO, VAO, EBO;


// Functions
// process all input: query GLFW whether relevant keys are pressed/released this frame and react accordingly
// ---------------------------------------------------------------------------------------------------------
void processInput(GLFWwindow *window)
{
    if (glfwGetKey(window, GLFW_KEY_ESCAPE) == GLFW_PRESS)
        glfwSetWindowShouldClose(window, true);
        
    if (glfwGetKey(window, GLFW_KEY_W) == GLFW_PRESS) {
    	camera.processKeyboard(FORWARD, deltaTime);
    	settings.setSomeChange(true);
	}
    if (glfwGetKey(window, GLFW_KEY_S) == GLFW_PRESS) {
    	camera.processKeyboard(BACKWARD, deltaTime);
    	settings.setSomeChange(true);
	}
    if (glfwGetKey(window, GLFW_KEY_A) == GLFW_PRESS) {
    	camera.processKeyboard(LEFT, deltaTime);
    	settings.setSomeChange(true);
    }
    if (glfwGetKey(window, GLFW_KEY_D) == GLFW_PRESS) {
    	camera.processKeyboard(RIGHT, deltaTime);
    	settings.setSomeChange(true);
    }
    
    if (glfwGetKey(window, GLFW_KEY_R) == GLFW_PRESS) {
    	firstTime_R = true;
    }
    if (glfwGetKey(window, GLFW_KEY_P) == GLFW_PRESS) {
		firstTime_P = true;
    }
    
    if (glfwGetKey(window, GLFW_KEY_R) == GLFW_RELEASE) {
    	if (firstTime_R) {
    		settings.switchAutoRot();
    		firstTime_R = false;
    	}
    	settings.setSomeChange(true);
    }
    if (glfwGetKey(window, GLFW_KEY_P) == GLFW_RELEASE) {
    	if (firstTime_P) {
    		settings.switchPolMode();
    		firstTime_P = false;
    	}
    	settings.setSomeChange(true);
    }
    
    if (glfwGetKey(window, GLFW_KEY_L) == GLFW_PRESS) {
    	loadShader = true;
    	settings.setSomeChange(true);
    }
    
    if (glfwGetMouseButton(window, GLFW_MOUSE_BUTTON_LEFT) == GLFW_PRESS) {
    	perDisplace = true;
    	settings.setSomeChange(true);
    }
    if (glfwGetMouseButton(window, GLFW_MOUSE_BUTTON_LEFT) == GLFW_RELEASE){
    	perDisplace = false;
    	firstMouse = true;
    }
    
    if (glfwGetMouseButton(window, GLFW_MOUSE_BUTTON_RIGHT) == GLFW_PRESS) {
    	perRotate = true;
    	settings.setSomeChange(true);
    }
    if (glfwGetMouseButton(window, GLFW_MOUSE_BUTTON_RIGHT) == GLFW_RELEASE){
    	perRotate = false;
    	firstMouse = true;
    }
    
    if (glfwGetMouseButton(window, GLFW_MOUSE_BUTTON_MIDDLE) == GLFW_PRESS) {
    	camera.reset();
    	settings.setSomeChange(true);
    }
    
}

// glfw: whenever the window size changed (by OS or user resize) this callback function executes
// ---------------------------------------------------------------------------------------------
void framebuffer_size_callback(GLFWwindow* window, int width, int height)
{
    glViewport(0, 0, width, height);
    settings.setWidth(width);
    settings.setHeight(height);
}

// glfw: whenever the mouse moves, this callback is called
// -------------------------------------------------------
void mouse_callback(GLFWwindow* window, double xpos, double ypos)
{
	if (perDisplace) {
	
		if (firstMouse)
		{
			lastX = xpos;
			lastY = ypos;
			firstMouse = false;
		}

		float xoffset = -xpos + lastX;
		float yoffset = -lastY + ypos;

		lastX = xpos;
		lastY = ypos;

		camera.processMouseDisplace(xoffset, yoffset);
		settings.setSomeChange(true);
		
    } else if (perRotate) {
    
    	if (firstMouse)
		{
			lastX = xpos;
			lastY = ypos;
			firstMouse = false;
		}

		float xoffset = -xpos + lastX;
		float yoffset = -lastY + ypos;

		lastX = xpos;
		lastY = ypos;

		camera.processMouseRotate(xoffset, yoffset);
		settings.setSomeChange(true);
    }
}

// glfw: whenever the mouse scroll wheel scrolls, this callback is called
// ----------------------------------------------------------------------
void scroll_callback(GLFWwindow* window, double xoffset, double yoffset)
{
    camera.processMouseScroll(yoffset);
    settings.setSomeChange(true);
}

void updateUniforms(){
    shader->setMat4("projection", projection);
    shader->setMat4("view", view);
    shader->setMat4("model", model);
    
    shader->setVec3("objectColor", object.getColor());
    shader->setVec3("lightColor", light.getColor());
    shader->setVec3("lightPos", light.getPos());
    shader->setVec3("viewPos", camera.Position);
    
    shader->setFloat("STEP", step);
	shader->setArray("param_t", params, sizeof(params));
}

int openGLInit(){
	// glfw: initialize and configure
    glfwInit();
    glfwWindowHint(GLFW_CONTEXT_VERSION_MAJOR, 3);
    glfwWindowHint(GLFW_CONTEXT_VERSION_MINOR, 3);
    glfwWindowHint(GLFW_OPENGL_PROFILE, GLFW_OPENGL_CORE_PROFILE);

	#ifdef __APPLE__
    	glfwWindowHint(GLFW_OPENGL_FORWARD_COMPAT, GL_TRUE);
	#endif

    // glfw window creation
    window = glfwCreateWindow(settings.getWidth(), settings.getHeight(), "LearnOpenGL", NULL, NULL);
    if (window == NULL)
    {
        std::cout << "Failed to create GLFW window" << std::endl;
        glfwTerminate();
        return -1;
    }
    glfwMakeContextCurrent(window);
    glfwSetFramebufferSizeCallback(window, framebuffer_size_callback);
    glfwSetCursorPosCallback(window, mouse_callback);
    glfwSetScrollCallback(window, scroll_callback);
    
    // tell GLFW to capture our mouse
    //glfwSetInputMode(window, GLFW_CURSOR, GLFW_CURSOR_DISABLED);
	
    // glad: load all OpenGL function pointers
    if (!gladLoadGLLoader((GLADloadproc)glfwGetProcAddress))
    {
        std::cout << "Failed to initialize GLAD" << std::endl;
        return -1;
    }

    // configure global opengl state
    glEnable(GL_DEPTH_TEST);
}

void plainDeclar(){
    for(int i=0; i<SIZE+1; i++){
    	for(int j=0; j<SIZE+1; j++){
    		vertex[2*((SIZE+1)*i+j)] = step*((float)i);
    		vertex[2*((SIZE+1)*i+j)+1] = step*((float)j);
    		//std::cout << vertex[2*((SIZE-1)*i+j)] << " " << vertex[2*((SIZE-1)*i+j)+1] <<std::endl;
    	}
    }
    
    for(int i=0; i<SIZE; i++){
    	for(int j=0; j<SIZE; j++){
    		indices[6*(SIZE*i+j)] = (SIZE+1)*i+j;
    		indices[6*(SIZE*i+j)+1] = (SIZE+1)*i+j+1;
    		indices[6*(SIZE*i+j)+2] = (SIZE+1)*(i+1)+j;
    		
    		indices[6*(SIZE*i+j)+3] = (SIZE+1)*(i+1)+j;
    		indices[6*(SIZE*i+j)+4] = (SIZE+1)*i+j+1;
    		indices[6*(SIZE*i+j)+5] = (SIZE+1)*(i+1)+j+1;
    	}
    }
    
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

void render(){
	glClearColor(0.1f, 0.1f, 0.1f, 1.0f);
	glClear(GL_COLOR_BUFFER_BIT | GL_DEPTH_BUFFER_BIT);

	if (settings.getActivePolMode()) {
		glPolygonMode(GL_FRONT_AND_BACK, GL_LINE);
	} else {
		glPolygonMode(GL_FRONT_AND_BACK, GL_FILL);
	}


	// camera/view transformation
	if (settings.getAutoRotation()) {
		view = camera.getAutoRotViewMatrix();
	} else {
		view = camera.getViewMatrix();
	}

	projection = glm::perspective(glm::radians(45.0f), (float)settings.getWidth() / (float)settings.getHeight(), 0.1f, 100.0f);
	
	params[0] = sin(glfwGetTime()/2);
	params[1] = cos(glfwGetTime()/2);
	
	if (loadShader) {
		delete shader;
		system("cd procesador && make");
		shader = new Shader("shaders/vertex.s", "shaders/fragment.s", "shaders/geometry.s");
		loadShader = false;
	}
	
	// activate shader
	shader->use();
	updateUniforms();
	
	// render boxes
	glBindVertexArray(VAO);

	for (int i=0; i<totalFPlot; i++) {
		shader->setInt("funPlot", i);
		glDrawElements(GL_TRIANGLES, sizeof(indices), GL_UNSIGNED_INT, 0);
	}
	
	glfwSwapBuffers(window);
}

int main() {
	openGLInit();
    plainDeclar();
    shader = new Shader("shaders/vertex.s", "shaders/fragment.s", "shaders/geometry.s");
	shader->use();
	
	updateUniforms();
    
    // render loop
    while (!glfwWindowShouldClose(window))
    {
    	// per-frame time logic
    	float currentFrame = glfwGetTime();
        deltaTime = currentFrame - lastFrame;
        lastFrame = currentFrame;
        
    	//input
    	processInput(window);
    	
    	settings.updateSomeChange();
        // render
        if (settings.getSomeChange() || camera.getPosChange() || light.getColorChange()
        	|| light.getPosChange() || object.getColorChange())
        {
        	render();
        	settings.setSomeChange(false);
			object.setColorChange(false);
			light.setColorChange(false);
			light.setPosChange(false);
			camera.setPosChange(false);
        }
        
        // glfw: swap buffers and poll IO events (keys pressed/released, mouse moved etc.)
        glfwPollEvents();
    }

    // optional: de-allocate all resources once they've outlived their purpose:
    glDeleteVertexArrays(1, &VAO);
    glDeleteBuffers(1, &VBO);
    glDeleteBuffers(1, &EBO);

    glfwTerminate();
    return 0;
}
