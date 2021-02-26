

#include <glad/glad.h>
#include <GLFW/glfw3.h>
#include <GL/glut.h>

#include <glm/glm.hpp>
#include <glm/gtc/matrix_transform.hpp>
#include <glm/gtc/type_ptr.hpp>

#include <shader.h>
#include <camera.h>

#include <iostream>

void framebuffer_size_callback(GLFWwindow* window, int width, int height);
void processInput(GLFWwindow *window);

// settings
const unsigned int SCR_WIDTH = 800;
const unsigned int SCR_HEIGHT = 600;

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
    GLFWwindow* window = glfwCreateWindow(SCR_WIDTH, SCR_HEIGHT, "LearnOpenGL", NULL, NULL);
    if (window == NULL)
    {
        std::cout << "Failed to create GLFW window" << std::endl;
        glfwTerminate();
        return -1;
    }
    glfwMakeContextCurrent(window);
    glfwSetFramebufferSizeCallback(window, framebuffer_size_callback);

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
    Shader shader("9.1.geometry_shader.vs", "9.1.geometry_shader.fs", "9.1.geometry_shader.gs");

    const int SIZE = 20;
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
	glm::mat4 projection = glm::perspective(glm::radians(45.0f), (float)SCR_WIDTH / (float)SCR_HEIGHT, 0.1f, 100.0f);
    shader.setMat4("projection", projection); 
    shader.setFloat("STEP", step);
    //shader.setVec3("COLOR", glm::vec3(0.0, 1.0, 0.0));
	
    // render loop
    // -----------
    while (!glfwWindowShouldClose(window))
    {
    	//input
    	processInput(window);
    	
        // render
        // ------
        glClearColor(0.1f, 0.1f, 0.1f, 1.0f);
        glClear(GL_COLOR_BUFFER_BIT | GL_DEPTH_BUFFER_BIT);
        
		//glPolygonMode(GL_FRONT_AND_BACK, GL_LINE);
		
        // activate shader
        shader.use();
        
        // camera/view transformation
        glm::mat4 view = glm::mat4(1.0f); // make sure to initialize matrix to identity matrix first
        float radius = 10.0f;
        float camX   = sin(glfwGetTime()/2) * radius;
        float camZ   = cos(glfwGetTime()/2) * radius;
        view = glm::lookAt(glm::vec3(camX, 0.0f, camZ), glm::vec3(0.0f, 0.0f, 0.0f), glm::vec3(0.0f, 1.0f, 0.0f));
        shader.setMat4("view", view);
        shader.setVec3("objectColor", 0.1f, 0.75f, 0.1f);
        shader.setVec3("lightColor", 1.0f, 1.0f, 1.0f);
        shader.setVec3("lightPos", glm::vec3(1.2f, 1.0f, 2.0f));
        shader.setVec3("viewPos", glm::vec3(camX, 0.0f, camZ));
        
        shader.setFloat("t_0", sin(glfwGetTime()/2));
        shader.setFloat("t_1", cos(glfwGetTime()/2));

        // render boxes
        glBindVertexArray(VAO);
        
        // calculate the model matrix for each object and pass it to shader before drawing
        glm::mat4 model = glm::mat4(1.0f);
        model = glm::translate(model, glm::vec3(0.0f, 0.0f, 0.0f));
        float angle = 20.0f*0;
        model = glm::rotate(model, glm::radians(angle), glm::vec3(1.0f, 0.3f, 0.5f));
        shader.setMat4("model", model);
		
    	shader.setInt("funPlot", 0);
        glDrawElements(GL_TRIANGLES, sizeof(indices), GL_UNSIGNED_INT, 0);
    	shader.setInt("funPlot", 1);
        glDrawElements(GL_TRIANGLES, sizeof(indices), GL_UNSIGNED_INT, 0);
        
        // glfw: swap buffers and poll IO events (keys pressed/released, mouse moved etc.)
        // -------------------------------------------------------------------------------
        glfwSwapBuffers(window);
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

// process all input: query GLFW whether relevant keys are pressed/released this frame and react accordingly
// ---------------------------------------------------------------------------------------------------------
void processInput(GLFWwindow *window)
{
    if (glfwGetKey(window, GLFW_KEY_ESCAPE) == GLFW_PRESS)
        glfwSetWindowShouldClose(window, true);
}

// glfw: whenever the window size changed (by OS or user resize) this callback function executes
// ---------------------------------------------------------------------------------------------
void framebuffer_size_callback(GLFWwindow* window, int width, int height)
{
    // make sure the viewport matches the new window dimensions; note that width and 
    // height will be significantly larger than specified on retina displays.
    glViewport(0, 0, width, height);
    /*glMatrixMode(GL_PROJECTION);
    glLoadIdentity();
    glFrustrum(-xval, +xval, -yval, +yval, -10, +10);
    gluLookAt();
    glMatrixMode(GL_MODELVIEW);*/
}


