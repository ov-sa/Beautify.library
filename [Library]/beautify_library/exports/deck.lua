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
    local createdElement = createUIElement(elementType, parameters[5], sourceResource)
    if not createdElement then return false end

    local elementReference = createdElements[createdElement]
    local elementTemplate = __getUITemplate(elementType, elementReference.sourceResource)
    if not elementTemplate then return false end

    elementReference.gui = cloneUIOutline(elementType)
    elementReference.gui.width = math.max(0, createdElements[(parameters[5])].gui.width)
    for i, j in ipairs(availableElements[elementType].syntax.parameters) do
        if j.name == "height" then
            elementReference.gui[j.name] = math.max(0, math.max(availableElements[elementType].minimumSize, parameters[i]) + (availableElements[elementType].contentSection.padding*2)) + (availableElements[elementType].minimumSize*0.5)
        else
            elementReference.gui[j.name] = parameters[i]
        end
    end
    elementReference.gui.postGUI = (parameters[(#availableElements[elementType].syntax.parameters + 1)] and true) or false
    elementReference.gui.contentSection = {
        startX = availableElements[elementType].contentSection.padding,
        startY = (availableElements[elementType].minimumSize*0.5) + availableElements[elementType].contentSection.padding,
        width = elementReference.gui.width - (availableElements[elementType].contentSection.padding*2),
        height = elementReference.gui.height - (availableElements[elementType].minimumSize*0.5) - (availableElements[elementType].contentSection.padding*2)
    }
    if (elementReference.gui.contentSection.width > 0) and (elementReference.gui.contentSection.height > math.max(0, availableElements[elementType].minimumSize*0.5)) then
        elementReference.gui.renderTarget = dxCreateRenderTarget(elementReference.gui.contentSection.width, elementReference.gui.contentSection.height, true)
    end
    elementReference.isValid = true
    return createdElement

end