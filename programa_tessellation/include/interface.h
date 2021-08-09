#include "imgui.h"
#include "imgui_impl_glfw.h"
#include "imgui_impl_opengl3.h"
#include "programStatus.h"
#include "light.h"
#include "object.h"
#include "imGuIZMOquat.h"
#include "ImGuiFileDialog.h"
#include <iostream>

#if defined(_MSC_VER) && (_MSC_VER >= 1900) && !defined(IMGUI_DISABLE_WIN32_FUNCTIONS)
#pragma comment(lib, "legacy_stdio_definitions")
#endif


ImGuiIO *io;
ImVec4 titleColor = ImVec4(0.3, 0.3, 1.0, 1.0);
ImVec4 disabledColor = ImVec4(0.3, 0.3, 0.4, 1.0);
glm::vec4 lightVector, lightDirGlm;
glm::vec3 objectColor, fontColor;
vec3 lightDir;

std::string filePathName;
std::string fileName;

const char* glsl_version = "#version 130";
char nameFile[100];
char text[10000];
int sizeMap;
int currItemShow = 0;

bool autoRot = false;
bool polMode = false;
bool show_nwfile_window = false;
bool show_editor_window = false;
bool show_dialog_error = false;
bool show_params_window = false;
bool show_render_info = true;
bool show_light_vector = false;
bool firstEditor = true;
bool firstTime = true;
bool hideListShow = true;


void initImGUI(GLFWwindow* window) {
    // Setup Dear ImGui context
    IMGUI_CHECKVERSION();
    ImGui::CreateContext();
    io = &ImGui::GetIO(); 
    io->WantCaptureMouse = false;
    (void)io;

    // Setup Dear ImGui style
    ImGui::StyleColorsDark();

    // Setup Platform/Renderer bindings
    ImGui_ImplGlfw_InitForOpenGL(window, true);
    ImGui_ImplOpenGL3_Init(glsl_version);
}

void updateVariables(ProgramStatus &status, Light &light, Object &object, glm::mat4 pvm) {
    autoRot = status.getAutoRotation();
    polMode = status.getActivePolMode();

    if (show_light_vector) {
        lightVector = pvm * glm::vec4(light.getDir(), 0.0);
        lightDir = vec3(-lightVector.x, -lightVector.y, lightVector.z);
    }

    if (firstTime) {
        strcpy(nameFile, status.getParamFile().c_str());
        sizeMap = status.getSizeMap();
        objectColor =  object.getColor();
        fontColor = status.fontColor;
        firstTime = false;

        if (status.getTotalParam() > 0) {
            show_params_window = true;
        }
    }

    if (status.showError) {
        show_editor_window = true;
        show_dialog_error = true;
        status.showError = false;
    }
}

void mainWindow(ProgramStatus &status, Object &object) {
    ImGui::Begin("Menu", NULL, ImGuiWindowFlags_AlwaysAutoResize);

    ImGui::TextColored(titleColor, "Parametrization");

    if (ImGui::Button("Select file")) {
        ImGui::SetNextWindowSize(ImVec2(500, 300));
        ImGuiFileDialog::Instance()->OpenDialog("ChooseFileIn", "Coose File", ".in", ".");
    }
    
    if (ImGuiFileDialog::Instance()->Display("ChooseFileIn")) {
        if (ImGuiFileDialog::Instance()->IsOk()) {
            status.setParamPath(ImGuiFileDialog::Instance()->GetCurrentPath());
            status.setParamFile(ImGuiFileDialog::Instance()->GetCurrentFileName());
            status.loadText();
            strcpy(text, status.getFileText().c_str());
            firstEditor = true;
        }

        ImGuiFileDialog::Instance()->Close();
    }
    ImGui::SameLine();
    if (ImGui::Button("New file")) {
        show_nwfile_window = true;
    }
    ImGui::SameLine();
    if (ImGui::Button("Edit")) {
        show_editor_window = true;
    }
    ImGui::SameLine();
    if (ImGui::Button("Compile")){
        status.saveLastParam();
        status.setLoadShader(true);
    }

    ImGui::SliderInt("Map size", &sizeMap, 4, 80);
    ImGui::SameLine();
    if (ImGui::Button("Update")) {
        status.setSizeMap(sizeMap);
        status.changeSizeMap = true;
    }

    if (status.getTotalParam() > 0) {
        ImGui::Checkbox("Params", &show_params_window);
    } else {
        bool alwaysFalse = false;
        show_params_window = false;
        ImGui::Checkbox("", &alwaysFalse);
        ImGui::SameLine();
        ImGui::TextColored(disabledColor, "Params");
    }

    ImGui::Text("\t\t\t\t\t\t\t\t\t\t\t\t\t");
    ImGui::TextColored(titleColor, "Visualization");
    ImGui::Separator();

    ImGui::Checkbox("Polygon mode", &polMode);
    if (polMode != status.getActivePolMode()) {
        status.switchPolMode();
    }
    ImGui::Checkbox("AutoRotate", &autoRot);
    if (autoRot != status.getAutoRotation()) {
        status.switchAutoRot();
    }

    ImGui::Checkbox("Vector per vertex", &status.showVectorsPerV);
    ImGui::SameLine();
    ImGui::Checkbox("Invert normal", &status.invertNorm);

    ImGui::Checkbox("tangent", &status.showTangents);
    ImGui::SameLine();
    ImGui::Checkbox("bitangent", &status.showCotangents);
    ImGui::SameLine();
    ImGui::Checkbox("normal", &status.showNormals);

    

    if (ImGui::CollapsingHeader("Advanced visualization")) {
        ImGui::Checkbox("Tess global", &status.tessGlobal);
        ImGui::SameLine();
        ImGui::Checkbox("Improve performance", &status.improvePerf);
        ImGui::Checkbox("Tess edge", &status.tessEdge);
        ImGui::SliderFloat("Umbral length", &(status.umbralLength), 0.000001f, 0.005f, "%.8f");
        ImGui::SliderFloat("Umbral edge", &(status.umbralEdge), 0.001f, 1.0f, "%.3f");

        const char *items[] = {"Color", "Area", "K", "Height", "Critic"};

        if (hideListShow) {
            ImGui::SetNextTreeNodeOpen(false);
        }

        if(ImGui::CollapsingHeader(("Show " + std::string(items[currItemShow])).c_str(), ImGuiTreeNodeFlags_Bullet)) {
            hideListShow = false;
            if (ImGui::ListBox("", &currItemShow, items, 5)) {
                hideListShow = true;
            }
        }

        ImGui::Columns(2, "", false);
        ImGui::SetColumnWidth(0, 280);
        ImGui::SetColumnWidth(1, 10);

        switch(currItemShow) {
            case 0:
                status.resetShow();
                break;
            case 1:
                status.showDiffArea = true;
                status.updateShowArea();
                ImGui::SliderFloat("Coeff Area", &(status.coeffArea), 1.0f, 50.0f);
                break;
            case 2:
                status.showK = true;
                status.updateShowK();
                ImGui::SliderFloat("Coeff K\t", &(status.coeffK), 0.2f, 5.0f);
                break;
            case 3:
                status.showHeight = true;
                status.updateShowHeight();
                ImGui::SliderFloat("Coeff Height\t", &(status.coeffHeight), 0.01f, 20.0f);
                ImGui::SliderFloat("Ref Height\t", &(status.refHeight), -10.0f, 10.0f);
                ImGui::SliderInt("Nº layers\t", &(status.nLayers), 1, 40);
                break;
            case 4:
                status.showCritic = true;
                status.updateShowCritic();
                break; 
        }

        ImGui::NextColumn();

        ImGui::Columns(1);
    }

    ImGui::NewLine();
    ImGui::TextColored(titleColor, "Lighting");
    ImGui::Separator();

    if (ImGui::ColorEdit3("Font color", (float*)&fontColor, ImGuiColorEditFlags_NoInputs)) {
        status.fontColor = glm::vec3(fontColor);
    }
    ImGui::SameLine();
    if (ImGui::ColorEdit3("Object color", (float*)&objectColor, ImGuiColorEditFlags_NoInputs)) {
        object.setColor(glm::vec3(objectColor));
        object.setColorChange(true);
    }
    ImGui::SameLine();
    ImGui::Checkbox("Light vector", &show_light_vector);

    if (ImGui::CollapsingHeader("Advanced lighting")) {
        if (ImGui::SliderFloat("Ambient Strength", &(status.ambientStrength), 0.0f, 1.0f)) status.updateLightCoeff();
        if (ImGui::SliderFloat("Diffuse Strength", &(status.diffStrength), 0.0f, 1.0f)) status.updateLightCoeff();
        if (ImGui::SliderFloat("Specular Strength", &(status.specularStrength), 0.0f, 1.0f)) status.updateLightCoeff();
        ImGui::SliderFloat("Phong Exponent", &(status.phongExp), 1.0f, 30.0f);
    }

    ImGui::NewLine();
    ImGui::TextColored(titleColor, "Statistics");
    ImGui::Separator();

    ImGui::Checkbox("Render info", &show_render_info);

    ImGui::End();
}

void nwfileWindow(ProgramStatus &status) {
    ImGui::Begin("Create file", &show_nwfile_window, ImGuiWindowFlags_NoCollapse | ImGuiWindowFlags_AlwaysAutoResize);

    if (ImGui::InputText("New file's name", nameFile, sizeof(nameFile),
                         ImGuiInputTextFlags_EnterReturnsTrue) ||
        ImGui::Button("Create")) 
    {
        strcpy(text, "");
        status.setParamFile(std::string(nameFile));
        status.setFileTextDefault();
        status.saveText();
        show_editor_window = true;
        firstEditor = true;
        show_nwfile_window = false;
    }

    ImGui::End();
}

void editorWindow(ProgramStatus &status) {
    std::string textStr = std::string(text);
    int numLines = std::count(textStr.begin(), textStr.end(), '\n');
    int editorHeight = status.getHeight()*0.75;

    if (numLines*15 > editorHeight) {
        editorHeight = numLines*15;
    }

    ImGui::Begin("Editor", &show_editor_window);
    ImGui::SetWindowSize(ImVec2(status.getWidth()*0.85, status.getHeight()*0.85));
    
    if (ImGui::Button("Reload") || firstEditor){
        status.loadText();
        strcpy(text, status.getFileText().c_str());
        firstEditor = false;
    }
    ImGui::SameLine();
    if (ImGui::Button("Save")){
        status.setFileText(std::string(text));
        status.saveText();
    }
    ImGui::SameLine();
    if (ImGui::Button("Compile")){
        status.setFileText(std::string(text));
        status.setLoadShader(true);
    }

    if (show_dialog_error) {
        ImGui::SetNextTreeNodeOpen(true);
        show_dialog_error = false;
    }

    if (ImGui::CollapsingHeader("Analizer output")) {
        ImGui::Text((status.getErrorText()).c_str());
    }

    ImGui::Separator();

    if (ImGui::Button("Add '^'")){
        strcpy(text, (std::string(text) + "^").c_str());
    }

    ImGui::Columns(2);
    ImGui::SetColumnWidth(0, 50);
    ImGui::SetColumnWidth(1, status.getWidth()*0.8);
    
    std::string linesStr = "";
    char lines[1000];

    for (int i=0; i<=numLines; i++) {
        linesStr += std::to_string(i+1) + "\n";
    }
    strcpy(lines, linesStr.c_str());
    ImGui::InputTextMultiline("", lines, sizeof(lines), ImVec2(40, editorHeight), ImGuiInputTextFlags_ReadOnly);

    ImGui::NextColumn();

    ImGui::PushID("1");
    ImGui::InputTextMultiline("", text, sizeof(text), ImVec2(status.getWidth()*0.75, editorHeight), ImGuiInputTextFlags_AllowTabInput);
    ImGui::PopID();

    ImGui::Columns(1);

    ImGui::End();
}

void paramsWindow(ProgramStatus &status) {
    ImGui::Begin("Params", &show_params_window, ImGuiWindowFlags_AlwaysAutoResize);   // Pass a pointer to our bool variable (the window will have a closing button that will clear the bool when clicked)
        
    for (int i = 0; i < status.getTotalParam(); i++) {
        std::string nameParam = "t" + std::to_string(i);
        ImGui::SliderFloat(nameParam.c_str(), &(status.params[i]), 0.0f, 1.0f);            // Edit 1 float using a slider from 0.0f to 1.0f
        ImGui::SameLine();
        ImGui::PushID(i);
        ImGui::Checkbox("Auto", &status.autoParams[i]);
        ImGui::PopID();
    }

    ImGui::End();
}

void lightVectorInterface(Light &light, glm::mat4 pvm_inv) {
    ImGui::Begin("Light vector", &show_render_info, ImGuiWindowFlags_AlwaysAutoResize | ImGuiWindowFlags_NoCollapse);

    if (ImGui::gizmo3D("##Dir1", lightDir, 200, imguiGizmo::modeDirection)) {
        lightDirGlm = pvm_inv * glm::vec4(-lightDir.x, -lightDir.y, lightDir.z, lightVector.w);
        light.setDir(glm::vec3(lightDirGlm.x, lightDirGlm.y, lightDirGlm.z));
    }
    
    ImGui::End();
}

void renderInfo() {
    ImGui::Begin("Render info", &show_render_info, ImGuiWindowFlags_AlwaysAutoResize | ImGuiWindowFlags_NoCollapse);
    ImGui::Text("Application average %.3f ms/frame (%.1f FPS)", 3000.0f / ImGui::GetIO().Framerate, ImGui::GetIO().Framerate / 3.0);
    ImGui::End();
}

void visualizeInterface(ProgramStatus &status, Light &light, Object &object, glm::mat4 pvm, glm::mat4 pvm_inv) { 
   	ImGui_ImplOpenGL3_NewFrame();
    ImGui_ImplGlfw_NewFrame();
    ImGui::NewFrame();

    updateVariables(status, light, object, pvm);

    { mainWindow(status, object); }

    if (show_nwfile_window) { nwfileWindow(status); }

    if (show_editor_window) { editorWindow(status); }

    if (show_params_window) { paramsWindow(status); }

    if (show_light_vector) { lightVectorInterface(light, pvm_inv); }

    if (show_render_info) { renderInfo(); }

    // Rendering
    ImGui::Render();
    ImGui_ImplOpenGL3_RenderDrawData(ImGui::GetDrawData());
}

void cleanImGUI() {
    ImGui_ImplOpenGL3_Shutdown();
    ImGui_ImplGlfw_Shutdown();
    ImGui::DestroyContext();
}