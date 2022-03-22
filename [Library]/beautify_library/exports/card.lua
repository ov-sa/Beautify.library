----------------------------------------------------------------
--[[ Resource: Beautify Library
     Script: exports: card.lua
     Server: -
     Author: vStudio
     Developer: -
     DOC: 01/02/2021
     Desc: Card's Exports ]]--
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

local elementType = "beautify_card"


--------------------------------
--[[ Function: Creates Card ]]--
--------------------------------

function createCard(...)

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
            elementReference.gui[j.name] = imports.math.max(0, imports.math.max(availableElements[elementType].minimumSize, parameters[i]) + (availableElements[elementType].viewSection.padding*2))
        else
            elementReference.gui[j.name] = parameters[i]
        end
    end
    elementReference.gui.postGUI = (parameters[(#availableElements[elementType].syntax.parameters + 2)] and true) or false
    elementReference.gui.viewSection = {
        startX = availableElements[elementType].viewSection.padding,
        startY = availableElements[elementType].viewSection.padding,
        width = elementReference.gui.width - (availableElements[elementType].viewSection.padding*2),
        height = elementReference.gui.height - (availableElements[elementType].viewSection.padding*2)
    }
    if (elementReference.gui.viewSection.width > imports.math.max(0, availableElements[elementType].minimumSize*0.5)) and (elementReference.gui.viewSection.height > imports.math.max(0, availableElements[elementType].minimumSize*0.5)) then
        elementReference.gui.renderTarget = imports.dxCreateRenderTarget(elementReference.gui.viewSection.width, elementReference.gui.viewSection.height, true)
    end
    elementReference.isValid = true
    imports.reloadElement(createdElement)
    return createdElement

end