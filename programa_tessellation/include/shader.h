

#ifndef SHADER_H
#define SHADER_H

#include <glad/glad.h>
#include <glm/glm.hpp>

#include <string>
#include <fstream>
#include <sstream>
#include <iostream>

class Shader
{
public:
    unsigned int ID;
    // constructor generates the shader on the fly
    // ------------------------------------------------------------------------
    Shader(bool normalMode = false)
    {
        // 1. retrieve the vertex/fragment source code from filePath
        std::string vertexCode;
        std::string fragmentCode;
        std::string tessCCode, tessVCode;
        std::ifstream functionsFile;
        std::ifstream vHeaderFile, vBodyFile;
        std::ifstream tcHeaderFile, tcBodyFile;
        std::ifstream tvHeaderFile, tvBodyFile;
        std::ifstream fShaderFile;

        // ensure ifstream objects can throw exceptions:
        functionsFile.exceptions (std::ifstream::failbit | std::ifstream::badbit);
        vHeaderFile.exceptions (std::ifstream::failbit | std::ifstream::badbit);
        vBodyFile.exceptions (std::ifstream::failbit | std::ifstream::badbit);
        tcHeaderFile.exceptions (std::ifstream::failbit | std::ifstream::badbit);
        tcBodyFile.exceptions (std::ifstream::failbit | std::ifstream::badbit);
        tvHeaderFile.exceptions (std::ifstream::failbit | std::ifstream::badbit);
        tvBodyFile.exceptions (std::ifstream::failbit | std::ifstream::badbit);
        fShaderFile.exceptions (std::ifstream::failbit | std::ifstream::badbit);
        try 
        {
            std::stringstream functionsStream;
            std::stringstream vHeaderStream, vBodyStream;
            std::stringstream tcHeaderStream, tcBodyStream;
            std::stringstream tvHeaderStream, tvBodyStream;
            std::stringstream fShaderStream;

            // open files
            functionsFile.open("shaders/functions.s");
            vHeaderFile.open("shaders/vertex_header.s");
            vBodyFile.open("shaders/vertex_body.s");

            /*if (normalMode) {
                tcShaderFile.open("shaders/geometryN_header.s");
                tvShaderFile.open("shaders/geometryN_body.s");
            } else {*/
                tcHeaderFile.open("shaders/tess_control_header.s");
                tcBodyFile.open("shaders/tess_control_body.s");
                tvHeaderFile.open("shaders/tess_eval_header.s");
                tvBodyFile.open("shaders/tess_eval_body.s");
            //}

            fShaderFile.open("shaders/fragment.s");

            // read file's buffer contents into streams
            functionsStream << functionsFile.rdbuf();

            vHeaderStream << vHeaderFile.rdbuf();
            vBodyStream << vBodyFile.rdbuf();

            tcHeaderStream << tcHeaderFile.rdbuf();
            tcBodyStream << tcBodyFile.rdbuf();
            tvHeaderStream << tvHeaderFile.rdbuf();
            tvBodyStream << tvBodyFile.rdbuf();

            fShaderStream << fShaderFile.rdbuf();	

            // close file handlers
            functionsFile.close();
            vHeaderFile.close();
            vBodyFile.close();
            tcHeaderFile.close();
            tcBodyFile.close();
            tvHeaderFile.close();
            tvBodyFile.close();
            fShaderFile.close();

            // convert stream into string
            vertexCode = vHeaderStream.str() + functionsStream.str() + vBodyStream.str();
            tessCCode = tcHeaderStream.str() + functionsStream.str() + tcBodyStream.str();
            tessVCode = tvHeaderStream.str() + functionsStream.str() + tvBodyStream.str();
            fragmentCode = fShaderStream.str();
        }
        catch (std::ifstream::failure& e)
        {
            std::cout << "ERROR::SHADER::FILE_NOT_SUCCESFULLY_READ" << std::endl;
        }
        const char * vShaderCode = vertexCode.c_str();
        const char * tcShaderCode = tessCCode.c_str();
        const char * tvShaderCode = tessVCode.c_str();
        const char * fShaderCode = fragmentCode.c_str();

        // 2. compile shaders
        unsigned int vertex, tess_control, tess_evaluation, fragment;
        // vertex shader
        vertex = glCreateShader(GL_VERTEX_SHADER);
        glShaderSource(vertex, 1, &vShaderCode, NULL);
        glCompileShader(vertex);
        checkCompileErrors(vertex, "VERTEX");

        // tess_control shader
        tess_control = glCreateShader(GL_TESS_CONTROL_SHADER);
        glShaderSource(tess_control, 1, &tcShaderCode, NULL);
        glCompileShader(tess_control);
        checkCompileErrors(tess_control, "TESSELLATION CONTROL");

        // tess_evaluation shader
        tess_evaluation = glCreateShader(GL_TESS_EVALUATION_SHADER);
        glShaderSource(tess_evaluation, 1, &tvShaderCode, NULL);
        glCompileShader(tess_evaluation);
        checkCompileErrors(tess_evaluation, "TESSELLATION EVAL");

        // fragment Shader
        fragment = glCreateShader(GL_FRAGMENT_SHADER);
        glShaderSource(fragment, 1, &fShaderCode, NULL);
        glCompileShader(fragment);
        checkCompileErrors(fragment, "FRAGMENT");
        

        // shader Program
        ID = glCreateProgram();
        glAttachShader(ID, vertex);
        glAttachShader(ID, tess_control);
        glAttachShader(ID, tess_evaluation);
        glAttachShader(ID, fragment);
        glLinkProgram(ID);
        checkCompileErrors(ID, "PROGRAM");

        // delete the shaders as they're linked into our program now and no longer necessery
        glDeleteShader(vertex);
        glDeleteShader(fragment);
        glDeleteShader(tess_control);
        glDeleteShader(tess_evaluation);
    }
    
    // activate the shader
    // ------------------------------------------------------------------------
    void use()//float step) 
    { 
        glUseProgram(ID); 
    }
    // utility uniform functions
    // ------------------------------------------------------------------------
    void setBool(const std::string &name, bool value) const
    {         
        glUniform1i(glGetUniformLocation(ID, name.c_str()), (int)value); 
    }
    // ------------------------------------------------------------------------
    void setInt(const std::string &name, int value) const
    { 
        glUniform1i(glGetUniformLocation(ID, name.c_str()), value); 
    }
    // ------------------------------------------------------------------------
    void setFloat(const std::string &name, float value) const
    { 
        glUniform1f(glGetUniformLocation(ID, name.c_str()), value); 
    }
    // ------------------------------------------------------------------------
    void setVec2(const std::string &name, const glm::vec2 &value) const
    { 
        glUniform2fv(glGetUniformLocation(ID, name.c_str()), 1, &value[0]); 
    }
    void setVec2(const std::string &name, float x, float y) const
    { 
        glUniform2f(glGetUniformLocation(ID, name.c_str()), x, y); 
    }
    // ------------------------------------------------------------------------
    void setVec3(const std::string &name, const glm::vec3 &value) const
    { 
        glUniform3fv(glGetUniformLocation(ID, name.c_str()), 1, &value[0]); 
    }
    void setVec3(const std::string &name, float x, float y, float z) const
    { 
        glUniform3f(glGetUniformLocation(ID, name.c_str()), x, y, z); 
    }
    // ------------------------------------------------------------------------
    void setVec4(const std::string &name, const glm::vec4 &value) const
    { 
        glUniform4fv(glGetUniformLocation(ID, name.c_str()), 1, &value[0]); 
    }
    void setVec4(const std::string &name, float x, float y, float z, float w) 
    { 
        glUniform4f(glGetUniformLocation(ID, name.c_str()), x, y, z, w); 
    }
    // ------------------------------------------------------------------------
    void setMat2(const std::string &name, const glm::mat2 &mat) const
    {
        glUniformMatrix2fv(glGetUniformLocation(ID, name.c_str()), 1, GL_FALSE, &mat[0][0]);
    }
    // ------------------------------------------------------------------------
    void setMat3(const std::string &name, const glm::mat3 &mat) const
    {
        glUniformMatrix3fv(glGetUniformLocation(ID, name.c_str()), 1, GL_FALSE, &mat[0][0]);
    }
    // ------------------------------------------------------------------------
    void setMat4(const std::string &name, const glm::mat4 &mat) const
    {
        glUniformMatrix4fv(glGetUniformLocation(ID, name.c_str()), 1, GL_FALSE, &mat[0][0]);
    }
    // ------------------------------------------------------------------------
    void setArray(const std::string &name, const GLfloat v[], int tam) const
    {
        glUniform1fv(glGetUniformLocation(ID, name.c_str()), tam, v);
    }

private:
    // utility function for checking shader compilation/linking errors.
    // ------------------------------------------------------------------------
    void checkCompileErrors(GLuint shader, std::string type)
    {
        GLint success;
        GLchar infoLog[1024];
        if(type != "PROGRAM")
        {
            glGetShaderiv(shader, GL_COMPILE_STATUS, &success);
            if(!success)
            {
                glGetShaderInfoLog(shader, 1024, NULL, infoLog);
                std::cout << "ERROR::SHADER_COMPILATION_ERROR of type: " << type << "\n" << infoLog << "\n -- --------------------------------------------------- -- " << std::endl;
            }
        }
        else
        {
            glGetProgramiv(shader, GL_LINK_STATUS, &success);
            if(!success)
            {
                glGetProgramInfoLog(shader, 1024, NULL, infoLog);
                std::cout << "ERROR::PROGRAM_LINKING_ERROR of type: " << type << "\n" << infoLog << "\n -- --------------------------------------------------- -- " << std::endl;
            }
        }
    }
};
#endif


