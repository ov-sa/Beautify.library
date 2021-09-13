----------------------------------------------------------------
--[[ Resource: Beautify Library
     Script: exports: slider.lua
     Server: -
     Author: OvileAmriam
     Developer: -
     DOC: 01/02/2021 (OvileAmriam)
     Desc: Slider's Exports ]]--
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
    math = {
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

local elementType = "beautify_slider"


----------------------------------
--[[ Function: Creates Slider ]]--
----------------------------------

function createSlider(...)

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
            elementReference.gui[j.name] = imports.math.max(0, imports.math.max(availableElements[elementType].minimumSize, parameters[i]))
        elseif j.name == "type" then
            elementReference.gui[j.name] = (availableElements[elementType].validTypes[(parameters[i])] and parameters[i]) or "horizontal"
        else
            elementReference.gui[j.name] = parameters[i]
        end
    end
    elementReference.gui.postGUI = (parameters[(#availableElements[elementType].syntax.parameters + 2)] and true) or false
    elementReference.isValid = true
    imports.reloadElement(createdElement)
    return createdElement

end


-----------------------------------------------
--[[ Functions: Sets/Gets Slider's Percent ]]--
-----------------------------------------------

function setSliderPercent(...)

    local parameters = {...}
    if not imports.areUIParametersValid(parameters, elementType, "setSliderPercent") then return false end
    local element = parameters[1]
    if not imports.isUIValid(element) then return false end

    local elementReference = createdElements[element]
    if elementReference.gui.type == "horizontal" then
        if (elementReference.gui.slideBar_Horizontal.finalPercent == parameters[2]) then return false end
        elementReference.gui.slideBar_Horizontal.finalPercent = parameters[2]
        return true
    elseif elementReference.gui.type == "vertical" then
        if (elementReference.gui.slideBar_Vertical.finalPercent == parameters[2]) then return false end
        elementReference.gui.slideBar_Vertical.finalPercent = parameters[2]
        return true
    end
    if (elementReference.gui.text == parameters[2]) then return false end
    imports.updateElement(element)
    elementReference.gui.text = parameters[2]
    return false

end

function getSliderPercent(...)

    local parameters = {...}
    if not imports.areUIParametersValid(parameters, elementType, "getSliderPercent") then return false end
    local element = parameters[1]
    if not imports.isUIValid(element) then return false end

    local elementReference = createdElements[element]
    if elementReference.gui.type == "horizontal" then
        return elementReference.gui.slideBar_Horizontal.finalPercent
    elseif elementReference.gui.type == "vertical" then
        return elementReference.gui.slideBar_Vertical.finalPercent
    end
    return false

end


---------------------------------------------------
--[[ Functions: Clears/Sets/Gets Slider's Text ]]--
---------------------------------------------------

function clearSliderText(...)

    local parameters = {...}
    if not imports.areUIParametersValid(parameters, elementType, "clearSliderText") then return false end
    local element = parameters[1]
    if not imports.isUIValid(element) then return false end

    local elementReference = createdElements[element]
    if not elementReference.gui.text then return false end
    elementReference.gui.text = nil
    imports.updateElement(element)
    imports.triggerEvent("onClientUIAltered", element)
    return true

end

function setSliderText(...)

    local parameters = {...}
    if not imports.areUIParametersValid(parameters, elementType, "setSliderText") then return false end
    local element = parameters[1]
    if not imports.isUIValid(element) then return false end

    local elementReference = createdElements[element]
    if (elementReference.gui.text == parameters[2]) then return false end
    elementReference.gui.text = parameters[2]
    imports.updateElement(element)
    imports.triggerEvent("onClientUIAltered", element)
    return true

end

function getSliderText(...)

    local parameters = {...}
    if not imports.areUIParametersValid(parameters, elementType, "getSliderText") then return false end
    local element = parameters[1]
    if not imports.isUIValid(element) then return false end

    local elementReference = createdElements[element]
    if not elementReference.gui.text then return false end
    return elementReference.gui.text

end


---------------------------------------------------------
--[[ Functions: Clears/Sets/Gets Slider's Text Color ]]--
---------------------------------------------------------

function clearSliderTextColor(...)

    local parameters = {...}
    if not imports.areUIParametersValid(parameters, elementType, "clearSliderTextColor") then return false end
    local element = parameters[1]
    if not imports.isUIValid(element) then return false end

    local elementReference = createdElements[element]
    if not elementReference.gui.fontColor then return false end
    elementReference.gui.fontColor = nil
    imports.reloadElement(element)
    imports.triggerEvent("onClientUIAltered", element)
    return true

end

function setSliderTextColor(...)

    local parameters = {...}
    if not imports.areUIParametersValid(parameters, elementType, "setSliderTextColor") then return false end
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
    local sliderTextColor = getSliderTextColor(element)
    if not sliderTextColor or ((sliderTextColor[1] == parameters[2][1]) and (sliderTextColor[2] == parameters[2][2]) and (sliderTextColor[3] == parameters[2][3]) and (sliderTextColor[4] == parameters[2][4])) then return false end
    elementReference.gui.fontColor = {parameters[2][1], parameters[2][2], parameters[2][3], parameters[2][4]}
    imports.reloadElement(element)
    imports.triggerEvent("onClientUIAltered", element)
    return true

end

function getSliderTextColor(...)

    local parameters = {...}
    if not imports.areUIParametersValid(parameters, elementType, "getSliderTextColor") then return false end
    local element = parameters[1]
    if not imports.isUIValid(element) then return false end

    local elementReference = createdElements[element]
    local elementTemplate = imports.__getUITemplate(elementType, elementReference.sourceResource)
    return elementReference.gui.fontColor or elementTemplate.fontColor

end
