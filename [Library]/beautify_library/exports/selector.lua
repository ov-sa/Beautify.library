----------------------------------------------------------------
--[[ Resource: Beautify Library
     Script: exports: selector.lua
     Server: -
     Author: vStudio
     Developer: -
     DOC: 01/02/2021
     Desc: Selector's Exports ]]--
----------------------------------------------------------------


-----------------
--[[ Imports ]]--
-----------------

local imports = {
    tonumber = tonumber,
    ipairs = ipairs,
    addEventHandler = addEventHandler,
    triggerEvent = triggerEvent,
    isUIValid = isUIValid,
    cloneUIOutline = cloneUIOutline,
    areUIParametersValid = areUIParametersValid,
    math = math
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

local elementType = "beautify_selector"


------------------------------------
--[[ Function: Creates Selector ]]--
------------------------------------

function createSelector(...)

    local parameters = {...}
    if not imports.areUIParametersValid(parameters, elementType) then return false end
    local createdElement = imports.createUIElement(elementType, parameters[(#availableElements[elementType].syntax.parameters + 1)], sourceResource)
    if not createdElement then return false end

    local elementReference = createdElements[createdElement]
    local elementTemplate = imports.__getUITemplate(elementType, elementReference.sourceResource)
    if not elementTemplate then return false end

    elementReference.gui = imports.cloneUIOutline(elementType)
    elementReference.selectorDataList = {
        list = {},
        selection = 1
    }
    for i, j in imports.ipairs(availableElements[elementType].syntax.parameters) do
        if (j.name == "width") or (j.name == "height") then
            elementReference.gui[j.name] = imports.math.max(0, imports.math.max(availableElements[elementType].minimumSize, parameters[i]))
        elseif j.name == "type" then
            elementReference.gui[j.name] = (availableElements[elementType].validTypes[(parameters[i])] and parameters[i]) or "horizontal"
            if elementReference.gui[j.name] == "horizontal" then
                elementReference.gui.width = imports.math.max(0, imports.math.max(availableElements[elementType].minimumSize*2, elementReference.gui.width))
            elseif elementReference.gui[j.name] == "vertical" then
                elementReference.gui.height = imports.math.max(0, imports.math.max(availableElements[elementType].minimumSize*2, elementReference.gui.height))
            end
        else
            elementReference.gui[j.name] = parameters[i]
        end
    end
    elementReference.gui.postGUI = (parameters[(#availableElements[elementType].syntax.parameters + 2)] and true) or false
    elementReference.isValid = true
    imports.reloadElement(createdElement)
    return createdElement

end


---------------------------------------------------
--[[ Functions: Sets/Gets Selector's Data List ]]--
---------------------------------------------------

function setSelectorDataList(...)

    local parameters = {...}
    if not imports.areUIParametersValid(parameters, elementType, "setSelectorDataList") then return false end
    local element = parameters[1]
    if not imports.isUIValid(element) then return false end

    local elementReference = createdElements[element]
    elementReference.selectorDataList.list = parameters[2]
    if not elementReference.selectorDataList.list[(elementReference.selectorDataList.selection)] then
        elementReference.selectorDataList.selection = 1
        imports.triggerEvent("onClientUISelectionAltered", element, false)
    end
    imports.updateElement(element)
    imports.triggerEvent("onClientUIAltered", element)
    return true

end

function getSelectorDataList(...)

    local parameters = {...}
    if not imports.areUIParametersValid(parameters, elementType, "getSelectorDataList") then return false end
    local element = parameters[1]
    if not imports.isUIValid(element) then return false end

    local elementReference = createdElements[element]
    return elementReference.selectorDataList.list

end


-----------------------------------------------------
--[[ Functions: Clears/Sets/Gets Selector's Text ]]--
-----------------------------------------------------

function clearSelectorText(...)

    local parameters = {...}
    if not imports.areUIParametersValid(parameters, elementType, "clearSelectorText") then return false end
    local element = parameters[1]
    if not imports.isUIValid(element) then return false end

    local elementReference = createdElements[element]
    if not elementReference.gui.text then return false end
    elementReference.gui.text = nil
    imports.updateElement(element)
    imports.triggerEvent("onClientUIAltered", element)
    return true

end

function setSelectorText(...)

    local parameters = {...}
    if not imports.areUIParametersValid(parameters, elementType, "setSelectorText") then return false end
    local element = parameters[1]
    if not imports.isUIValid(element) then return false end

    local elementReference = createdElements[element]
    if (elementReference.gui.text == parameters[2]) then return false end
    elementReference.gui.text = parameters[2]
    imports.updateElement(element)
    imports.triggerEvent("onClientUIAltered", element)
    return true

end

function getSelectorText(...)

    local parameters = {...}
    if not imports.areUIParametersValid(parameters, elementType, "getSelectorText") then return false end
    local element = parameters[1]
    if not imports.isUIValid(element) then return false end

    local elementReference = createdElements[element]
    if not elementReference.gui.text then return false end
    return elementReference.gui.text

end


-----------------------------------------------------------
--[[ Functions: Clears/Sets/Gets Selector's Text Color ]]--
-----------------------------------------------------------

function clearSelectorTextColor(...)

    local parameters = {...}
    if not imports.areUIParametersValid(parameters, elementType, "clearSelectorTextColor") then return false end
    local element = parameters[1]
    if not imports.isUIValid(element) then return false end

    local elementReference = createdElements[element]
    if not elementReference.gui.fontColor then return false end
    elementReference.gui.fontColor = nil
    imports.reloadElement(element)
    imports.triggerEvent("onClientUIAltered", element)
    return true

end

function setSelectorTextColor(...)

    local parameters = {...}
    if not imports.areUIParametersValid(parameters, elementType, "setSelectorTextColor") then return false end
    local element = parameters[1]
    if not imports.isUIValid(element) then return false end

    parameters[2][1] = imports.tonumber(parameters[2][1]); parameters[2][2] = imports.tonumber(parameters[2][2]);
    parameters[2][3] = imports.tonumber(parameters[2][3]); parameters[2][4] = imports.tonumber(parameters[2][4]);
    for i = 1, 4, 1 do
        if not parameters[2][i] or (parameters[2][i] < 0) or (parameters[2][i] > 255) then
            return false
        end
    end
    local elementReference = createdElements[element]
    local selectorTextColor = getSelectorTextColor(element)
    if not selectorTextColor or ((selectorTextColor[1] == parameters[2][1]) and (selectorTextColor[2] == parameters[2][2]) and (selectorTextColor[3] == parameters[2][3]) and (selectorTextColor[4] == parameters[2][4])) then return false end
    elementReference.gui.fontColor = {parameters[2][1], parameters[2][2], parameters[2][3], parameters[2][4]}
    imports.reloadElement(element)
    imports.triggerEvent("onClientUIAltered", element)
    return true

end

function getSelectorTextColor(...)

    local parameters = {...}
    if not imports.areUIParametersValid(parameters, elementType, "getSelectorTextColor") then return false end
    local element = parameters[1]
    if not imports.isUIValid(element) then return false end

    local elementReference = createdElements[element]
    local elementTemplate = imports.__getUITemplate(elementType, elementReference.sourceResource)
    return elementReference.gui.fontColor or elementTemplate.fontColor

end


---------------------------------------------------
--[[ Functions: Sets/Gets Selector's Selection ]]--
---------------------------------------------------

function setSelectorSelection(...)

    local parameters = {...}
    if not imports.areUIParametersValid(parameters, elementType, "setSelectorSelection") then return false end
    local element = parameters[1]
    if not imports.isUIValid(element) then return false end

    local elementReference = createdElements[element]
    parameters[2] = imports.math.max(1, imports.math.min(#elementReference.selectorDataList.list, parameters[2]))
    if not elementReference.selectorDataList.list[(parameters[2])] or (elementReference.selectorDataList.selection and elementReference.selectorDataList.selection == parameters[2]) then return false end
    elementReference.selectorDataList.selection = parameters[2]
    imports.updateElement(element)
    imports.triggerEvent("onClientUISelectionAltered", element, elementReference.selectorDataList.selection)
    return true

end

function getSelectorSelection(...)

    local parameters = {...}
    if not imports.areUIParametersValid(parameters, elementType, "getSelectorSelection") then return false end
    local element = parameters[1]
    if not imports.isUIValid(element) then return false end

    local elementReference = createdElements[element]
    if not elementReference.selectorDataList.selection or not elementReference.selectorDataList.list[(elementReference.selectorDataList.selection)] then return false end
    return elementReference.selectorDataList.selection

end