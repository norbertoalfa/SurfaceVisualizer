#include "imgui.h"
#include "imgui_impl_glfw.h"
#include "imgui_impl_opengl3.h"
#include "programStatus.h"
#include <iostream>

#if defined(_MSC_VER) && (_MSC_VER >= 1900) && !defined(IMGUI_DISABLE_WIN32_FUNCTIONS)
#pragma comment(lib, "legacy_stdio_definitions")
#endif


char nameFile[100];
char text[10000];
const char* glsl_version = "#version 130";
bool show_editor_window = false;
bool show_params_window = true;
bool show_render_info = true;

ImVec4 clear_color = ImVec4(0.45f, 0.55f, 0.60f, 1.00f);

void initImGUI(GLFWwindow* window)
{
    // Setup Dear ImGui context
    IMGUI_CHECKVERSION();
    ImGui::CreateContext();
    ImGuiIO& io = ImGui::GetIO(); 
    io.WantCaptureMouse = false;
    (void)io;

    // Setup Dear ImGui style
    ImGui::StyleColorsDark();

    // Setup Platform/Renderer bindings
    ImGui_ImplGlfw_InitForOpenGL(window, true);
    ImGui_ImplOpenGL3_Init(glsl_version);
}

void visualizeInterface(ProgramStatus &status)
{ 
    bool autoRot = status.getAutoRotation();
    bool polMode = status.getActivePolMode();
    bool showNormals = status.getShowNormals();
    bool showDiffArea = status.showDiffArea;

    strcpy(nameFile, status.getParamFile().c_str());

	ImGui_ImplOpenGL3_NewFrame();
    ImGui_ImplGlfw_NewFrame();
    ImGui::NewFrame();

    {
        static float f = 0.0f;
        static int counter = 0;

        ImGui::Begin("Visualizador de homotopías");             // Create a window called "Hello, world!" and append into it.

        ImGui::Text("Fichero de entrada");

        if(ImGui::InputText("", nameFile, sizeof(nameFile), ImGuiInputTextFlags_EnterReturnsTrue)) {
            status.setParamFile(nameFile);
            status.setLoadShader(true);
        }

        ImGui::Checkbox("AutoRotate", &autoRot);
        if (autoRot != status.getAutoRotation()) {
            status.switchAutoRot();
        }

        ImGui::Checkbox("Polygon mode", &polMode);
        if (polMode != status.getActivePolMode()) {
            status.switchPolMode();
        }

        ImGui::Checkbox("Show normal", &showNormals);
        if (showNormals != status.getShowNormals()) {
            status.switchShowNormals();
        }

        ImGui::Checkbox("Editor", &show_editor_window);
        ImGui::Checkbox("Params", &show_params_window);
        ImGui::Checkbox("Render info", &show_render_info);

        ImGui::SliderFloat("Umbral Area", &(status.umbralArea), 0.0f, 2.0f);

        ImGui::Checkbox("Show diff area", &showDiffArea);
        if (showDiffArea != status.showDiffArea) {
            status.showDiffArea = showDiffArea;
        }
        ImGui::SameLine();
        ImGui::SliderFloat("Coeff Area", &(status.coeffArea), 1.0f, 50.0f);

        /*ImGui::ColorEdit3("clear color", (float*)&clear_color); // Edit 3 floats representing a color

        ImGui::SameLine();
        ImGui::Text("counter = %d", counter);*/

        ImGui::End();
    }

    if (show_editor_window) {
        ImGui::Begin("Editor", &show_editor_window);   // Pass a pointer to our bool variable (the window will have a closing button that will clear the bool when clicked)
        
        ImGui::Text("Fichero de edición");

        ImGui::PushID(0);
        if(ImGui::InputText("", nameFile, sizeof(nameFile), ImGuiInputTextFlags_EnterReturnsTrue)) {
            status.setParamFile(nameFile);
            status.setLoadShader(true);
        }
        ImGui::PopID();
        
        if (ImGui::Button("Load")){
            status.loadText();
            strcpy(text, status.getFileText().c_str());
        }

        ImGui::SameLine();

        if (ImGui::Button("Save")){
            status.setFileText(std::string(text));
            status.saveText();
            status.setLoadShader(true);
        }

        ImGui::PushID(1);
        ImGui::InputTextMultiline("", text, sizeof(text), ImVec2(status.getWidth()*0.75, status.getHeight()*0.75));
        ImGui::PopID();

        ImGui::End();
    }

    if (show_params_window) {
        ImGui::Begin("Params", &show_params_window);   // Pass a pointer to our bool variable (the window will have a closing button that will clear the bool when clicked)
        
        for (int i = 0; i < 10; i++) {
            std::string nameParam = "t" + std::to_string(i);
            ImGui::SliderFloat(nameParam.c_str(), &(status.params[i]), 0.0f, 1.0f);            // Edit 1 float using a slider from 0.0f to 1.0f
            ImGui::SameLine();
            ImGui::PushID(i);
            ImGui::Checkbox("Auto", &status.autoParams[i]);
            ImGui::PopID();
        }

        ImGui::End();
    }

    if (show_render_info) {
        ImGui::Begin("Render info", &show_render_info);   // Pass a pointer to our bool variable (the window will have a closing button that will clear the bool when clicked)
        
        ImGui::Text("Application average %.3f ms/frame (%.1f FPS)", 3000.0f / ImGui::GetIO().Framerate, ImGui::GetIO().Framerate / 3.0);

        ImGui::End();
    }

    // Rendering
    ImGui::Render();
    ImGui_ImplOpenGL3_RenderDrawData(ImGui::GetDrawData());
}

void cleanImGUI()
{
    ImGui_ImplOpenGL3_Shutdown();
    ImGui_ImplGlfw_Shutdown();
    ImGui::DestroyContext();
}