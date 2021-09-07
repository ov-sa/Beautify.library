----------------------------------------------------------------
--[[ Resource: Beautify Library
     Script: exports: window.lua
     Server: -
     Author: OvileAmriam
     Developer: -
     DOC: 01/02/2021 (OvileAmriam)
     Desc: Window's Exports ]]--
----------------------------------------------------------------


-------------------
--[[ Variables ]]--
-------------------

local elementType = "beautify_window"


----------------------------------
--[[ Function: Creates Window ]]--
----------------------------------

function createWindow(...)

    local parameters = {...}
    if not areUIParametersValid(parameters, elementType) then return false end
    local createdElement = createUIElement(elementType, parameters[(#availableElements[elementType].syntax.parameters + 1)], sourceResource)
    if not createdElement then return false end

    local elementReference = createdElements[createdElement]
    local elementTemplate = __getUITemplate(elementType, elementReference.sourceResource)
    if not elementTemplate then return false end

    elementReference.gui = cloneUIOutline(elementType)
    for i, j in ipairs(availableElements[elementType].syntax.parameters) do
        if (j.name == "width") or (j.name == "height") then
            elementReference.gui[j.name] = math.max(0, math.max(availableElements[elementType].minimumSize, parameters[i]) + (availableElements[elementType].viewSection.padding*2))
            if j.name == "height" then
                elementReference.gui[j.name] = elementReference.gui[j.name] + (availableElements[elementType].minimumSize*0.5)
            end
        else
            elementReference.gui[j.name] = parameters[i]
        end
    end
    elementReference.gui.postGUI = (parameters[(#availableElements[elementType].syntax.parameters + 2)] and true) or false
    elementReference.gui.viewSection = {
        startX = availableElements[elementType].viewSection.padding,
        startY = (availableElements[elementType].minimumSize*0.5) + availableElements[elementType].viewSection.padding,
        width = elementReference.gui.width - (availableElements[elementType].viewSection.padding*2),
        height = elementReference.gui.height - (availableElements[elementType].minimumSize*0.5) - (availableElements[elementType].viewSection.padding*2)
    }
    if (elementReference.gui.viewSection.width > math.max(0, availableElements[elementType].minimumSize*0.5)) and (elementReference.gui.viewSection.height > math.max(0, availableElements[elementType].minimumSize*0.5)) then
        elementReference.gui.renderTarget = dxCreateRenderTarget(elementReference.gui.viewSection.width, elementReference.gui.viewSection.height, true)
    end
    elementReference.isValid = true
    reloadElement(createdElement)
    return createdElement

end