----------------------------------------------------------------
--[[ Resource: Beautify Library
     Script: exports: slider.lua
     Server: -
     Author: OvileAmriam
     Developer: -
     DOC: 01/02/2021 (OvileAmriam)
     Desc: Slider's Exports ]]--
----------------------------------------------------------------


-------------------
--[[ Variables ]]--
-------------------

local elementType = "beautify_slider"


----------------------------------
--[[ Function: Creates Slider ]]--
----------------------------------

function createSlider(...)

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
            local minRequirementIndex = "minimum"..j.name:sub(1,1):upper()..j.name:sub(2)
            if availableElements[elementType][minRequirementIndex] then
                elementReference.gui[j.name] = math.max(availableElements[elementType][minRequirementIndex], parameters[i])
            else
                elementReference.gui[j.name] = parameters[i]
            end
            elementReference.gui[j.name] = math.max(0, math.max(availableElements[elementType].minimumSize, elementReference.gui[j.name]))
        elseif j.name == "type" then
            elementReference.gui[j.name] = (availableElements[elementType].validTypes[(parameters[i])] and parameters[i]) or "horizontal"
        else
            elementReference.gui[j.name] = parameters[i]
        end
    end
    elementReference.gui.postGUI = (parameters[(#availableElements[elementType].syntax.parameters + 2)] and true) or false
    elementReference.isValid = true
    return createdElement

end


---------------------------------------------------
--[[ Functions: Clears/Sets/Gets Slider's Text ]]--
---------------------------------------------------

function clearSliderText(...)

    local parameters = {...}
    if not areUIParametersValid(parameters, elementType, "clearSliderText") then return false end
    local element = parameters[1]
    if not isUIValid(element) then return false end

    local elementReference = createdElements[element]
    if not elementReference.gui.text then return false end
    elementReference.gui.text = nil
    return true

end

function setSliderText(...)

    local parameters = {...}
    if not areUIParametersValid(parameters, elementType, "setSliderText") then return false end
    local element = parameters[1]
    if not isUIValid(element) then return false end

    local elementReference = createdElements[element]
    if (elementReference.gui.text == parameters[2]) then return false end
    elementReference.gui.text = parameters[2]
    return true

end

function getSliderText(...)

    local parameters = {...}
    if not areUIParametersValid(parameters, elementType, "getSliderText") then return false end
    local element = parameters[1]
    if not isUIValid(element) then return false end

    local elementReference = createdElements[element]
    if not elementReference.gui.text then return false end
    return elementReference.gui.text

end