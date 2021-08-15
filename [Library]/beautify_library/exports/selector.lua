----------------------------------------------------------------
--[[ Resource: Beautify Library
     Script: exports: selector.lua
     Server: -
     Author: OvileAmriam
     Developer: -
     DOC: 01/02/2021 (OvileAmriam)
     Desc: Selector's Exports ]]--
----------------------------------------------------------------


-------------------
--[[ Variables ]]--
-------------------

local elementType = "beautify_selector"


------------------------------------
--[[ Function: Creates Selector ]]--
------------------------------------

function createSelector(...)

    local parameters = {...}
    if not areUIParametersValid(parameters, elementType) then return false end
    local createdElement = createElement(elementType, parameters[(#availableElements[elementType].syntax.parameters + 1)], sourceResource)
    if not createdElement then return false end

    local elementReference = createdElements[createdElement]
    local elementTemplate = __getUITemplate(elementType, elementReference.sourceResource)
    if not elementTemplate then return false end

    elementReference.gui = cloneUIOutline(elementType)
    for i, j in ipairs(availableElements[elementType].syntax.parameters) do
        if (j.name == "width") or (j.name == "height") then
            elementReference.gui[j.name] = math.max(0, math.max(availableElements[elementType].minimumSize, parameters[i]))
        elseif j.name == "type" then
            elementReference.gui[j.name] = (availableElements[elementType].validTypes[(parameters[i])] and parameters[i]) or "horizontal"
            if elementReference.gui[j.name] == "horizontal" then
                elementReference.gui.width = math.max(0, math.max(availableElements[elementType].minimumSize*2, elementReference.gui.width))
            elseif elementReference.gui[j.name] == "vertical" then
                elementReference.gui.height = math.max(0, math.max(availableElements[elementType].minimumSize*2, elementReference.gui.height))
            end
        else
            elementReference.gui[j.name] = parameters[i]
        end
    end
    elementReference.gui.postGUI = (parameters[(#availableElements[elementType].syntax.parameters + 2)] and true) or false
    elementReference.isValid = true
    return createdElement

end