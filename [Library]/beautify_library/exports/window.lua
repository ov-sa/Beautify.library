----------------------------------------------------------------
--[[ Resource: Beautify Library
     Script: exports: window.lua
     Server: -
     Author: OvileAmriam
     Developer: -
     DOC: 01/02/2021 (OvileAmriam)
     Desc: Window's Exports ]]--
----------------------------------------------------------------


----------------------------------
--[[ Function: Creates Window ]]--
----------------------------------

function createWindow(...)

    local parameters = {...}
    local elementType = "beautify_window"
    if not isUIParametersValid(parameters, elementType) then return false end
    local createdElement = createElement(elementType, nil, sourceResource)
    if not createdElement then return false end
    local uiTemplate = getUITemplate(elementType)
    if not uiTemplate then return false end

    createdElements[createdElement] = {
        gui = {},
        scroller = {},
        renderTarget = false
    }
    for i, j in ipairs(availableElements[elementType].__syntax.parameters) do
        if j.name == "x" or j.name == "y" then
            createdElements[createdElement].gui[j.name] = math.max(0, parameters[i])
        elseif j.name == "width" or j.name == "height" then
            createdElements[createdElement].gui[j.name] = math.max(availableElements[elementType].__minimumSize, parameters[i])
        else
            createdElements[createdElement].gui[j.name] = parameters[i]
        end
    end
    createdElements[createdElement].gui.postGUI = (parameters[7] and true) or false
    createdElements[createdElement].gui.titleBar = {
        font = uiTemplate.titleBar.font,
        fontColor = uiTemplate.titleBar.fontColor,
        color = uiTemplate.titleBar.color,
        close_button = {
            fontColor = uiTemplate.titleBar.close_button.fontColor
        }
    }
    createdElements[createdElement].gui.contentSection = {
        startX = availableElements["beautify_window"].__contentSection.padding,
        startY = availableElements["beautify_window"].__titleBar.height + availableElements["beautify_window"].__contentSection.padding,
        width = createdElements[createdElement].gui.width - (availableElements["beautify_window"].__contentSection.padding*2),
        height = createdElements[createdElement].gui.height - availableElements["beautify_window"].__titleBar.height - (availableElements["beautify_window"].__contentSection.padding*2)
    }
    if createdElements[createdElement].gui.contentSection.width > 0 and createdElements[createdElement].gui.contentSection.height > 0 then
        createdElements[createdElement].gui.renderTarget = DxRenderTarget(createdElements[createdElement].gui.contentSection.width, createdElements[createdElement].gui.contentSection.height, false)
    end
    createdElements[createdElement].isValid = true
    return createdElement

end