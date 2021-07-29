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
    if not areUIParametersValid(parameters, elementType) then return false end
    local createdElement = createElement(elementType, nil, sourceResource)
    if not createdElement then return false end
    local uiTemplate = getUITemplate(elementType)
    if not uiTemplate then return false end

    local elementReference = createdElements[createdElement]
    elementReference.gui = cloneUIOutline(elementType)
    for i, j in ipairs(availableElements[elementType].syntax.parameters) do
        if j.name == "width" or j.name == "height" then
            elementReference.gui[j.name] = math.max(availableElements[elementType].minimumSize, parameters[i]) + (availableElements[elementType].contentSection.padding*2)
            if j.name == "height" then
                elementReference.gui[j.name] = elementReference.gui[j.name] + (availableElements["beautify_window"].minimumSize/2)
            end
        else
            elementReference.gui[j.name] = parameters[i]
            if j.name == "y" then
                elementReference.gui[j.name] = parameters[i] + (availableElements["beautify_window"].minimumSize/2)
            end
        end
    end
    elementReference.gui.postGUI = (parameters[6] and true) or false
    elementReference.gui.contentSection = {
        startX = availableElements["beautify_window"].contentSection.padding,
        startY = (availableElements["beautify_window"].minimumSize/2) + availableElements["beautify_window"].contentSection.padding,
        width = elementReference.gui.width - (availableElements["beautify_window"].contentSection.padding*2),
        height = elementReference.gui.height + availableElements["beautify_window"].minimumSize - (availableElements["beautify_window"].contentSection.padding*2)
    }
    if elementReference.gui.contentSection.width > 0 and elementReference.gui.contentSection.height > 0 then
        elementReference.gui.renderTarget = DxRenderTarget(elementReference.gui.contentSection.width, elementReference.gui.contentSection.height, true)
    end
    elementReference.isValid = true
    return createdElement

end