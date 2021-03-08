


#include "imgui.h"
#include "imgui_impl_glfw.h"
#include "imgui_impl_opengl3.h"
#include <stdio.h>


#if defined(IMGUI_IMPL_OPENGL_LOADER_GL3W)
#include <GL/gl3w.h>            // Initialize with gl3wInit()
#elif defined(IMGUI_IMPL_OPENGL_LOADER_GLEW)
#include <GL/glew.h>            // Initialize with glewInit()
#elif defined(IMGUI_IMPL_OPENGL_LOADER_GLAD)
#include <glad/glad.h>          // Initialize with gladLoadGL()
#elif defined(IMGUI_IMPL_OPENGL_LOADER_GLBINDING2)
#define GLFW_INCLUDE_NONE       // GLFW including OpenGL headers causes ambiguity or multiple definition errors.
#include <glbinding/Binding.h>  // Initialize with glbinding::Binding::initialize()
#include <glbinding/gl/gl.h>
using namespace gl;
#elif defined(IMGUI_IMPL_OPENGL_LOADER_GLBINDING3)
#define GLFW_INCLUDE_NONE       // GLFW including OpenGL headers causes ambiguity or multiple definition errors.
#include <glbinding/glbinding.h>// Initialize with glbinding::initialize()
#include <glbinding/gl/gl.h>
using namespace gl;
#else
#include IMGUI_IMPL_OPENGL_LOADER_CUSTOM
#endif

#include <glad/glad.h>
#include <GLFW/glfw3.h>
#include <GL/glut.h>
#include <GL/gl.h>

// About Desktop OpenGL function loaders:
//  Modern desktop OpenGL doesn't have a standard portable header file to load OpenGL function pointers.
//  Helper libraries are often used for this purpose! Here we are supporting a few common ones (gl3w, glew, glad).
//  You may use another loader/header of your choice (glext, glLoadGen, etc.), or chose to manually implement your own

// Include glfw3.h after our OpenGL definitions

#if defined(_MSC_VER) && (_MSC_VER >= 1900) && !defined(IMGUI_DISABLE_WIN32_FUNCTIONS)
#pragma comment(lib, "legacy_stdio_definitions")
#endif


#include <glm/glm.hpp>
#include <glm/gtc/matrix_transform.hpp>
#include <glm/gtc/type_ptr.hpp>


#include <shader.h>
#include <camera.h>
#include <settings.h>
#include <light.h>
#include <object.h>

#include <iostream>



bool show_demo_window = true;
bool show_another_window = false;
ImVec4 clear_color = ImVec4(0.45f, 0.55f, 0.60f, 1.00f);



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

static void glfw_error_callback(int error, const char* description)
{
    fprintf(stderr, "Glfw Error %d: %s\n", error, description);
}

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
    	settings.setSomeChange(true);
    }
    if (glfwGetKey(window, GLFW_KEY_P) == GLFW_PRESS) {
		firstTime_P = true;
		settings.setSomeChange(true);
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
    		firstTime_P = false;
    		settings.setSomeChange(true);
    	}
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
    const char* glsl_version = "#version 130";
    //glfwSetErrorCallback(glfw_error_callback);
    glfwInit();
    glfwWindowHint(GLFW_CONTEXT_VERSION_MAJOR, 3);
    glfwWindowHint(GLFW_CONTEXT_VERSION_MINOR, 3);
    //glfwWindowHint(GLFW_OPENGL_PROFILE, GLFW_OPENGL_CORE_PROFILE);

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
    //glfwSetScrollCallback(window, scroll_callback);
    
    // tell GLFW to capture our mouse
    //glfwSetInputMode(window, GLFW_CURSOR, GLFW_CURSOR_DISABLED);
	
    // glad: load all OpenGL function pointers
    if (!gladLoadGLLoader((GLADloadproc)glfwGetProcAddress))
    {
        std::cout << "Failed to initialize GLAD" << std::endl;
        return -1;
    }

    glfwSwapInterval(1); // Enable vsync
    
    
    #if defined(IMGUI_IMPL_OPENGL_LOADER_GL3W)
    bool err = gl3wInit() != 0;
#elif defined(IMGUI_IMPL_OPENGL_LOADER_GLEW)
    bool err = glewInit() != GLEW_OK;
#elif defined(IMGUI_IMPL_OPENGL_LOADER_GLAD)
    bool err = gladLoadGL() == 0;
#elif defined(IMGUI_IMPL_OPENGL_LOADER_GLBINDING2)
    bool err = false;
    glbinding::Binding::initialize();
#elif defined(IMGUI_IMPL_OPENGL_LOADER_GLBINDING3)
    bool err = false;
    glbinding::initialize([](const char* name) { return (glbinding::ProcAddress)glfwGetProcAddress(name); });
#else
    bool err = false; // If you use IMGUI_IMPL_OPENGL_LOADER_CUSTOM, your loader is likely to requires some form of initialization.
#endif
    if (err)
    {
        fprintf(stderr, "Failed to initialize OpenGL loader!\n");
        return 1;
    }
    
    
    // configure global opengl state
    glEnable(GL_DEPTH_TEST);
    
    // Setup Dear ImGui context
    IMGUI_CHECKVERSION();
    ImGui::CreateContext();
    ImGuiIO& io = ImGui::GetIO(); (void)io;
    //io.ConfigFlags |= ImGuiConfigFlags_NavEnableKeyboard;     // Enable Keyboard Controls
    //io.ConfigFlags |= ImGuiConfigFlags_NavEnableGamepad;      // Enable Gamepad Controls

    // Setup Dear ImGui style
    ImGui::StyleColorsDark();

    // Setup Platform/Renderer bindings
    ImGui_ImplGlfw_InitForOpenGL(window, true);
    ImGui_ImplOpenGL3_Init(glsl_version);
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
	
}

void visualizarInterfaz(){
	ImGui_ImplOpenGL3_NewFrame();
    ImGui_ImplGlfw_NewFrame();
    ImGui::NewFrame();

    {
        static float f = 0.0f;
        static int counter = 0;

        ImGui::Begin("Hello, world!");                          // Create a window called "Hello, world!" and append into it.

        ImGui::Text("This is some useful text.");               // Display some text (you can use a format strings too)
        ImGui::Checkbox("Demo Window", &show_demo_window);      // Edit bools storing our window open/close state
        ImGui::Checkbox("Another Window", &show_another_window);

        ImGui::SliderFloat("float", &f, 0.0f, 1.0f);            // Edit 1 float using a slider from 0.0f to 1.0f
        ImGui::ColorEdit3("clear color", (float*)&clear_color); // Edit 3 floats representing a color

        if (ImGui::Button("Button"))                            // Buttons return true when clicked (most widgets return true when edited/activated)
            counter++;
        ImGui::SameLine();
        ImGui::Text("counter = %d", counter);

        ImGui::Text("Application average %.3f ms/frame (%.1f FPS)", 1000.0f / ImGui::GetIO().Framerate, ImGui::GetIO().Framerate);
        ImGui::End();
    }

    // 3. Show another simple window.
    if (show_another_window)
    {
        ImGui::Begin("Another Window", &show_another_window);   // Pass a pointer to our bool variable (the window will have a closing button that will clear the bool when clicked)
        ImGui::Text("Hello from another window!");
        if (ImGui::Button("Close Me"))
            show_another_window = false;
        ImGui::End();
    }

    // Rendering
    ImGui::Render();
    int display_w, display_h;
    glfwGetFramebufferSize(window, &display_w, &display_h);
    glViewport(0, 0, display_w, display_h);
    //glClearColor(clear_color.x, clear_color.y, clear_color.z, clear_color.w);
    //glClear(GL_COLOR_BUFFER_BIT);
    ImGui_ImplOpenGL3_RenderDrawData(ImGui::GetDrawData());

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
        glfwPollEvents();
    	processInput(window);
    	
    	settings.updateSomeChange();
        // render
        if (settings.getSomeChange() || camera.getPosChange() || light.getColorChange()
        	|| light.getPosChange() || object.getColorChange()) {
        	render();
        	for (int i=0; i<3; i++)
        		visualizarInterfaz();
        	glfwSwapBuffers(window);
        	settings.setSomeChange(false);
			object.setColorChange(false);
			light.setColorChange(false);
			light.setPosChange(false);
			camera.setPosChange(false);
        }
        
        // glfw: swap buffers and poll IO events (keys pressed/released, mouse moved etc.)
        
    }
	
	// Cleanup
    ImGui_ImplOpenGL3_Shutdown();
    ImGui_ImplGlfw_Shutdown();
    ImGui::DestroyContext();
    
    // optional: de-allocate all resources once they've outlived their purpose:
    glDeleteVertexArrays(1, &VAO);
    glDeleteBuffers(1, &VBO);
    glDeleteBuffers(1, &EBO);

    glfwTerminate();
    return 0;
}
