

#include <glad/glad.h>
#include <GLFW/glfw3.h>
#include <GL/glut.h>

#include <glm/glm.hpp>
#include <glm/gtc/matrix_transform.hpp>
#include <glm/gtc/type_ptr.hpp>

#include <shader.h>

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
    Shader shader("9.1.geometry_shader.vs", "9.1.geometry_shader.fs");//, "9.1.geometry_shader.gs");

    // set up vertex data (and buffer(s)) and configure vertex attributes
    // ------------------------------------------------------------------
    /*float points[] = {
        -0.5f,  0.5f, 1.0f, 0.0f, 0.0f, // top-left
         0.5f,  0.5f, 0.0f, 1.0f, 0.0f, // top-right
         0.5f, -0.5f, 0.0f, 0.0f, 1.0f, // bottom-right
        -0.5f, -0.5f, 1.0f, 1.0f, 0.0f  // bottom-left
    };*/
    const int SIZE = 20;
    const int SIZE_POINT = 2; //5;
    
    float step = 1.0/((float) SIZE);
    
    /*float points[2*SIZE*SIZE];
    for(int i=0; i<SIZE; i++){
    	for(int j=0; j<SIZE; j++){
    		points[2*(SIZE*i+j)] = step*((float)i);
    		points[2*(SIZE*i+j)+1] = step*((float)j);
    		//std::cout << points[2*((SIZE-1)*i+j)] << " " << points[2*((SIZE-1)*i+j)+1] <<std::endl;
    	}
    }*/
    
    float vertex[12*SIZE*SIZE + 2];
    for(int i=0; i<SIZE; i++){
    	for(int j=0; j<SIZE; j++){
    		vertex[12*(SIZE*i+j)] = step*((float)i);
    		vertex[12*(SIZE*i+j)+1] = step*((float)j);
    		vertex[12*(SIZE*i+j)+2] = step*((float)i);
    		vertex[12*(SIZE*i+j)+3] = step*((float)(j+1));
    		vertex[12*(SIZE*i+j)+4] = step*((float)(i+1));
    		vertex[12*(SIZE*i+j)+5] = step*((float)j);
    		
    		vertex[12*(SIZE*i+j)+6] = step*((float)(i+1));
    		vertex[12*(SIZE*i+j)+7] = step*((float)j);
    		vertex[12*(SIZE*i+j)+8] = step*((float)i);
    		vertex[12*(SIZE*i+j)+9] = step*((float)(j+1));
    		vertex[12*(SIZE*i+j)+10] = step*((float)(i+1));
    		vertex[12*(SIZE*i+j)+11] = step*((float)(j+1));
    		//std::cout << points[2*((SIZE-1)*i+j)] << " " << points[2*((SIZE-1)*i+j)+1] <<std::endl;
    	}
    }
    
    //std::cout << vertex[sizeof(vertex)-2] << " " << vertex[sizeof(vertex)-1] <<std::endl;
    
    unsigned int VBO, VAO;
    glGenVertexArrays(1, &VAO);
    glGenBuffers(1, &VBO);
    
    glBindVertexArray(VAO);
    
    glBindBuffer(GL_ARRAY_BUFFER, VBO);
    glBufferData(GL_ARRAY_BUFFER, sizeof(vertex), &vertex, GL_STATIC_DRAW);
    
    // position atribute
    glVertexAttribPointer(0, 3, GL_FLOAT, GL_FALSE, SIZE_POINT * sizeof(float), 0);
    glEnableVertexAttribArray(0);
    
    // texture coord attribute
    //glVertexAttribPointer(1, 3, GL_FLOAT, GL_FALSE, SIZE_POINT * sizeof(float), (void*)(2 * sizeof(float)));
    glEnableVertexAttribArray(1);
    //glBindVertexArray(0);
	
	shader.use(step);
	
	// pass projection matrix to shader
	glm::mat4 projection = glm::perspective(glm::radians(45.0f), (float)SCR_WIDTH / (float)SCR_HEIGHT, 0.1f, 100.0f);
    shader.setMat4("projection", projection); 
	
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
        
		glPolygonMode(GL_FRONT_AND_BACK, GL_LINE);
		
        // activate shader
        shader.use(step);
        
        // camera/view transformation
        glm::mat4 view = glm::mat4(1.0f); // make sure to initialize matrix to identity matrix first
        float radius = 10.0f;
        float camX   = sin(glfwGetTime()) * radius;
        float camZ   = cos(glfwGetTime()) * radius;
        view = glm::lookAt(glm::vec3(camX, 0.0f, camZ), glm::vec3(0.0f, 0.0f, 0.0f), glm::vec3(0.0f, 1.0f, 0.0f));
        shader.setMat4("view", view);

        // render boxes
        glBindVertexArray(VAO);
        
        // calculate the model matrix for each object and pass it to shader before drawing
        glm::mat4 model = glm::mat4(1.0f);
        model = glm::translate(model, glm::vec3(0.0f, 0.0f, 0.0f));
        float angle = 20.0f*0;
        model = glm::rotate(model, glm::radians(angle), glm::vec3(1.0f, 0.3f, 0.5f));
        shader.setMat4("model", model);

        glDrawArrays(GL_TRIANGLES, 0, sizeof(vertex));
        
        //glBindVertexArray(VAO);
        //glDrawArrays(GL_POINTS, 0, SIZE*SIZE);

        // glfw: swap buffers and poll IO events (keys pressed/released, mouse moved etc.)
        // -------------------------------------------------------------------------------
        glfwSwapBuffers(window);
        glfwPollEvents();
    }

    // optional: de-allocate all resources once they've outlived their purpose:
    // ------------------------------------------------------------------------
    glDeleteVertexArrays(1, &VAO);
    glDeleteBuffers(1, &VBO);

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


