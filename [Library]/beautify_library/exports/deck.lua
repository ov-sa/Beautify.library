----------------------------------------------------------------
--[[ Resource: Beautify Library
     Script: exports: deck.lua
     Server: -
     Author: OvileAmriam
     Developer: -
     DOC: 01/02/2021 (OvileAmriam)
     Desc: Deck's Exports ]]--
----------------------------------------------------------------


-------------------
--[[ Variables ]]--
-------------------

local elementType = "beautify_deck"


--------------------------------
--[[ Function: Creates Deck ]]--
--------------------------------

function createDeck(...)

    local parameters = {...}
    if not areUIParametersValid(parameters, elementType) then return false end
    local createdElement = createUIElement(elementType, parameters[3], sourceResource)
    if not createdElement then return false end

    local elementReference = createdElements[createdElement]
    local elementTemplate = __getUITemplate(elementType, elementReference.sourceResource)
    if not elementTemplate then return false end

    elementReference.gui = cloneUIOutline(elementType)
    elementReference.gui.x, elementReference.gui.y = 0, 0
    elementReference.gui.width = math.max(0, createdElements[(parameters[3])].gui.width)
    elementReference.gui.maximized = false
    for i, j in ipairs(availableElements[elementType].syntax.parameters) do
        if j.name == "height" then
            elementReference.gui[j.name] = math.max(0, math.max(availableElements[elementType].titleBar.height, parameters[i]) + (availableElements[elementType].contentSection.padding*2)) + availableElements[elementType].titleBar.height
        else
            elementReference.gui[j.name] = parameters[i]
        end
    end
    elementReference.gui.postGUI = (parameters[(#availableElements[elementType].syntax.parameters + 1)] and true) or false
    elementReference.gui.contentSection = {
        startX = availableElements[elementType].contentSection.padding,
        startY = (availableElements[elementType].titleBar.height) + availableElements[elementType].contentSection.padding,
        width = elementReference.gui.width - (availableElements[elementType].contentSection.padding*2),
        height = elementReference.gui.height - (availableElements[elementType].titleBar.height) - (availableElements[elementType].contentSection.padding*2)
    }
    if (elementReference.gui.contentSection.width > 0) and (elementReference.gui.contentSection.height > math.max(0, availableElements[elementType].titleBar.height)) then
        elementReference.gui.renderTarget = dxCreateRenderTarget(elementReference.gui.contentSection.width, elementReference.gui.contentSection.height, true)
    end
    elementReference.isValid = true
    return createdElement

end


-----------------------------------------------------
--[[ Functions: Sets/Gets Deck's Maximized State ]]--
-----------------------------------------------------

function setDeckMaximized(...)

    local parameters = {...}
    if not areUIParametersValid(parameters, elementType, "setDeckMaximized") then return false end
    local element = parameters[1]
    if not isUIValid(element) then return false end

    local elementReference = createdElements[element]
    if (elementReference.gui.maximized == parameters[2]) then return false end
    elementReference.gui.maximized = parameters[2]
    triggerEvent("onClientUIMaximizationAltered", element, elementReference.gui.maximized)
    return true

end

function isDeckMaximized(...)

    local parameters = {...}
    if not areUIParametersValid(parameters, elementType, "isDeckMaximized") then return false end
    local element = parameters[1]
    if not isUIValid(element) then return false end

    local elementReference = createdElements[element]
    return elementReference.gui.maximized

end
