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
float totalTime = 0.0;
float totalPrimitives = 0.0;
float lastHovTiem = 0.0;
int sizeMap;
int nTarget;
int currItemLan = 0;
int currItemShow = 0;
int framesCount = 1;
int nSamples = 0;

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
bool hideListLan = true;
bool hideListShow = true;


void initImGUI(GLFWwindow* window) {
    // Setup Dear ImGui context
    IMGUI_CHECKVERSION();
    ImGui::CreateContext();
    io = &ImGui::GetIO(); 
    io->WantCaptureMouse = true;
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
        nTarget = status.targetNP;
        firstTime = false;
        currItemLan = status.getLanguage();

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

void showInfo(std::string infoText, float width=100, float height=50) {
    if (ImGui::IsItemHovered(ImGuiHoveredFlags_RectOnly)) {
        if (lastHovTiem == 0) {
            lastHovTiem = ImGui::GetTime();
        }
        if (ImGui::GetTime() - lastHovTiem > 0.1 && !ImGui::IsAnyMouseDown()) {
            bool tempBool = true;
            ImGui::SetNextWindowPos(ImGui::GetMousePos() + ImVec2(10.0, -10.0));
            ImGui::SetNextWindowSize(ImVec2(width, height));
            ImGui::Begin("Info", &tempBool, ImGuiWindowFlags_NoCollapse || ImGuiWindowFlags_NoFocusOnAppearing);
            { ImGui::Text(infoText.c_str()); }
            ImGui::End();
        }
    } else if(!ImGui::IsAnyItemHovered()){
        lastHovTiem = 0;
    }
}

void mainWindow(ProgramStatus &status, Object &object) {
    ImGui::Begin(status.getText("Menu").c_str(), NULL, ImGuiWindowFlags_AlwaysAutoResize);

    char *itemsLan[10];

    for (int i=0; i<status.getNLanguages(); i++) {
        itemsLan[i] = new char[status.languages[i].length() + 1];
        strcpy(itemsLan[i], status.languages[i].c_str());
    }

    if (hideListLan) {
        ImGui::SetNextTreeNodeOpen(false);
    }

    if(ImGui::CollapsingHeader((status.getText("Language") + " " + std::string(itemsLan[currItemLan])).c_str(), ImGuiTreeNodeFlags_Bullet)) {
        hideListLan = false;
        if (ImGui::ListBox("", &currItemLan, itemsLan, status.getNLanguages())) {
            hideListLan = true;
            status.setLanguage(currItemLan);
        }
    }

    ImGui::TextColored(titleColor, status.getText("Parametrization").c_str());
    ImGui::Separator();

    if (ImGui::Button(status.getText("Select_file").c_str())) {
        ImGui::SetNextWindowSize(ImVec2(500, 300));
        ImGuiFileDialog::Instance()->OpenDialog("ChooseFileIn", "Choose File", ".in", ".");
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
    if (ImGui::Button(status.getText("New_file").c_str())) {
        show_nwfile_window = true;
    }
    ImGui::SameLine();
    if (ImGui::Button(status.getText("Edit").c_str())) {
        show_editor_window = true;
    }
    ImGui::SameLine();
    if (ImGui::Button(status.getText("Compile").c_str())){
        status.saveLastParam();
        status.setLoadShader(true);
    }

    if (ImGui::InputInt(status.getText("Map_size").c_str(), &sizeMap, 1, 100, ImGuiInputTextFlags_EnterReturnsTrue)) {
        status.setSizeMap(sizeMap);
        status.changeSizeMap = true;
    }
    ImGui::SameLine();
    if (ImGui::Button(status.getText("Update").c_str())) {
        status.setSizeMap(sizeMap);
        status.changeSizeMap = true;
    }

    if (status.getTotalParam() > 0) {
        ImGui::Checkbox(status.getText("Parameters").c_str(), &show_params_window);
    } else {
        bool alwaysFalse = false;
        show_params_window = false;
        ImGui::Checkbox("", &alwaysFalse);
        ImGui::SameLine();
        ImGui::TextColored(disabledColor, status.getText("Parameters").c_str());
    }

    ImGui::Text("\t\t\t\t\t\t\t\t\t\t\t\t\t");
    ImGui::TextColored(titleColor, status.getText("Visualization").c_str());
    ImGui::Separator();


    ImGui::Checkbox(status.getText("Invert_normal").c_str(), &status.invertNorm);
    showInfo(status.getText("Invert_normal_info"), 300);
    ImGui::SameLine();
    ImGui::Checkbox(status.getText("Polygon_mode").c_str(), &polMode);
    showInfo(status.getText("Polygon_mode_info"), 400);
    if (polMode != status.getActivePolMode()) {
        status.switchPolMode();
    }
    ImGui::SameLine();
    ImGui::Checkbox(status.getText("AutoRotate").c_str(), &autoRot);
    showInfo(status.getText("AutoRotate_info"), 300);
    if (autoRot != status.getAutoRotation()) {
        status.switchAutoRot();
    }

    if (ImGui::CollapsingHeader(status.getText("Show_vectors").c_str())) {
        ImGui::Checkbox(status.getText("Tangent").c_str(), &status.showTangents);
        ImGui::SameLine();
        ImGui::Checkbox(status.getText("Vector_per_vertex").c_str(), &status.showVectorsPerV);
        showInfo(status.getText("Vector_per_vertex_info"), 300);
        ImGui::Checkbox(status.getText("Bitangent").c_str(), &status.showCotangents);
        ImGui::Checkbox(status.getText("Normal").c_str(), &status.showNormals);
    }

    const char *items[] = {"Color", "Area", "K", "Height", "Critic"};

    if (hideListShow) {
        ImGui::SetNextTreeNodeOpen(false);
    }

    if(ImGui::CollapsingHeader((status.getText("Show") + " " + std::string(items[currItemShow])).c_str(), ImGuiTreeNodeFlags_Bullet)) {
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

    if (ImGui::ColorEdit3(status.getText("Font_color").c_str(), (float*)&fontColor, ImGuiColorEditFlags_NoInputs)) {
        status.fontColor = glm::vec3(fontColor);
    }
    ImGui::SameLine();
    if (ImGui::ColorEdit3(status.getText("Object_color").c_str(), (float*)&objectColor, ImGuiColorEditFlags_NoInputs)) {
        object.setColor(glm::vec3(objectColor));
        object.setColorChange(true);
    }

    ImGui::NewLine();
    ImGui::TextColored(titleColor, status.getText("Tessellation").c_str());
    ImGui::Separator();

    ImGui::Checkbox(status.getText("Tessellate").c_str(), &status.tessGlobal);
    showInfo(status.getText("Tessellate_info"), 300);
    ImGui::SliderFloat(status.getText("Threshold_K").c_str(), &(status.umbralLength), status.minLength, status.maxLength, "%.10f");
    showInfo(status.getText("Threshold_K_info"), 300);

    if (ImGui::CollapsingHeader(status.getText("Advanced_tessellation").c_str())) {
        ImGui::InputFloat("Min thres.", &status.minLength, 0.0f, 0.0f, "%.10f");
        ImGui::InputFloat("Max thres.", &status.maxLength, 0.0f, 0.0f, "%.10f");
        ImGui::SliderFloat("Tess. dist.", &(status.tessDist), 1.0f, 100.0f, "%.1f");
        ImGui::SliderFloat("Exponent K", &(status.expK), 0.01f, 3.0f, "%.3f");
        ImGui::SliderFloat("Threshold edge", &(status.umbralEdge), 0.001f, 1.0f, "%.3f");

        if (status.tessGlobal) {
            ImGui::Checkbox(status.getText("Improve_perf").c_str(), &status.improvePerf);
            showInfo(status.getText("Improve_perf_info"), 300);
            if (status.improvePerf) {
                ImGui::SameLine();
                ImGui::Checkbox(status.getText("Improve_perf_esp").c_str(), &status.improvePerfEsp);
                showInfo(status.getText("Improve_perf_esp_info"), 300);
            }
            ImGui::Checkbox(status.getText("Auto_threshold").c_str(), &status.autoUmbral);
            showInfo(status.getText("Auto_threshold_info"), 300);
            ImGui::SameLine();
            if (ImGui::InputInt(status.getText("Target").c_str(), &nTarget, 1, 100, ImGuiInputTextFlags_EnterReturnsTrue)) {
                status.targetNP = nTarget;
            }
            showInfo(status.getText("Target_info"), 300);
        }
    }

    ImGui::NewLine();
    ImGui::TextColored(titleColor, status.getText("Lighting").c_str());
    ImGui::Separator();

    ImGui::Checkbox(status.getText("Light_vector").c_str(), &show_light_vector);
    showInfo(status.getText("Light_vector_info"), 300);

    if (ImGui::CollapsingHeader(status.getText("Advanced_lighting").c_str())) {
        if (ImGui::SliderFloat("Ambient Strength", &(status.ambientStrength), 0.0f, 1.0f)) status.updateLightCoeff();
        if (ImGui::SliderFloat("Diffuse Strength", &(status.diffStrength), 0.0f, 1.0f)) status.updateLightCoeff();
        if (ImGui::SliderFloat("Specular Strength", &(status.specularStrength), 0.0f, 1.0f)) status.updateLightCoeff();
        ImGui::SliderFloat("Phong Exponent", &(status.phongExp), 1.0f, 30.0f);
    }

    ImGui::NewLine();
    ImGui::TextColored(titleColor, status.getText("Statistics").c_str());
    ImGui::Separator();

    if (show_render_info) {
        ImGui::SetNextTreeNodeOpen(true);
    }

    if (ImGui::CollapsingHeader(status.getText("Render_info").c_str())) {
        show_render_info = true;
        
        ImGui::Text("Application average %.3f ms/frame (%.1f FPS)", 3000.0f / ImGui::GetIO().Framerate, ImGui::GetIO().Framerate / 3.0);
        ImGui::Text("Application triangles %d", status.nPrimitives);
        if(status.recordInfo) {
            totalTime += ImGui::GetIO().DeltaTime * 3.0;

            if (totalTime < 1.0) {
                framesCount++;
                totalPrimitives += status.nPrimitives;
            } else {
                nSamples++;
                status.saveFrRateInfo(framesCount, (int) (totalPrimitives / framesCount));
                totalTime -= 1.0;
                framesCount = 1;
                totalPrimitives = status.nPrimitives;
            }
            
        }

        bool saveInfo = false;

        if (!status.recordInfo) {
            if (ImGui::Button(status.getText("Record").c_str())) {
                status.recordInfo = true;
            }
            ImGui::SameLine();
            if (ImGui::Button(status.getText("Save_info").c_str())) {
                status.recordInfo = false;
                status.saveFrRateInfo();
                nSamples = 0;
            }
        } else {
            if (ImGui::Button(status.getText("Stop").c_str())) {
                status.recordInfo = false;
            }
            ImGui::ProgressBar(nSamples / 23.0);
        }

        if (saveInfo || nSamples > 22) {
            status.recordInfo = false;
            status.saveFrRateInfo();
            nSamples = 0;
        }
        
    } else {
        show_render_info = false;
    }

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

    ImGui::Begin(status.getText("Editor").c_str(), &show_editor_window);
    ImGui::SetWindowSize(ImVec2(status.getWidth()*0.85, status.getHeight()*0.85));
    
    if (ImGui::Button(status.getText("Reload").c_str()) || firstEditor){
        status.loadText();
        strcpy(text, status.getFileText().c_str());
        firstEditor = false;
    }
    ImGui::SameLine();
    if (ImGui::Button(status.getText("Save").c_str())){
        status.setFileText(std::string(text));
        status.saveText();
    }
    ImGui::SameLine();
    if (ImGui::Button(status.getText("Compile").c_str())){
        status.setFileText(std::string(text));
        status.setLoadShader(true);
    }

    if (show_dialog_error) {
        ImGui::SetNextTreeNodeOpen(true);
        show_dialog_error = false;
    }

    if (ImGui::CollapsingHeader(status.getText("Analizer_output").c_str())) {
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
    ImGui::Begin(status.getText("Parameters").c_str(), &show_params_window, ImGuiWindowFlags_AlwaysAutoResize);   // Pass a pointer to our bool variable (the window will have a closing button that will clear the bool when clicked)
        
    for (int i = 0; i < status.getTotalParam(); i++) {
        std::string nameParam = "t" + std::to_string(i);
        bool chBoxSin = status.autoParams[i] == PARAM_SIN;
        bool chBoxLineal = status.autoParams[i] == PARAM_LINEAL;
        
        ImGui::SliderFloat(nameParam.c_str(), &(status.params[i]), 0.0f, 1.0f, "%.5f");            // Edit 1 float using a slider from 0.0f to 1.0f
        ImGui::SameLine();
        ImGui::PushID(2*i);
        if (ImGui::Checkbox("Sin", &chBoxSin)) {
            if (chBoxSin) {
                status.autoParams[i] = PARAM_SIN;
            } else {
                status.autoParams[i] = PARAM_MANUAL;
            }
        }
        ImGui::PopID();
        ImGui::SameLine();
        ImGui::PushID(2*i+1);
        if (ImGui::Checkbox("Lineal", &chBoxLineal)) {
            if (chBoxLineal) {
                status.autoParams[i] = PARAM_LINEAL;
            } else {
                status.autoParams[i] = PARAM_MANUAL;
            }
        }
        ImGui::PopID();
    }

    ImGui::End();
}

void lightVectorInterface(Light &light, glm::mat4 pvm_inv, ProgramStatus &status) {
    ImGui::Begin(status.getText("Light_vector").c_str(), &show_render_info, ImGuiWindowFlags_AlwaysAutoResize | ImGuiWindowFlags_NoCollapse);

    if (ImGui::gizmo3D("##Dir1", lightDir, 200, imguiGizmo::modeDirection)) {
        lightDirGlm = pvm_inv * glm::vec4(-lightDir.x, -lightDir.y, lightDir.z, lightVector.w);
        light.setDir(glm::vec3(lightDirGlm.x, lightDirGlm.y, lightDirGlm.z));
    }
    
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

    if (show_light_vector) { lightVectorInterface(light, pvm_inv, status); }

    // Rendering
    ImGui::Render();
    ImGui_ImplOpenGL3_RenderDrawData(ImGui::GetDrawData());
}

void cleanImGUI() {
    ImGui_ImplOpenGL3_Shutdown();
    ImGui_ImplGlfw_Shutdown();
    ImGui::DestroyContext();
}