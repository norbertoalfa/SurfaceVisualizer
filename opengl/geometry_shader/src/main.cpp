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
bool someChange = true;
bool perDisplace = false;
bool perRotate = false;
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


// Functions
// process all input: query GLFW whether relevant keys are pressed/released this frame and react accordingly
// ---------------------------------------------------------------------------------------------------------
void processInput(GLFWwindow *window)
{
    if (glfwGetKey(window, GLFW_KEY_ESCAPE) == GLFW_PRESS)
        glfwSetWindowShouldClose(window, true);
        
    if (glfwGetKey(window, GLFW_KEY_W) == GLFW_PRESS) {
    	camera.processKeyboard(FORWARD, deltaTime);
    	settings.setViewChange();
	}
    if (glfwGetKey(window, GLFW_KEY_S) == GLFW_PRESS) {
    	camera.processKeyboard(BACKWARD, deltaTime);
    	settings.setViewChange();
	}
    if (glfwGetKey(window, GLFW_KEY_A) == GLFW_PRESS) {
    	camera.processKeyboard(LEFT, deltaTime);
    	settings.setViewChange();
    }
    if (glfwGetKey(window, GLFW_KEY_D) == GLFW_PRESS) {
    	camera.processKeyboard(RIGHT, deltaTime);
    	settings.setViewChange();
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
    }
    if (glfwGetKey(window, GLFW_KEY_P) == GLFW_RELEASE) {
    	if (firstTime_P) {
    		settings.switchPolMode();
    		someChange = true;
    		firstTime_P = false;
    	}
    }
    
    if (glfwGetMouseButton(window, GLFW_MOUSE_BUTTON_LEFT) == GLFW_PRESS) {
    	perDisplace = true;
    	settings.setViewChange();
    }
    if (glfwGetMouseButton(window, GLFW_MOUSE_BUTTON_LEFT) == GLFW_RELEASE){
    	perDisplace = false;
    	firstMouse = true;
    }
    
    if (glfwGetMouseButton(window, GLFW_MOUSE_BUTTON_RIGHT) == GLFW_PRESS) {
    	perRotate = true;
    	settings.setViewChange();
    }
    if (glfwGetMouseButton(window, GLFW_MOUSE_BUTTON_RIGHT) == GLFW_RELEASE){
    	perRotate = false;
    	firstMouse = true;
    }
    
    if (glfwGetMouseButton(window, GLFW_MOUSE_BUTTON_MIDDLE) == GLFW_PRESS) {
    	camera.reset();
    	settings.setViewChange();
    }
    
}

// glfw: whenever the window size changed (by OS or user resize) this callback function executes
// ---------------------------------------------------------------------------------------------
void framebuffer_size_callback(GLFWwindow* window, int width, int height)
{
    // make sure the viewport matches the new window dimensions; note that width and 
    // height will be significantly larger than specified on retina displays.
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
		float yoffset = -lastY + ypos; // reversed since y-coordinates go from bottom to top

		lastX = xpos;
		lastY = ypos;

		camera.processMouseDisplace(xoffset, yoffset);
		settings.setViewChange();
		
    } else if (perRotate) {
    
    	if (firstMouse)
		{
			lastX = xpos;
			lastY = ypos;
			firstMouse = false;
		}

		float xoffset = -xpos + lastX;
		float yoffset = -lastY + ypos; // reversed since y-coordinates go from bottom to top

		lastX = xpos;
		lastY = ypos;

		camera.processMouseRotate(xoffset, yoffset);
		settings.setViewChange();
    }
}

// glfw: whenever the mouse scroll wheel scrolls, this callback is called
// ----------------------------------------------------------------------
void scroll_callback(GLFWwindow* window, double xoffset, double yoffset)
{
    camera.processMouseScroll(yoffset);
    settings.setViewChange();
}


int main()
{
    // glfw: initialize and configure
    // ------------------------------
    glfwInit();
    glfwWindowHint(GLFW_CONTEXT_VERSION_MAJOR, 3);
    glfwWindowHint(GLFW_CONTEXT_VERSION_MINOR, 3);
    glfwWindowHint(GLFW_OPENGL_PROFILE, GLFW_OPENGL_CORE_PROFILE);

#ifdef __APPLE__
    glfwWindowHint(GLFW_OPENGL_FORWARD_COMPAT, GL_TRUE);
#endif

    // glfw window creation
    // --------------------
    GLFWwindow* window = glfwCreateWindow(settings.getWidth(), settings.getHeight(), "LearnOpenGL", NULL, NULL);
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
    // ---------------------------------------
    if (!gladLoadGLLoader((GLADloadproc)glfwGetProcAddress))
    {
        std::cout << "Failed to initialize GLAD" << std::endl;
        return -1;
    }

    // configure global opengl state
    // -----------------------------
    glEnable(GL_DEPTH_TEST);

    // build and compile shaders
    // -------------------------
    //Shader shader("9.1.geometry_shader.vs", "9.1.geometry_shader.fs", "9.1.geometry_shader.gs");
    Shader shader("shaders/vertex.s", "shaders/fragment.s", "shaders/geometry.s");

    const int SIZE = 40;
    const int SIZE_POINT = 2; //5;
    
    float step = 1.0/((float) SIZE);
    
    float vertex[2*(SIZE+1)*(SIZE+1) +2];
    for(int i=0; i<SIZE+1; i++){
    	for(int j=0; j<SIZE+1; j++){
    		vertex[2*((SIZE+1)*i+j)] = step*((float)i);
    		vertex[2*((SIZE+1)*i+j)+1] = step*((float)j);
    		//std::cout << vertex[2*((SIZE-1)*i+j)] << " " << vertex[2*((SIZE-1)*i+j)+1] <<std::endl;
    	}
    }
    
    unsigned int indices[6*SIZE*SIZE];
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
    
    
    unsigned int VBO, VAO, EBO;
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
    
    // texture coord attribute
    //glVertexAttribPointer(1, 3, GL_FLOAT, GL_FALSE, SIZE_POINT * sizeof(float), (void*)(2 * sizeof(float)));
    //glEnableVertexAttribArray(1);
    glBindBuffer(GL_ARRAY_BUFFER, 0);
    glBindVertexArray(0);
	
	shader.use();
	
	// pass projection matrix to shader
	glm::mat4 projection = glm::perspective(glm::radians(45.0f), (float)settings.getWidth() / (float)settings.getHeight(), 0.1f, 100.0f);
	glm::mat4 view = camera.getViewMatrix();
    glm::mat4 model = glm::mat4(1.0f);
    
    float angle = 20.0f*0;
    model = glm::translate(model, glm::vec3(0.0f, 0.0f, 0.0f));
    model = glm::rotate(model, glm::radians(angle), glm::vec3(1.0f, 0.3f, 0.5f));
	
    shader.setMat4("projection", projection);
    shader.setMat4("view", view);
    shader.setMat4("model", model);
    
    shader.setVec3("objectColor", object.getColor());
    shader.setVec3("lightColor", light.getColor());
    shader.setVec3("lightPos", light.getPos());
    shader.setVec3("viewPos", camera.Position);
    
    shader.setFloat("STEP", step);
    
    // render loop
    // -----------
    while (!glfwWindowShouldClose(window))
    {
    	// per-frame time logic
        // --------------------
    	float currentFrame = glfwGetTime();
        deltaTime = currentFrame - lastFrame;
        lastFrame = currentFrame;
        
    	//input
    	processInput(window);
    	
        // render
        // ------
        glClearColor(0.1f, 0.1f, 0.1f, 1.0f);
        glClear(GL_COLOR_BUFFER_BIT | GL_DEPTH_BUFFER_BIT);
        
        if (settings.getActivePolMode()) {
			glPolygonMode(GL_FRONT_AND_BACK, GL_LINE);
		} else {
			glPolygonMode(GL_FRONT_AND_BACK, GL_FILL);
		}
		
        // activate shader
        shader.use();	//?
        
        // camera/view transformation
        if (settings.getAutoRotation()) {
		    view = camera.getAutoRotViewMatrix();
		    shader.setMat4("view", view);
       		someChange = true;
		} else if (settings.getViewChange()) {
			view = camera.getViewMatrix();
			shader.setMat4("view", view);
			settings.switchViewChange();
       		someChange = true;
		}
        
        if (settings.getChProjection()) {
			glm::mat4 projection = glm::perspective(glm::radians(45.0f), (float)settings.getWidth() / (float)settings.getHeight(), 0.1f, 100.0f);
			shader.setMat4("projection", projection);
			settings.switchChProjection();
       		someChange = true;
        }
        
        if (object.getColorChange()){
        	shader.setVec3("objectColor", object.getColor());
        	object.switchColorChange();
       		someChange = true;
		}
        
        if (light.getColorChange()){
        	shader.setVec3("lightColor", light.getColor());
        	light.switchColorChange();
       		someChange = true;
        }
        
        if (light.getPosChange()){
        	shader.setVec3("lightPos", light.getPos());
        	light.switchPosChange();
       		someChange = true;
        }
        
        if (camera.getPosChange()){
        	shader.setVec3("viewPos", camera.Position);
        	camera.switchPosChange();
       		someChange = true;
        }
        
        GLfloat params[10];
        params[0] = sin(glfwGetTime()/2);
        params[1] = cos(glfwGetTime()/2);
        
        shader.setArray("param_t", params, sizeof(params));

        // render boxes
        glBindVertexArray(VAO);
        
        // calculate the model matrix for each object and pass it to shader before drawing
        if (settings.getModelChange()) {
       		shader.setMat4("model", model);
       		settings.switchModelChange();
       		someChange = true;
       	}
		
		if (someChange) {
			for (int i=0; i<totalFPlot; i++) {
				shader.setInt("funPlot", i);
				glDrawElements(GL_TRIANGLES, sizeof(indices), GL_UNSIGNED_INT, 0);
		    }
		    
        	glfwSwapBuffers(window);
       		someChange = false;
       		
        }
        
        // glfw: swap buffers and poll IO events (keys pressed/released, mouse moved etc.)
        // -------------------------------------------------------------------------------
        glfwPollEvents();
    }

    // optional: de-allocate all resources once they've outlived their purpose:
    // ------------------------------------------------------------------------
    glDeleteVertexArrays(1, &VAO);
    glDeleteBuffers(1, &VBO);
    glDeleteBuffers(1, &EBO);

    glfwTerminate();
    return 0;
}
