----------------------------------------------------------------
--[[ Resource: Beautify Library
     Script: exports: deck.lua
     Server: -
     Author: OvileAmriam
     Developer: -
     DOC: 01/02/2021 (OvileAmriam)
     Desc: Deck's Exports ]]--
----------------------------------------------------------------


-----------------
--[[ Imports ]]--
-----------------

local imports = {
    ipairs = ipairs,
    addEventHandler = addEventHandler,
    triggerEvent = triggerEvent,
    isUIValid = isUIValid,
    cloneUIOutline = cloneUIOutline,
    areUIParametersValid = areUIParametersValid,
    dxCreateRenderTarget = dxCreateRenderTarget,
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

local elementType = "beautify_deck"


--------------------------------
--[[ Function: Creates Deck ]]--
--------------------------------

function createDeck(...)

    local parameters = {...}
    if not imports.areUIParametersValid(parameters, elementType) then return false end
    local createdElement = imports.createUIElement(elementType, parameters[3], sourceResource)
    if not createdElement then return false end

    local elementReference = createdElements[createdElement]
    local elementTemplate = imports.__getUITemplate(elementType, elementReference.sourceResource)
    if not elementTemplate then return false end

    elementReference.gui = imports.cloneUIOutline(elementType)
    elementReference.gui.x, elementReference.gui.y = 0, 0
    elementReference.gui.width = imports.math.max(0, createdElements[(parameters[3])].gui.width)
    elementReference.gui.maximized = false
    for i, j in imports.ipairs(availableElements[elementType].syntax.parameters) do
        if j.name == "height" then
            elementReference.gui[j.name] = imports.math.max(0, imports.math.max(availableElements[elementType].titleBar.height, parameters[i]) + (availableElements[elementType].viewSection.padding*2)) + availableElements[elementType].titleBar.height
        else
            elementReference.gui[j.name] = parameters[i]
        end
    end
    elementReference.gui.postGUI = (parameters[(#availableElements[elementType].syntax.parameters + 1)] and true) or false
    elementReference.gui.viewSection = {
        startX = availableElements[elementType].viewSection.padding,
        startY = (availableElements[elementType].titleBar.height) + availableElements[elementType].viewSection.padding,
        width = elementReference.gui.width - (availableElements[elementType].viewSection.padding*2),
        height = elementReference.gui.height - (availableElements[elementType].titleBar.height) - (availableElements[elementType].viewSection.padding*2)
    }
    if (elementReference.gui.viewSection.width > 0) and (elementReference.gui.viewSection.height > imports.math.max(0, availableElements[elementType].titleBar.height)) then
        elementReference.gui.renderTarget = imports.dxCreateRenderTarget(elementReference.gui.viewSection.width, elementReference.gui.viewSection.height, true)
    end
    elementReference.isValid = true
    imports.reloadElement(createdElement)
    return createdElement

end


-----------------------------------------------------
--[[ Functions: Sets/Gets Deck's Maximized State ]]--
-----------------------------------------------------

function setDeckMaximized(...)

    local parameters = {...}
    if not imports.areUIParametersValid(parameters, elementType, "setDeckMaximized") then return false end
    local element = parameters[1]
    if not imports.isUIValid(element) then return false end

    local elementReference = createdElements[element]
    if (elementReference.gui.maximized == parameters[2]) then return false end
    elementReference.gui.maximized = parameters[2]
    imports.updateElement(createdElement)
    imports.triggerEvent("onClientUIMaximizationAltered", element, elementReference.gui.maximized)
    return true

end

function isDeckMaximized(...)

    local parameters = {...}
    if not imports.areUIParametersValid(parameters, elementType, "isDeckMaximized") then return false end
    local element = parameters[1]
    if not imports.isUIValid(element) then return false end

    local elementReference = createdElements[element]
    return elementReference.gui.maximized

end
