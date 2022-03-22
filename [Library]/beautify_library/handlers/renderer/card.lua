----------------------------------------------------------------
--[[ Resource: Beautify Library
     Script: handlers: renderer: card.lua
     Server: -
     Author: vStudio
     Developer: -
     DOC: 01/02/2021
     Desc: Card's Renderer ]]--
----------------------------------------------------------------


-----------------
--[[ Imports ]]--
-----------------

local imports = {
    tocolor = tocolor,
    isElement = isElement,
    __getUITemplate = __getUITemplate,
    manageElementForceRender = manageElementForceRender,
    renderElementChildren = renderElementChildren,
    destroyElement = destroyElement,
    unpackColor = unpackColor,
    getInterpolationProgress = getInterpolationProgress,
    interpolateBetween = interpolateBetween,
    dxCreateRenderTarget = dxCreateRenderTarget,
    dxSetRenderTarget = dxSetRenderTarget,
    dxSetBlendMode = dxSetBlendMode,
    dxCreateTexture = dxCreateTexture,
    dxDrawImage = dxDrawImage,
    dxDrawRectangle = dxDrawRectangle,
    dxGetTexturePixels = dxGetTexturePixels
}


-------------------
--[[ Variables ]]--
-------------------

local elementType = "beautify_card"


--------------------------------
--[[ Function: Renders Card ]]--
--------------------------------

function renderCard(element, isActiveMode, isFetchingInput, mouseReference)

    local elementReference = createdElements[element]
    if not isFetchingInput then
        local isElementToBeRendered, isElementToBeForceRendered = true, false
        local isElementInterpolationToBeRefreshed = CLIENT_MTA_RESTORED
        local isElementToBeReloaded = (not CLIENT_MTA_MINIMIZED) and (elementReference.gui["__UI_CACHE__"].reloadElement or (CLIENT_RESOURCE_TEMPLATE_RELOAD[(elementReference.sourceResource)] and CLIENT_RESOURCE_TEMPLATE_RELOAD[(elementReference.sourceResource)][elementType]))
        local isElementToBeUpdated = isElementToBeReloaded or elementReference.gui["__UI_CACHE__"].updateElement or CLIENT_MTA_RESTORED
        local elementTemplate = imports.__getUITemplate(elementType, elementReference.sourceResource)

        if not isElementToBeRendered then return false end
        if (isActiveMode or isElementToBeReloaded) and isElementToBeUpdated then
            if not elementReference.gui["__UI_CACHE__"]["Card"] then
                elementReference.gui["__UI_CACHE__"]["Card"] = {
                    offsets = {},
                    view = {
                        offsets = {}
                    }
                }
            end
            local card_borderSize = availableElements[elementType].minimumSize*0.5
            elementReference.gui["__UI_CACHE__"]["Card"].offsets.startX = elementReference.gui.x
            elementReference.gui["__UI_CACHE__"]["Card"].offsets.startY = elementReference.gui.y
            elementReference.gui["__UI_CACHE__"]["Card"].offsets.width = elementReference.gui.width
            elementReference.gui["__UI_CACHE__"]["Card"].offsets.height = elementReference.gui.height
            elementReference.gui["__UI_CACHE__"]["Card"].view.offsets.startX = elementReference.gui["__UI_CACHE__"]["Card"].offsets.startX + elementReference.gui.viewSection.startX
            elementReference.gui["__UI_CACHE__"]["Card"].view.offsets.startY = elementReference.gui["__UI_CACHE__"]["Card"].offsets.startY + elementReference.gui.viewSection.startY
            elementReference.gui["__UI_CACHE__"]["Card"].view.offsets.width = elementReference.gui.viewSection.width
            elementReference.gui["__UI_CACHE__"]["Card"].view.offsets.height = elementReference.gui.viewSection.height
            if not elementReference.gui["__UI_CACHE__"]["Card"].renderTexture then
                if not elementReference.gui["__UI_CACHE__"]["Card"].renderTarget then
                    elementReference.gui["__UI_CACHE__"]["Card"].renderTarget = imports.dxCreateRenderTarget(elementReference.gui.width, elementReference.gui.height, true)
                end
                imports.dxSetRenderTarget(elementReference.gui["__UI_CACHE__"]["Card"].renderTarget, true)
                imports.dxSetBlendMode("modulate_add")
                imports.dxDrawImage(0, 0, card_borderSize, card_borderSize, createdAssets["images"]["curved_square/regular/top_left.rw"], 0, 0, 0, -1, false)
                imports.dxDrawImage(elementReference.gui.width - card_borderSize, 0, card_borderSize, card_borderSize, createdAssets["images"]["curved_square/regular/top_right.rw"], 0, 0, 0, -1, false)
                imports.dxDrawImage(0, elementReference.gui.height - card_borderSize, card_borderSize, card_borderSize, createdAssets["images"]["curved_square/regular/bottom_left.rw"], 0, 0, 0, -1, false)
                imports.dxDrawImage(elementReference.gui.width - card_borderSize, elementReference.gui.height - card_borderSize, card_borderSize, card_borderSize, createdAssets["images"]["curved_square/regular/bottom_right.rw"], 0, 0, 0, -1, false)
                if elementReference.gui.width > availableElements[elementType].minimumSize then
                    imports.dxDrawRectangle(card_borderSize, 0, elementReference.gui.width - availableElements[elementType].minimumSize, card_borderSize, -1, false)
                    imports.dxDrawRectangle(card_borderSize, elementReference.gui.height - card_borderSize, elementReference.gui.width - availableElements[elementType].minimumSize, card_borderSize, -1, false)
                end
                if elementReference.gui.height > availableElements[elementType].minimumSize then
                    imports.dxDrawRectangle(0, card_borderSize, card_borderSize, elementReference.gui.height - availableElements[elementType].minimumSize, -1, false)
                    imports.dxDrawRectangle(elementReference.gui.width - card_borderSize, card_borderSize, card_borderSize, elementReference.gui.height - availableElements[elementType].minimumSize, -1, false)
                end
                if (elementReference.gui.width > availableElements[elementType].minimumSize) and (elementReference.gui.height > availableElements[elementType].minimumSize) then
                    imports.dxDrawRectangle(card_borderSize, card_borderSize, elementReference.gui.width - availableElements[elementType].minimumSize, elementReference.gui.height - availableElements[elementType].minimumSize, -1, false)
                end
                imports.dxSetRenderTarget()
                local renderPixels = imports.dxGetTexturePixels(elementReference.gui["__UI_CACHE__"]["Card"].renderTarget)
                if renderPixels then
                    elementReference.gui["__UI_CACHE__"]["Card"].renderTexture = imports.dxCreateTexture(renderPixels, "argb", false, "clamp")
                    imports.destroyElement(elementReference.gui["__UI_CACHE__"]["Card"].renderTarget)
                    elementReference.gui["__UI_CACHE__"]["Card"].renderTarget = nil
                end
            end
            if isElementToBeReloaded then
                elementReference.gui["__UI_CACHE__"]["Card"].color = imports.tocolor(imports.unpackColor(elementTemplate.color))
            end
            if not CLIENT_MTA_MINIMIZED then
                elementReference.gui["__UI_CACHE__"].reloadElement = nil
            end
            elementReference.gui["__UI_CACHE__"].updateElement = nil
        end

        if elementReference.gui["__UI_CACHE__"]["Card"].renderTexture then
            imports.dxDrawImage(elementReference.gui["__UI_CACHE__"]["Card"].offsets.startX, elementReference.gui["__UI_CACHE__"]["Card"].offsets.startY, elementReference.gui["__UI_CACHE__"]["Card"].offsets.width, elementReference.gui["__UI_CACHE__"]["Card"].offsets.height, elementReference.gui["__UI_CACHE__"]["Card"].renderTexture, 0, 0, 0, elementReference.gui["__UI_CACHE__"]["Card"].color, elementReference.gui.postGUI)
        end
        if elementReference.gui.renderTarget and imports.isElement(elementReference.gui.renderTarget) then
            if isActiveMode then
                imports.manageElementForceRender(element, isElementToBeForceRendered)
                imports.renderElementChildren(element, isActiveMode)
                imports.dxSetRenderTarget()
            end
            imports.dxDrawImage(elementReference.gui["__UI_CACHE__"]["Card"].view.offsets.startX, elementReference.gui["__UI_CACHE__"]["Card"].view.offsets.startY, elementReference.gui["__UI_CACHE__"]["Card"].view.offsets.width, elementReference.gui["__UI_CACHE__"]["Card"].view.offsets.height, elementReference.gui.renderTarget, 0, 0, 0, -1, elementReference.gui.postGUI)
        end
    else
        imports.renderElementChildren(element, isActiveMode, true, mouseReference)
    end
    return true

end