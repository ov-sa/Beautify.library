----------------------------------------------------------------
--[[ Resource: Beautify Library
     Script: exports: label.lua
     Server: -
     Author: OvileAmriam
     Developer: -
     DOC: 01/02/2021 (OvileAmriam)
     Desc: Label's Exports ]]--
----------------------------------------------------------------


-------------------
--[[ Variables ]]--
-------------------

local elementType = "beautify_label"


---------------------------------
--[[ Function: Creates Label ]]--
---------------------------------

function createLabel(...)

    local parameters = {...}
    if not areUIParametersValid(parameters, elementType) then return false end
    local createdElement = createElement(elementType, parameters[(#availableElements[elementType].syntax.parameters + #templateReference + 1)], sourceResource)
    if not createdElement then return false end
    local uiTemplate = getUITemplate(elementType)
    if not uiTemplate then return false end

    local elementReference = createdElements[createdElement]
    elementReference.gui = cloneUIOutline(elementType)
    for i, j in ipairs(availableElements[elementType].syntax.parameters) do
        if (j.name == "width") or (j.name == "height") then
            elementReference.gui[j.name] = math.max(0, parameters[i])
        else
            elementReference.gui[j.name] = parameters[i]
        end
    end
    elementReference.gui.postGUI = (parameters[(#availableElements[elementType].syntax.parameters + 2)] and true) or false
    elementReference.isValid = true
    return createdElement

end


-------------------------------------------
--[[ Functions: Sets/Gets Label's Text ]]--
-------------------------------------------

function setLabelText(...)

    local parameters = {...}
    if not areUIParametersValid(parameters, elementType, "setLabelText") then return false end
    local element = parameters[1]
    if not isUIValid(element) then return false end

    local elementReference = createdElements[element]
    if (elementReference.gui.text == parameters[2]) then return false end
    elementReference.gui.text = parameters[2]
    return true

end

function getLabelText(...)

    local parameters = {...}
    if not areUIParametersValid(parameters, elementType, "getLabelText") then return false end
    local element = parameters[1]
    if not isUIValid(element) then return false end

    local elementReference = createdElements[element]
    return elementReference.gui.text

end