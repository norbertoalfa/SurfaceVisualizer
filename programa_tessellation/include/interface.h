#include "imgui.h"
#include "imgui_impl_glfw.h"
#include "imgui_impl_opengl3.h"
#include "programStatus.h"
#include "object.h"
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
bool firstEditor = true;
bool firstColor = true;

ImVec4 clear_color = ImVec4(0.45f, 0.55f, 0.60f, 1.00f);
glm::vec3 objectColor, fontColor;

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

void visualizeInterface(ProgramStatus &status, Object &object)
{ 
    bool autoRot = status.getAutoRotation();
    bool polMode = status.getActivePolMode();
    bool showNormals = status.getShowNormals();
    bool showDiffArea = status.showDiffArea;
    bool showK = status.showK;
    ImVec4 titleColor = ImVec4(0.3, 0.3, 1.0, 1.0);
    
    if (firstColor) {
        objectColor =  object.getColor();
        fontColor = status.fontColor;
        firstColor = false;
    }

    strcpy(nameFile, status.getParamFile().c_str());

	ImGui_ImplOpenGL3_NewFrame();
    ImGui_ImplGlfw_NewFrame();
    ImGui::NewFrame();

    {
        static float f = 0.0f;
        static int counter = 0;

        ImGui::Begin("Menu", NULL, ImGuiWindowFlags_AlwaysAutoResize);

        ImGui::TextColored(titleColor, "Parametrización");

        if(ImGui::InputText("", nameFile, sizeof(nameFile), ImGuiInputTextFlags_EnterReturnsTrue)) {
            status.setParamFile(nameFile);
            status.setLoadShader(true);
        }
        ImGui::SameLine();
        if (ImGui::Button("Edit")) {
            show_editor_window = true;
        }
        ImGui::SameLine();
        if (ImGui::Button("Compile")){
            status.saveText();
            status.setLoadShader(true);
        }

        ImGui::Checkbox("Params", &show_params_window);

        ImGui::Text("\t\t\t\t\t\t\t\t\t\t\t\t\t");
        ImGui::TextColored(titleColor, "Visualization");
        ImGui::Separator();

        ImGui::Checkbox("Polygon mode", &polMode);
        if (polMode != status.getActivePolMode()) {
            status.switchPolMode();
        }
        ImGui::SameLine();
        ImGui::Checkbox("Show normal", &showNormals);
        if (showNormals != status.getShowNormals()) {
            status.switchShowNormals();
        }
        ImGui::SameLine();
        ImGui::Checkbox("Invert normal", &status.invertNorm);

        ImGui::Checkbox("AutoRotate", &autoRot);
        if (autoRot != status.getAutoRotation()) {
            status.switchAutoRot();
        }

        if (ImGui::ColorEdit3("Font color", (float*)&fontColor)) {
            status.fontColor = glm::vec3(fontColor);
        }

        if (ImGui::ColorEdit3("Object color", (float*)&objectColor)) {
            object.setColor(glm::vec3(objectColor));
            object.setColorChange(true);
        }

        if (ImGui::CollapsingHeader("Advanced visualization")) {
            ImGui::Columns(2, "", false);
            ImGui::SetColumnWidth(0, 280);
            ImGui::SetColumnWidth(1, 100);

            ImGui::SliderFloat("Umbral Area", &(status.umbralArea), 0.006f, 2.5f, "%.5f");

            ImGui::SliderFloat("Coeff Area", &(status.coeffArea), 1.0f, 50.0f);
            ImGui::SliderFloat("Coeff K\t", &(status.coeffK), 0.2f, 5.0f);

            ImGui::NextColumn();
            ImGui::NewLine();

            ImGui::Checkbox("Show area", &showDiffArea);
            if (showDiffArea != status.showDiffArea) {
                status.showDiffArea = showDiffArea;
            }

            ImGui::Checkbox("Show K", &showK);
            if (showK != status.showK) {
                status.showK = showK;
            }

            ImGui::Columns(1);
        }

        ImGui::NewLine();
        ImGui::TextColored(titleColor, "Lighting");
        ImGui::Separator();

        if (ImGui::CollapsingHeader("Advanced lighting")) {
            ImGui::SliderFloat("Ambient Strength", &(status.ambientStrength), 0.0f, 1.0f);
            ImGui::SliderFloat("Diffuse Strength", &(status.diffStrength), 0.0f, 1.0f);
            ImGui::SliderFloat("Specular Strength", &(status.specularStrength), 0.0f, 1.0f);
            ImGui::SliderFloat("Phong Exponent", &(status.phongExp), 1.0f, 30.0f);
        }

        ImGui::NewLine();
        ImGui::TextColored(titleColor, "Statistics");
        ImGui::Separator();

        ImGui::Checkbox("Render info", &show_render_info);

        ImGui::End();
    }

    if (show_editor_window) {
        ImGui::Begin("Editor", &show_editor_window, ImGuiWindowFlags_AlwaysAutoResize);
        
        ImGui::Text("Fichero de edición");

        ImGui::PushID(0);
        if(ImGui::InputText("", nameFile, sizeof(nameFile), ImGuiInputTextFlags_EnterReturnsTrue)) {
            status.setParamFile(nameFile);
            status.loadText();
            strcpy(text, status.getFileText().c_str());
        }
        ImGui::PopID();
        
        if (ImGui::Button("Load") || firstEditor){
            status.loadText();
            strcpy(text, status.getFileText().c_str());
            firstEditor = false;
        }

        ImGui::SameLine();

        if (ImGui::Button("Save")){
            status.setFileText(std::string(text));
            status.saveText();
        }

        ImGui::PushID(1);
        ImGui::InputTextMultiline("", text, sizeof(text), ImVec2(status.getWidth()*0.75, status.getHeight()*0.75));
        ImGui::PopID();

        ImGui::End();
    }

    if (show_params_window) {
        ImGui::Begin("Params", &show_params_window, ImGuiWindowFlags_AlwaysAutoResize);   // Pass a pointer to our bool variable (the window will have a closing button that will clear the bool when clicked)
        
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
        ImGui::Begin("Render info", &show_render_info, ImGuiWindowFlags_AlwaysAutoResize | ImGuiWindowFlags_NoCollapse);
        
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