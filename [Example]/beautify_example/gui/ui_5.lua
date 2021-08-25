----------------------------------------------------------------
--[[ Resource: Beautify Library (Example) 
     Script: gui: ui_5.lua
     Server: -
     Author: OvileAmriam
     Developer: -
     DOC: 14/08/2021 (OvileAmriam)
     Desc: Example UI ]]--
----------------------------------------------------------------


----------------------
-->> Example UI 5 <<--
----------------------

local currentTemplateIndex = false
local loadedTemplates = {
    {template = "dark-blue-theme", label = "Enable Dark (Blue) Mode", labelColor = {125, 125, 255, 255}},
    {template = "dark-red-theme", label = "Enable Dark (Red) Mode", labelColor = {255, 125, 125, 255}},
    {template = "dark-green-theme", label = "Enable Dark (Green) Mode", labelColor = {125, 255, 125, 255}},
    {template = "dark-yellow-theme", label = "Enable Dark (Yellow) Mode", labelColor = {255, 255, 125, 255}}
}

local function switchTemplate(state)
    
    local isTemplateToBeReloaded = false
    local isToBeReverted = source == loadedTemplates[currentTemplateIndex].checker
    if not state then
        if isToBeReverted then
            beautify.checkbox.setSelection(source, true)
        end
    else
        if not isToBeReverted then
            local selectedTemplateIndex = false
            for i, j in ipairs(loadedTemplates) do
                if source == j.checker then
                    selectedTemplateIndex = i
                    break
                end
            end
            if selectedTemplateIndex then
                currentTemplateIndex = selectedTemplateIndex
                for i, j in ipairs(loadedTemplates) do
                    if j.checker ~= source then
                        beautify.checkbox.setSelection(j.checker, false)
                    end
                end
                isTemplateToBeReloaded = true
            end
        end
    end

    if isTemplateToBeReloaded then
        for i, j in pairs(availableTemplates) do
            beautify.setUITemplate(i, j[(loadedTemplates[currentTemplateIndex].template)])
        end
    end

end

function createExampleUI5()

    local window_width, window_height = 275, 150
    local createdWindow = beautify.window.create(725 + 300 + 25, (CLIENT_MTA_RESOLUTION[2] - 350)/2 - window_height, window_width, window_height, "Dev. UI #5 (Templates)", nil, false)

    local checkbox_width, checkbox_height = 210, 20
    for i, j in ipairs(loadedTemplates) do
        j.checker = beautify.checkbox.create((window_width - checkbox_width)/2, ((checkbox_height + 5)*(i - 1)) + 5, checkbox_width, checkbox_height, createdWindow, false)
        beautify.checkbox.setText(j.checker, j.label)
        beautify.checkbox.setTextColor(j.checker, j.labelColor)
        beautify.setUIVisible(j.checker, true)
        addEventHandler("onClientUISelectionAltered", j.checker, switchTemplate)
    end
    if #loadedTemplates > 0 then
        currentTemplateIndex = 1
        beautify.checkbox.setSelection(loadedTemplates[1].checker, true)
    end

    beautify.setUIVisible(createdWindow, true)
    beautify.setUIDraggable(createdWindow, true)

end