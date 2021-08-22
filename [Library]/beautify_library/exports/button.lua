----------------------------------------------------------------
--[[ Resource: Beautify Library
     Script: exports: button.lua
     Server: -
     Author: OvileAmriam
     Developer: -
     DOC: 01/02/2021 (OvileAmriam)
     Desc: Button's Exports ]]--
----------------------------------------------------------------


-------------------
--[[ Variables ]]--
-------------------

local elementType = "beautify_button"


----------------------------------
--[[ Function: Creates Button ]]--
----------------------------------

function createButton(...)

    local parameters = {...}
    local parameterValidity = {areUIParametersValid(parameters, elementType)}
    if not parameterValidity[1] then return false end
    local templateReferenceName = parameters[(parameterValidity[2])]
    local templateReference = availableElements[elementType].syntax.parameters["TEMPLATE_PARAMETERS"][templateReferenceName]
    local createdElement = createElement(elementType, parameters[(#availableElements[elementType].syntax.parameters + #templateReference + 1)], sourceResource)
    if not createdElement then return false end

    local elementReference = createdElements[createdElement]
    local elementTemplate = __getUITemplate(elementType, elementReference.sourceResource)
    if not elementTemplate then return false end

    elementReference.gui = cloneUIOutline(elementType)
    for i, j in ipairs(availableElements[elementType].syntax.parameters) do
        elementReference.gui[j.name] = parameters[i]
    end
    for i, j in ipairs(templateReference) do
        local parameterIndex = #availableElements[elementType].syntax.parameters + i
        if (j.name == "width") or (j.name == "height") or (j.name == "size") then
            local minRequirementIndex = "minimum"..j.name:sub(1, 1):upper()..j.name:sub(2)
            if availableElements[elementType]["TEMPLATE_PROPERTIES"][templateReferenceName][minRequirementIndex] then
                elementReference.gui[j.name] = math.max(availableElements[elementType]["TEMPLATE_PROPERTIES"][templateReferenceName][minRequirementIndex], parameters[parameterIndex])
            else
                elementReference.gui[j.name] = parameters[parameterIndex]
            end
            elementReference.gui[j.name] = math.max(0, math.max(availableElements[elementType].minimumSize, elementReference.gui[j.name]))
        else
            elementReference.gui[j.name] = parameters[parameterIndex]
        end
    end
    elementReference.gui.postGUI = (parameters[(#availableElements[elementType].syntax.parameters + #templateReference + 2)] and true) or false
    elementReference.isValid = true
    return createdElement

end


--------------------------------------------
--[[ Functions: Sets/Gets Button's Text ]]--
--------------------------------------------

function setButtonText(...)

    local parameters = {...}
    if not areUIParametersValid(parameters, elementType, "setButtonText") then return false end
    local element = parameters[1]
    if not isUIValid(element) then return false end

    local elementReference = createdElements[element]
    if (elementReference.gui.text == parameters[2]) then return false end
    elementReference.gui.text = parameters[2]
    triggerEvent("onClientUIAltered", element)
    return true

end

function getButtonText(...)

    local parameters = {...}
    if not areUIParametersValid(parameters, elementType, "getButtonText") then return false end
    local element = parameters[1]
    if not isUIValid(element) then return false end

    local elementReference = createdElements[element]
    return elementReference.gui.text

end