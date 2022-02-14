----------------------------------------------------------------
--[[ Resource: Beautify Library
     Script: exports: deckpane.lua
     Server: -
     Author: OvileAmriam
     Developer: -
     DOC: 01/02/2021 (OvileAmriam)
     Desc: Deck Pane's Exports ]]--
----------------------------------------------------------------


-----------------
--[[ Imports ]]--
-----------------

local imports = {
    ipairs = ipairs,
    addEventHandler = addEventHandler,
    cloneUIOutline = cloneUIOutline,
    areUIParametersValid = areUIParametersValid,
    dxCreateRenderTarget = dxCreateRenderTarget,
    math = math
}

imports.addEventHandler("onClientResourceStart", resource, function()
    imports.__getUITemplate = __getUITemplate
    imports.createUIElement = createUIElement
    imports.reloadElement = reloadElement
end)


-------------------
--[[ Variables ]]--
-------------------

local elementType = "beautify_deckpane"


-------------------------------------
--[[ Function: Creates Deck Pane ]]--
-------------------------------------

function createDeckpane(...)

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
    elementReference.gui.viewSection = {
        startX = 0,
        startY = 0,
        width = elementReference.gui.width,
        height = elementReference.gui.height
    }
    if (elementReference.gui.viewSection.width > 0) and (elementReference.gui.viewSection.height > 0) then
        elementReference.gui.renderTarget = imports.dxCreateRenderTarget(elementReference.gui.viewSection.width, elementReference.gui.viewSection.height, true)
    end
    elementReference.isValid = true
    imports.reloadElement(createdElement)
    return createdElement

end