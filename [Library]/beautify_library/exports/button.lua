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
    local createdElement, elementParent = createElement(elementType, parameters[(#availableElements[elementType].syntax.parameters + #templateReference + 1)], sourceResource)
    if not createdElement then return false end
    local uiTemplate = getUITemplate(elementType)
    if not uiTemplate then return false end

    local elementReference = (elementParent and createdParentElements[elementParent][createdElement]) or createdElements[createdElement]
    elementReference.gui = cloneUIOutline(elementType)
    for i, j in ipairs(availableElements[elementType].syntax.parameters) do
        elementReference.gui[j.name] = parameters[i]
    end
    for i, j in ipairs(templateReference) do
        local parameterIndex = #availableElements[elementType].syntax.parameters + i
        if (j.name == "width") or (j.name == "height") or (j.name == "size") then
            local conditionalChecks = {
                "minimum"..j.name:sub(1,1):upper()..j.name:sub(2),
                "minimumSize"
            }
            local isConditionMatched = false
            for k, v in ipairs(conditionalChecks) do
                if availableElements[elementType]["TEMPLATE_PROPERTIES"][templateReferenceName][v] then
                    elementReference.gui[j.name] = math.max(availableElements[elementType]["TEMPLATE_PROPERTIES"][templateReferenceName][v], parameters[parameterIndex])
                    isConditionMatched = true
                    break
                end
            end
            if not isConditionMatched then
                elementReference.gui[j.name] = parameters[parameterIndex]
            end
        else
            elementReference.gui[j.name] = parameters[parameterIndex]
        end
    end
    elementReference.gui.postGUI = (parameters[(#availableElements[elementType].syntax.parameters + #templateReference + 2)] and true) or false
    elementReference.isValid = true
    return createdElement

end