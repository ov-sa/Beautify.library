----------------------------------------------------------------
--[[ Resource: Beautify Library
     Script: exports: checkbox.lua
     Server: -
     Author: OvileAmriam
     Developer: -
     DOC: 01/02/2021 (OvileAmriam)
     Desc: Checkbox's Exports ]]--
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

local elementType = "beautify_checkbox"


------------------------------------
--[[ Function: Creates Checkbox ]]--
------------------------------------

function createCheckbox(...)

    local parameters = {...}
    if not imports.areUIParametersValid(parameters, elementType) then return false end
    local createdElement = imports.createUIElement(elementType, parameters[(#availableElements[elementType].syntax.parameters + 1)], sourceResource)
    if not createdElement then return false end

    local elementReference = createdElements[createdElement]
    local elementTemplate = imports.__getUITemplate(elementType, elementReference.sourceResource)
    if not elementTemplate then return false end

    elementReference.gui = cloneUIOutline(elementType)
    elementReference.gui.selection = false
    for i, j in imports.ipairs(availableElements[elementType].syntax.parameters) do
        if (j.name == "width") or (j.name == "height") then
            elementReference.gui[j.name] = imports.math.max(0, imports.math.max(availableElements[elementType].minimumSize, parameters[i]))
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
--[[ Functions: Sets/Gets Checkbox's Selection ]]--
---------------------------------------------------

function setCheckboxSelection(...)

    local parameters = {...}
    if not imports.areUIParametersValid(parameters, elementType, "setCheckboxSelection") then return false end
    local element = parameters[1]
    if not imports.isUIValid(element) then return false end

    local elementReference = createdElements[element]
    if (elementReference.gui.selection == parameters[2]) then return false end
    elementReference.gui.selection = parameters[2]
    imports.updateElement(element)
    imports.triggerEvent("onClientUISelectionAltered", element, elementReference.gui.selection)
    return true

end

function getCheckboxSelection(...)

    local parameters = {...}
    if not imports.areUIParametersValid(parameters, elementType, "getCheckboxSelection") then return false end
    local element = parameters[1]
    if not imports.isUIValid(element) then return false end

    local elementReference = createdElements[element]
    return elementReference.gui.selection

end


-----------------------------------------------------
--[[ Functions: Clears/Sets/Gets Checkbox's Text ]]--
-----------------------------------------------------

function clearCheckboxText(...)

    local parameters = {...}
    if not imports.areUIParametersValid(parameters, elementType, "clearCheckboxText") then return false end
    local element = parameters[1]
    if not imports.isUIValid(element) then return false end

    local elementReference = createdElements[element]
    if not elementReference.gui.text then return false end
    elementReference.gui.text = nil
    imports.updateElement(element)
    imports.triggerEvent("onClientUIAltered", element)
    return true

end

function setCheckboxText(...)

    local parameters = {...}
    if not imports.areUIParametersValid(parameters, elementType, "setCheckboxText") then return false end
    local element = parameters[1]
    if not imports.isUIValid(element) then return false end

    local elementReference = createdElements[element]
    if (elementReference.gui.text == parameters[2]) then return false end
    elementReference.gui.text = parameters[2]
    imports.updateElement(element)
    imports.triggerEvent("onClientUIAltered", element)
    return true

end

function getCheckboxText(...)

    local parameters = {...}
    if not imports.areUIParametersValid(parameters, elementType, "getCheckboxText") then return false end
    local element = parameters[1]
    if not imports.isUIValid(element) then return false end

    local elementReference = createdElements[element]
    if not elementReference.gui.text then return false end
    return elementReference.gui.text

end


-----------------------------------------------------------
--[[ Functions: Clears/Sets/Gets Checkbox's Text Color ]]--
-----------------------------------------------------------

function clearCheckboxTextColor(...)

    local parameters = {...}
    if not imports.areUIParametersValid(parameters, elementType, "clearCheckboxTextColor") then return false end
    local element = parameters[1]
    if not imports.isUIValid(element) then return false end

    local elementReference = createdElements[element]
    if not elementReference.gui.fontColor then return false end
    elementReference.gui.fontColor = nil
    imports.reloadElement(element)
    imports.triggerEvent("onClientUIAltered", element)
    return true

end

function setCheckboxTextColor(...)

    local parameters = {...}
    if not imports.areUIParametersValid(parameters, elementType, "setCheckboxTextColor") then return false end
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
    local checkboxTextColor = getCheckboxTextColor(element)
    if not checkboxTextColor or ((checkboxTextColor[1] == parameters[2][1]) and (checkboxTextColor[2] == parameters[2][2]) and (checkboxTextColor[3] == parameters[2][3]) and (checkboxTextColor[4] == parameters[2][4])) then return false end
    elementReference.gui.fontColor = {parameters[2][1], parameters[2][2], parameters[2][3], parameters[2][4]}
    imports.reloadElement(element)
    imports.triggerEvent("onClientUIAltered", element)
    return true

end

function getCheckboxTextColor(...)

    local parameters = {...}
    if not imports.areUIParametersValid(parameters, elementType, "getCheckboxTextColor") then return false end
    local element = parameters[1]
    if not imports.isUIValid(element) then return false end

    local elementReference = createdElements[element]
    local elementTemplate = imports.__getUITemplate(elementType, elementReference.sourceResource)
    return elementReference.gui.fontColor or elementTemplate.fontColor

end