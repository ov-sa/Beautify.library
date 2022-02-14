----------------------------------------------------------------
--[[ Resource: Beautify Library
     Script: exports: label.lua
     Server: -
     Author: OvileAmriam
     Developer: -
     DOC: 01/02/2021 (OvileAmriam)
     Desc: Label's Exports ]]--
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

local elementType = "beautify_label"


---------------------------------
--[[ Function: Creates Label ]]--
---------------------------------

function createLabel(...)

    local parameters = {...}
    if not imports.areUIParametersValid(parameters, elementType) then return false end
    local createdElement = imports.createUIElement(elementType, parameters[(#availableElements[elementType].syntax.parameters + 1)], sourceResource)
    if not createdElement then return false end

    local elementReference = createdElements[createdElement]
    local elementTemplate = imports.__getUITemplate(elementType, elementReference.sourceResource)
    if not elementTemplate then return false end

    elementReference.gui = imports.cloneUIOutline(elementType)
    for i, j in imports.ipairs(availableElements[elementType].syntax.parameters) do
        if (j.name == "width") or (j.name == "height") then
            elementReference.gui[j.name] = imports.math.max(0, parameters[i])
        else
            elementReference.gui[j.name] = parameters[i]
        end
    end
    elementReference.gui.postGUI = (parameters[(#availableElements[elementType].syntax.parameters + 2)] and true) or false
    elementReference.gui.alignment = {
        horizontal = "left",
        vertical = "center"
    }
    elementReference.isValid = true
    imports.reloadElement(createdElement)
    return createdElement

end


-------------------------------------------
--[[ Functions: Sets/Gets Label's Text ]]--
-------------------------------------------

function setLabelText(...)

    local parameters = {...}
    if not imports.areUIParametersValid(parameters, elementType, "setLabelText") then return false end
    local element = parameters[1]
    if not imports.isUIValid(element) then return false end

    local elementReference = createdElements[element]
    if (elementReference.gui.text == parameters[2]) then return false end
    elementReference.gui.text = parameters[2]
    imports.updateElement(element)
    imports.triggerEvent("onClientUIAltered", element)
    return true

end

function getLabelText(...)

    local parameters = {...}
    if not imports.areUIParametersValid(parameters, elementType, "getLabelText") then return false end
    local element = parameters[1]
    if not imports.isUIValid(element) then return false end

    local elementReference = createdElements[element]
    return elementReference.gui.text

end


---------------------------------------------------
--[[ Functions: Clears/Sets/Gets Label's Color ]]--
---------------------------------------------------

function clearLabelColor(...)

    local parameters = {...}
    if not imports.areUIParametersValid(parameters, elementType, "clearLabelColor") then return false end
    local element = parameters[1]
    if not imports.isUIValid(element) then return false end

    local elementReference = createdElements[element]
    if not elementReference.gui.fontColor then return false end
    elementReference.gui.fontColor = nil
    imports.reloadElement(element)
    imports.triggerEvent("onClientUIAltered", element)
    return true

end

function setLabelColor(...)

    local parameters = {...}
    if not imports.areUIParametersValid(parameters, elementType, "setLabelColor") then return false end
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
    local labelColor = getLabelColor(element)
    if not labelColor or ((labelColor[1] == parameters[2][1]) and (labelColor[2] == parameters[2][2]) and (labelColor[3] == parameters[2][3]) and (labelColor[4] == parameters[2][4])) then return false end
    elementReference.gui.fontColor = {parameters[2][1], parameters[2][2], parameters[2][3], parameters[2][4]}
    imports.reloadElement(element)
    imports.triggerEvent("onClientUIAltered", element)
    return true

end

function getLabelColor(...)

    local parameters = {...}
    if not imports.areUIParametersValid(parameters, elementType, "getLabelColor") then return false end
    local element = parameters[1]
    if not imports.isUIValid(element) then return false end

    local elementReference = createdElements[element]
    local elementTemplate = imports.__getUITemplate(elementType, elementReference.sourceResource)
    return elementReference.gui.fontColor or elementTemplate.fontColor

end


--------------------------------------------------------------------
--[[ Functions: Sets/Gets Label's Horizontal/Vertical Alignment ]]--
--------------------------------------------------------------------

function setLabelHorizontalAlignment(...)

    local parameters = {...}
    if not imports.areUIParametersValid(parameters, elementType, "setLabelHorizontalAlignment") then return false end
    local element = parameters[1]
    if not imports.isUIValid(element) then return false end

    local elementReference = createdElements[element]
    if not UI_VALID_ALIGNMENT.horizontal[(parameters[2])] or (elementReference.gui.alignment.horizontal == parameters[2]) then return false end
    elementReference.gui.alignment.horizontal = parameters[2]
    imports.updateElement(element)
    imports.triggerEvent("onClientUIAltered", element)
    return true

end

function getLabelHorizontalAlignment(...)

    local parameters = {...}
    if not imports.areUIParametersValid(parameters, elementType, "getLabelHorizontalAlignment") then return false end
    local element = parameters[1]
    if not imports.isUIValid(element) then return false end

    local elementReference = createdElements[element]
    return elementReference.gui.alignment.horizontal

end

function setLabelVerticalAlignment(...)

    local parameters = {...}
    if not imports.areUIParametersValid(parameters, elementType, "setLabelVerticalAlignment") then return false end
    local element = parameters[1]
    if not imports.isUIValid(element) then return false end

    local elementReference = createdElements[element]
    if not UI_VALID_ALIGNMENT.vertical[(parameters[2])] or (elementReference.gui.alignment.vertical == parameters[2]) then return false end
    elementReference.gui.alignment.vertical = parameters[2]
    imports.updateElement(element)
    imports.triggerEvent("onClientUIAltered", element)
    return true

end

function getLabelVerticalAlignment(...)

    local parameters = {...}
    if not imports.areUIParametersValid(parameters, elementType, "getLabelVerticalAlignment") then return false end
    local element = parameters[1]
    if not imports.isUIValid(element) then return false end

    local elementReference = createdElements[element]
    return elementReference.gui.alignment.vertical

end