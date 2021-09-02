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
    local createdElement = createUIElement(elementType, parameters[(#availableElements[elementType].syntax.parameters + 1)], sourceResource)
    if not createdElement then return false end

    local elementReference = createdElements[createdElement]
    local elementTemplate = __getUITemplate(elementType, elementReference.sourceResource)
    if not elementTemplate then return false end

    elementReference.gui = cloneUIOutline(elementType)
    elementReference.selectorDataList = {
        list = {},
        selection = 1
    }
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


---------------------------------------------------
--[[ Functions: Sets/Gets Selector's Data List ]]--
---------------------------------------------------

function setSelectorDataList(...)

    local parameters = {...}
    if not areUIParametersValid(parameters, elementType, "setSelectorDataList") then return false end
    local element = parameters[1]
    if not isUIValid(element) then return false end

    local elementReference = createdElements[element]
    elementReference.selectorDataList.list = parameters[2]
    if not elementReference.selectorDataList.list[(elementReference.selectorDataList.selection)] then
        elementReference.selectorDataList.selection = 1
        triggerEvent("onClientUISelectionAltered", element, false)
    end
    updateElement(element)
    triggerEvent("onClientUIAltered", element)
    return true

end

function getSelectorDataList(...)

    local parameters = {...}
    if not areUIParametersValid(parameters, elementType, "getSelectorDataList") then return false end
    local element = parameters[1]
    if not isUIValid(element) then return false end

    local elementReference = createdElements[element]
    return elementReference.selectorDataList.list

end


-----------------------------------------------------
--[[ Functions: Clears/Sets/Gets Selector's Text ]]--
-----------------------------------------------------

function clearSelectorText(...)

    local parameters = {...}
    if not areUIParametersValid(parameters, elementType, "clearSelectorText") then return false end
    local element = parameters[1]
    if not isUIValid(element) then return false end

    local elementReference = createdElements[element]
    if not elementReference.gui.text then return false end
    elementReference.gui.text = nil
    updateElement(element)
    triggerEvent("onClientUIAltered", element)
    return true

end

function setSelectorText(...)

    local parameters = {...}
    if not areUIParametersValid(parameters, elementType, "setSelectorText") then return false end
    local element = parameters[1]
    if not isUIValid(element) then return false end

    local elementReference = createdElements[element]
    if (elementReference.gui.text == parameters[2]) then return false end
    elementReference.gui.text = parameters[2]
    updateElement(element)
    triggerEvent("onClientUIAltered", element)
    return true

end

function getSelectorText(...)

    local parameters = {...}
    if not areUIParametersValid(parameters, elementType, "getSelectorText") then return false end
    local element = parameters[1]
    if not isUIValid(element) then return false end

    local elementReference = createdElements[element]
    if not elementReference.gui.text then return false end
    return elementReference.gui.text

end


-----------------------------------------------------------
--[[ Functions: Clears/Sets/Gets Selector's Text Color ]]--
-----------------------------------------------------------

function clearSelectorTextColor(...)

    local parameters = {...}
    if not areUIParametersValid(parameters, elementType, "clearSelectorTextColor") then return false end
    local element = parameters[1]
    if not isUIValid(element) then return false end

    local elementReference = createdElements[element]
    if not elementReference.gui.fontColor then return false end
    elementReference.gui.fontColor = nil
    elementReference.gui["__UI_CACHE__"].reloadElement = true
    triggerEvent("onClientUIAltered", element)
    return true

end

function setSelectorTextColor(...)

    local parameters = {...}
    if not areUIParametersValid(parameters, elementType, "setSelectorTextColor") then return false end
    local element = parameters[1]
    if not isUIValid(element) then return false end

    parameters[2][1] = tonumber(parameters[2][1]); parameters[2][2] = tonumber(parameters[2][2]);
    parameters[2][3] = tonumber(parameters[2][3]); parameters[2][4] = tonumber(parameters[2][4]);
    for i = 1, 4, 1 do
        if not parameters[2][i] or (parameters[2][i] < 0) or (parameters[2][i] > 255) then
            return false
        end
    end
    local elementReference = createdElements[element]
    local selectorTextColor = getSelectorTextColor(element)
    if not selectorTextColor or ((selectorTextColor[1] == parameters[2][1]) and (selectorTextColor[2] == parameters[2][2]) and (selectorTextColor[3] == parameters[2][3]) and (selectorTextColor[4] == parameters[2][4])) then return false end
    elementReference.gui.fontColor = {parameters[2][1], parameters[2][2], parameters[2][3], parameters[2][4]}
    elementReference.gui["__UI_CACHE__"].reloadElement = true
    triggerEvent("onClientUIAltered", element)
    return true

end

function getSelectorTextColor(...)

    local parameters = {...}
    if not areUIParametersValid(parameters, elementType, "getSelectorTextColor") then return false end
    local element = parameters[1]
    if not isUIValid(element) then return false end

    local elementReference = createdElements[element]
    local elementTemplate = __getUITemplate(elementType, elementReference.sourceResource)
    return elementReference.gui.fontColor or elementTemplate.fontColor

end


---------------------------------------------------
--[[ Functions: Sets/Gets Selector's Selection ]]--
---------------------------------------------------

function setSelectorSelection(...)

    local parameters = {...}
    if not areUIParametersValid(parameters, elementType, "setSelectorSelection") then return false end
    local element = parameters[1]
    if not isUIValid(element) then return false end

    local elementReference = createdElements[element]
    parameters[2] = math.max(1, math.min(#elementReference.selectorDataList.list, parameters[2]))
    if not elementReference.selectorDataList.list[(parameters[2])] or (elementReference.selectorDataList.selection and elementReference.selectorDataList.selection == parameters[2]) then return false end
    elementReference.selectorDataList.selection = parameters[2]
    updateElement(element)
    triggerEvent("onClientUISelectionAltered", element, elementReference.selectorDataList.selection)
    return true

end

function getSelectorSelection(...)

    local parameters = {...}
    if not areUIParametersValid(parameters, elementType, "getSelectorSelection") then return false end
    local element = parameters[1]
    if not isUIValid(element) then return false end

    local elementReference = createdElements[element]
    if not elementReference.selectorDataList.selection or not elementReference.selectorDataList.list[(elementReference.selectorDataList.selection)] then return false end
    return elementReference.selectorDataList.selection

end