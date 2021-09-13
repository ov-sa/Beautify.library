----------------------------------------------------------------
--[[ Resource: Beautify Library
     Script: exports: button.lua
     Server: -
     Author: OvileAmriam
     Developer: -
     DOC: 01/02/2021 (OvileAmriam)
     Desc: Button's Exports ]]--
----------------------------------------------------------------


-----------------
--[[ Imports ]]--
-----------------

local imports = {
    ipairs = ipairs,
    addEventHandler = addEventHandler,
    triggerEvent = triggerEvent,
    isUIValid = isUIValid,
    cloneUIOutline = cloneUIOutline,
    areUIParametersValid = areUIParametersValid,
    math = {
        min = math.min,
        max = math.max
    }
}

imports.addEventHandler("onClientResourceStart", resource, function()
    imports.__getUITemplate = __getUITemplate
    imports.createUIElement = createUIElement
    imports.updateElement = updateElement
    imports.reloadElement = reloadElement
end)


-------------------
--[[ Variables ]]--
-------------------

local elementType = "beautify_button"


----------------------------------
--[[ Function: Creates Button ]]--
----------------------------------

function createButton(...)

    local parameters = {...}
    local parameterValidity = {imports.areUIParametersValid(parameters, elementType)}
    if not parameterValidity[1] then return false end
    local templateReferenceName = parameters[(parameterValidity[2])]
    local templateReference = availableElements[elementType].syntax.parameters["TEMPLATE_PARAMETERS"][templateReferenceName]
    local createdElement = imports.createUIElement(elementType, parameters[(#availableElements[elementType].syntax.parameters + #templateReference + 1)], sourceResource)
    if not createdElement then return false end

    local elementReference = createdElements[createdElement]
    local elementTemplate = imports.__getUITemplate(elementType, elementReference.sourceResource)
    if not elementTemplate then return false end

    elementReference.gui = imports.cloneUIOutline(elementType)
    for i, j in imports.ipairs(availableElements[elementType].syntax.parameters) do
        elementReference.gui[j.name] = parameters[i]
    end
    for i, j in imports.ipairs(templateReference) do
        local parameterIndex = #availableElements[elementType].syntax.parameters + i
        if (j.name == "width") or (j.name == "height") or (j.name == "size") then
            local minRequirementIndex = "minimum"..j.name:sub(1, 1):upper()..j.name:sub(2)
            if availableElements[elementType]["TEMPLATE_PROPERTIES"][templateReferenceName][minRequirementIndex] then
                elementReference.gui[j.name] = imports.math.max(availableElements[elementType]["TEMPLATE_PROPERTIES"][templateReferenceName][minRequirementIndex], parameters[parameterIndex])
            else
                elementReference.gui[j.name] = parameters[parameterIndex]
            end
            elementReference.gui[j.name] = imports.math.max(0, imports.math.max(availableElements[elementType].minimumSize, elementReference.gui[j.name]))
        else
            elementReference.gui[j.name] = parameters[parameterIndex]
        end
    end
    elementReference.gui.postGUI = (parameters[(#availableElements[elementType].syntax.parameters + #templateReference + 2)] and true) or false
    elementReference.isValid = true
    imports.reloadElement(createdElement)
    return createdElement

end


--------------------------------------------
--[[ Functions: Sets/Gets Button's Text ]]--
--------------------------------------------

function setButtonText(...)

    local parameters = {...}
    if not imports.areUIParametersValid(parameters, elementType, "setButtonText") then return false end
    local element = parameters[1]
    if not imports.isUIValid(element) then return false end

    local elementReference = createdElements[element]
    if (elementReference.gui.text == parameters[2]) then return false end
    elementReference.gui.text = parameters[2]
    imports.updateElement(element)
    imports.triggerEvent("onClientUIAltered", element)
    return true

end

function getButtonText(...)

    local parameters = {...}
    if not imports.areUIParametersValid(parameters, elementType, "getButtonText") then return false end
    local element = parameters[1]
    if not imports.isUIValid(element) then return false end

    local elementReference = createdElements[element]
    return elementReference.gui.text

end