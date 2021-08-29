----------------------------------------------------------------
--[[ Resource: Beautify Library
     Script: handlers: renderer: deck.lua
     Server: -
     Author: OvileAmriam
     Developer: -
     DOC: 01/02/2021 (OvileAmriam)
     Desc: Deck's Renderer ]]--
----------------------------------------------------------------


-----------------
--[[ Imports ]]--
-----------------

local imports = {
    tocolor = tocolor,
    isElement = isElement,
    isKeyClicked = isKeyClicked,
    getUIParent = getUIParent,
    __getUITemplate = __getUITemplate,
    renderElementChildren = renderElementChildren,
    attachUIElement = attachUIElement,
    destroyElement = destroyElement,
    setUIVisible = setUIVisible,
    unpackColor = unpackColor,
    isMouseOnPosition = isMouseOnPosition,
    getInterpolationProgress = getInterpolationProgress,
    interpolateBetween = interpolateBetween,
    dxCreateRenderTarget = dxCreateRenderTarget,
    dxSetRenderTarget = dxSetRenderTarget,
    dxSetBlendMode = dxSetBlendMode,
    dxCreateTexture = dxCreateTexture,
    dxDrawImage = dxDrawImage,
    dxDrawRectangle = dxDrawRectangle,
    dxDrawText = dxDrawText,
    dxGetTexturePixels = dxGetTexturePixels,
    dxGetTextWidth = dxGetTextWidth
}


-------------------
--[[ Variables ]]--
-------------------

local elementType = "beautify_deck"


--------------------------------
--[[ Function: Renders Deck ]]--
--------------------------------

function renderDeck(element, isFetchingInput, mouseReference)

    local elementReference = createdElements[element]
    if not isFetchingInput then
        local elementParent = imports.getUIParent(element)
        if not elementParent then imports.dxSetRenderTarget() end
        local isElementRootToBeForceRendered = false
        local isElementInterpolationToBeRefreshed = CLIENT_MTA_RESTORED
        local isElementToBeReloaded = (not CLIENT_MTA_MINIMIZED) and (elementReference.gui["__UI_CACHE__"].reloadElement or (CLIENT_RESOURCE_TEMPLATE_RELOAD[(elementReference.sourceResource)] and CLIENT_RESOURCE_TEMPLATE_RELOAD[(elementReference.sourceResource)][elementType]))
        local isElementToBeUpdated = isElementToBeReloaded or elementReference.gui["__UI_CACHE__"].updateElement or CLIENT_MTA_RESTORED
        local elementTemplate = imports.__getUITemplate(elementType, elementReference.sourceResource)
        local deck_postGUI = elementReference.gui.postGUI

        if isElementToBeUpdated then
            if not elementReference.gui["__UI_CACHE__"]["Deck"] then
                elementReference.gui["__UI_CACHE__"]["Deck"] = {
                    offsets = {},
                    divider = {},
                    view = {
                        offsets = {}
                    }
                }
                elementReference.gui["__UI_CACHE__"]["Title Bar"] = {
                    offsets = {},
                    text = {
                        offsets = {}
                    }
                }
                elementReference.gui["__UI_CACHE__"]["Close Button"] = {
                    offsets = {},
                    text = {
                        offsets = {}
                    }
                }
                elementReference.gui["__UI_INPUT_FETCH_CACHE__"]["Title Bar"] = {}
                elementReference.gui["__UI_INPUT_FETCH_CACHE__"]["Close Button"] = {}
            end
            local deck_startX, deck_startY = elementReference.gui.x, elementReference.gui.y
            local deck_width, deck_height = elementReference.gui.width, elementReference.gui.height
            local deck_view_width, deck_view_height = elementReference.gui.contentSection.width, elementReference.gui.contentSection.height
            local deck_borderSize = availableElements[elementType].minimumSize*0.5
            elementReference.gui["__UI_CACHE__"]["Deck"].offsets.startX = deck_startX
            elementReference.gui["__UI_CACHE__"]["Deck"].offsets.startY = deck_startY
            elementReference.gui["__UI_CACHE__"]["Deck"].offsets.width = deck_width
            elementReference.gui["__UI_CACHE__"]["Deck"].offsets.height = deck_height
            elementReference.gui["__UI_CACHE__"]["Deck"].view.offsets.startX = elementReference.gui["__UI_CACHE__"]["Deck"].offsets.startX + elementReference.gui.contentSection.startX
            elementReference.gui["__UI_CACHE__"]["Deck"].view.offsets.startY = elementReference.gui["__UI_CACHE__"]["Deck"].offsets.startY + elementReference.gui.contentSection.startY
            elementReference.gui["__UI_CACHE__"]["Deck"].view.offsets.width = deck_view_width
            elementReference.gui["__UI_CACHE__"]["Deck"].view.offsets.height = deck_view_height
            local deck_titleBar_paddingX = availableElements[elementType].titleBar.paddingX
            elementReference.gui["__UI_CACHE__"]["Title Bar"].offsets.startX = elementReference.gui["__UI_CACHE__"]["Deck"].offsets.startX
            elementReference.gui["__UI_CACHE__"]["Title Bar"].offsets.startY = elementReference.gui["__UI_CACHE__"]["Deck"].offsets.startY
            elementReference.gui["__UI_CACHE__"]["Title Bar"].offsets.width = elementReference.gui["__UI_CACHE__"]["Deck"].offsets.width
            elementReference.gui["__UI_CACHE__"]["Title Bar"].offsets.height = deck_borderSize
            elementReference.gui["__UI_CACHE__"]["Deck"].divider.size = elementTemplate.titleBar.divider.size
            if isElementToBeReloaded then
                elementReference.gui["__UI_CACHE__"]["Deck"].divider.color = imports.tocolor(imports.unpackColor(elementTemplate.titleBar.divider.color))
                elementReference.gui["__UI_CACHE__"]["Title Bar"].text.fontColor = imports.tocolor(imports.unpackColor(elementTemplate.titleBar.fontColor))
                elementReference.gui["__UI_CACHE__"]["Title Bar"].text.padding = ""
                while imports.dxGetTextWidth(elementReference.gui["__UI_CACHE__"]["Title Bar"].text.padding, 1, elementTemplate.titleBar.font) < deck_borderSize do
                    elementReference.gui["__UI_CACHE__"]["Title Bar"].text.padding = elementReference.gui["__UI_CACHE__"]["Title Bar"].text.padding.." "
                end
                elementReference.gui["__UI_CACHE__"]["Close Button"].text.fontColor = imports.tocolor(imports.unpackColor(elementTemplate.titleBar.closeButton.fontColor))
            end
            elementReference.gui["__UI_CACHE__"]["Title Bar"].text.text = elementReference.gui["__UI_CACHE__"]["Title Bar"].text.padding..elementReference.gui.title
            elementReference.gui["__UI_CACHE__"]["Title Bar"].text.offsets.startX = elementReference.gui["__UI_CACHE__"]["Title Bar"].offsets.startX + deck_titleBar_paddingX
            elementReference.gui["__UI_CACHE__"]["Title Bar"].text.offsets.startY = elementReference.gui["__UI_CACHE__"]["Title Bar"].offsets.startY + (elementTemplate.titleBar.fontPaddingY or 0)
            elementReference.gui["__UI_CACHE__"]["Title Bar"].text.offsets.endX = elementReference.gui["__UI_CACHE__"]["Title Bar"].offsets.startX + elementReference.gui["__UI_CACHE__"]["Title Bar"].offsets.width - elementReference.gui["__UI_CACHE__"]["Title Bar"].offsets.height - deck_titleBar_paddingX
            elementReference.gui["__UI_CACHE__"]["Title Bar"].text.offsets.endY = elementReference.gui["__UI_CACHE__"]["Title Bar"].offsets.startY + elementReference.gui["__UI_CACHE__"]["Title Bar"].offsets.height
            elementReference.gui["__UI_INPUT_FETCH_CACHE__"]["Title Bar"].startX = elementReference.gui["__UI_CACHE__"]["Title Bar"].offsets.startX
            elementReference.gui["__UI_INPUT_FETCH_CACHE__"]["Title Bar"].startY = elementReference.gui["__UI_CACHE__"]["Title Bar"].offsets.startY
            elementReference.gui["__UI_INPUT_FETCH_CACHE__"]["Title Bar"].width = elementReference.gui["__UI_CACHE__"]["Title Bar"].offsets.width - elementReference.gui["__UI_CACHE__"]["Title Bar"].offsets.height
            elementReference.gui["__UI_INPUT_FETCH_CACHE__"]["Title Bar"].height = elementReference.gui["__UI_CACHE__"]["Title Bar"].offsets.height
            elementReference.gui["__UI_CACHE__"]["Close Button"].offsets.startX = elementReference.gui["__UI_CACHE__"]["Title Bar"].offsets.startX + elementReference.gui["__UI_CACHE__"]["Title Bar"].offsets.width - elementReference.gui["__UI_CACHE__"]["Title Bar"].offsets.height
            elementReference.gui["__UI_CACHE__"]["Close Button"].offsets.startY = elementReference.gui["__UI_CACHE__"]["Title Bar"].offsets.startY
            elementReference.gui["__UI_CACHE__"]["Close Button"].offsets.width = elementReference.gui["__UI_CACHE__"]["Title Bar"].offsets.height
            elementReference.gui["__UI_CACHE__"]["Close Button"].offsets.height = elementReference.gui["__UI_CACHE__"]["Title Bar"].offsets.height
            elementReference.gui["__UI_CACHE__"]["Close Button"].text.text = "X"
            elementReference.gui["__UI_CACHE__"]["Close Button"].text.offsets.startX = elementReference.gui["__UI_CACHE__"]["Close Button"].offsets.startX
            elementReference.gui["__UI_CACHE__"]["Close Button"].text.offsets.startY = elementReference.gui["__UI_CACHE__"]["Close Button"].offsets.startY + (elementTemplate.titleBar.fontPaddingY or 0)
            elementReference.gui["__UI_CACHE__"]["Close Button"].text.offsets.endX = elementReference.gui["__UI_CACHE__"]["Close Button"].offsets.startX + elementReference.gui["__UI_CACHE__"]["Close Button"].offsets.width
            elementReference.gui["__UI_CACHE__"]["Close Button"].text.offsets.endY = elementReference.gui["__UI_CACHE__"]["Close Button"].offsets.startY + elementReference.gui["__UI_CACHE__"]["Close Button"].offsets.height
            elementReference.gui["__UI_INPUT_FETCH_CACHE__"]["Close Button"].startX = elementReference.gui["__UI_CACHE__"]["Close Button"].offsets.startX
            elementReference.gui["__UI_INPUT_FETCH_CACHE__"]["Close Button"].startY = elementReference.gui["__UI_CACHE__"]["Close Button"].offsets.startY
            elementReference.gui["__UI_INPUT_FETCH_CACHE__"]["Close Button"].width = elementReference.gui["__UI_CACHE__"]["Close Button"].offsets.width
            elementReference.gui["__UI_INPUT_FETCH_CACHE__"]["Close Button"].height = elementReference.gui["__UI_CACHE__"]["Close Button"].offsets.height
            if isElementToBeReloaded or not elementReference.gui["__UI_CACHE__"]["Deck"].renderTexture then
                if not elementReference.gui["__UI_CACHE__"]["Deck"].renderTarget then
                    elementReference.gui["__UI_CACHE__"]["Deck"].renderTarget = imports.dxCreateRenderTarget(deck_width, deck_height, true)
                end
                if elementReference.gui["__UI_CACHE__"]["Deck"].renderTexture and imports.isElement(elementReference.gui["__UI_CACHE__"]["Deck"].renderTexture) then
                    imports.destroyElement(elementReference.gui["__UI_CACHE__"]["Deck"].renderTexture)
                    elementReference.gui["__UI_CACHE__"]["Deck"].renderTexture = nil
                end
                imports.dxSetRenderTarget(elementReference.gui["__UI_CACHE__"]["Deck"].renderTarget, true)
                imports.dxSetBlendMode("modulate_add")
                local deck_color, deck_titleBar_color = imports.tocolor(imports.unpackColor(elementTemplate.color)), imports.tocolor(imports.unpackColor(elementTemplate.titleBar.color))
                imports.dxDrawImage(0, 0, deck_borderSize, deck_borderSize, createdAssets["images"]["curved_square/regular/top_left.png"], 0, 0, 0, deck_titleBar_color, false)
                imports.dxDrawImage(deck_width - deck_borderSize, 0, deck_borderSize, deck_borderSize, createdAssets["images"]["curved_square/regular/top_right.png"], 0, 0, 0, deck_titleBar_color, false)
                imports.dxDrawImage(0, deck_height - deck_borderSize, deck_borderSize, deck_borderSize, createdAssets["images"]["curved_square/regular/bottom_left.png"], 0, 0, 0, deck_color, false)
                imports.dxDrawImage(deck_width - deck_borderSize, deck_height - deck_borderSize, deck_borderSize, deck_borderSize, createdAssets["images"]["curved_square/regular/bottom_right.png"], 0, 0, 0, deck_color, false)
                if deck_width > availableElements[elementType].minimumSize then
                    imports.dxDrawRectangle(deck_borderSize, 0, deck_width - availableElements[elementType].minimumSize, deck_borderSize, deck_titleBar_color, false)
                    imports.dxDrawRectangle(deck_borderSize, deck_height - deck_borderSize, deck_width - availableElements[elementType].minimumSize, deck_borderSize, deck_color, false)
                end
                if deck_height > availableElements[elementType].minimumSize then
                    imports.dxDrawRectangle(0, deck_borderSize, deck_borderSize, deck_height - availableElements[elementType].minimumSize, deck_color, false)
                    imports.dxDrawRectangle(deck_width - deck_borderSize, deck_borderSize, deck_borderSize, deck_height - availableElements[elementType].minimumSize, deck_color, false)
                end
                if deck_width > availableElements[elementType].minimumSize and deck_height > availableElements[elementType].minimumSize then
                    imports.dxDrawRectangle(deck_borderSize, deck_borderSize, deck_width - availableElements[elementType].minimumSize, deck_height - availableElements[elementType].minimumSize, deck_color, false)
                end
                imports.dxDrawRectangle(0, deck_borderSize, deck_width, elementReference.gui["__UI_CACHE__"]["Deck"].divider.size, elementReference.gui["__UI_CACHE__"]["Deck"].divider.color, false)    
                imports.dxSetBlendMode("blend")
                imports.dxSetRenderTarget()
                local renderPixels = imports.dxGetTexturePixels(elementReference.gui["__UI_CACHE__"]["Deck"].renderTarget)
                if renderPixels then
                    elementReference.gui["__UI_CACHE__"]["Deck"].renderTexture = imports.dxCreateTexture(renderPixels, "argb", false, "clamp")
                    imports.destroyElement(elementReference.gui["__UI_CACHE__"]["Deck"].renderTarget)
                    elementReference.gui["__UI_CACHE__"]["Deck"].renderTarget = nil
                end
            end
            if not CLIENT_MTA_MINIMIZED then
                elementReference.gui["__UI_CACHE__"].reloadElement = nil
            end
            elementReference.gui["__UI_CACHE__"].updateElement = nil
        end

        if not elementReference.gui.titleBar.closeButton.animAlphaPercent then
            elementReference.gui.titleBar.closeButton.animAlphaPercent = 0
            elementReference.gui.titleBar.closeButton.hoverStatus = "backward"
            elementReference.gui.titleBar.closeButton.hoverAnimTickCounter = CLIENT_CURRENT_TICK
        end

        elementReference.gui.titleBar.closeButton.interpolationProgress = imports.getInterpolationProgress(elementReference.gui.titleBar.closeButton.hoverAnimTickCounter, availableElements[elementType].titleBar.closeButton.hoverAnimDuration)
        if isElementInterpolationToBeRefreshed or (elementReference.gui.titleBar.closeButton.interpolationProgress < 1) then
            isElementRootToBeForceRendered = not isElementInterpolationToBeRefreshed and true
            if elementReference.gui.titleBar.closeButton.hoverStatus == "forward" then
                elementReference.gui.titleBar.closeButton.animAlphaPercent = imports.interpolateBetween(elementReference.gui.titleBar.closeButton.animAlphaPercent, 0, 0, 1, 0, 0, elementReference.gui.titleBar.closeButton.interpolationProgress, "InQuad")
            else
                elementReference.gui.titleBar.closeButton.animAlphaPercent = imports.interpolateBetween(elementReference.gui.titleBar.closeButton.animAlphaPercent, 0, 0, 0, 0, 0, elementReference.gui.titleBar.closeButton.interpolationProgress, "InQuad")
            end
        end
        if elementReference.gui["__UI_CACHE__"]["Deck"].renderTexture then
            imports.dxDrawImage(elementReference.gui["__UI_CACHE__"]["Deck"].offsets.startX, elementReference.gui["__UI_CACHE__"]["Deck"].offsets.startY, elementReference.gui["__UI_CACHE__"]["Deck"].offsets.width, elementReference.gui["__UI_CACHE__"]["Deck"].offsets.height, elementReference.gui["__UI_CACHE__"]["Deck"].renderTexture, 0, 0, 0, -1, deck_postGUI)
        end
        local isRenderCloseButtonHover = elementReference.gui.titleBar.closeButton.animAlphaPercent > 0
        imports.dxDrawText(elementReference.gui["__UI_CACHE__"]["Title Bar"].text.text, elementReference.gui["__UI_CACHE__"]["Title Bar"].text.offsets.startX, elementReference.gui["__UI_CACHE__"]["Title Bar"].text.offsets.startY, elementReference.gui["__UI_CACHE__"]["Title Bar"].text.offsets.endX, elementReference.gui["__UI_CACHE__"]["Title Bar"].text.offsets.endY, elementReference.gui["__UI_CACHE__"]["Title Bar"].text.fontColor, elementTemplate.titleBar.fontScale or 1, elementTemplate.titleBar.font, "center", "center", true, false, deck_postGUI, false)
        if isRenderCloseButtonHover then    
            imports.dxDrawImage(elementReference.gui["__UI_CACHE__"]["Close Button"].offsets.startX, elementReference.gui["__UI_CACHE__"]["Close Button"].offsets.startY, elementReference.gui["__UI_CACHE__"]["Close Button"].offsets.width, elementReference.gui["__UI_CACHE__"]["Close Button"].offsets.height, createdAssets["images"]["curved_square/regular/top_right.png"], 0, 0, 0, imports.tocolor(elementTemplate.titleBar.closeButton.hoverColor[1], elementTemplate.titleBar.closeButton.hoverColor[2], elementTemplate.titleBar.closeButton.hoverColor[3], elementTemplate.titleBar.closeButton.hoverColor[4]*elementReference.gui.titleBar.closeButton.animAlphaPercent), deck_postGUI)
        end
        imports.dxDrawText(elementReference.gui["__UI_CACHE__"]["Close Button"].text.text, elementReference.gui["__UI_CACHE__"]["Close Button"].text.offsets.startX, elementReference.gui["__UI_CACHE__"]["Close Button"].text.offsets.startY, elementReference.gui["__UI_CACHE__"]["Close Button"].text.offsets.endX, elementReference.gui["__UI_CACHE__"]["Close Button"].text.offsets.endY, elementReference.gui["__UI_CACHE__"]["Close Button"].text.fontColor, elementTemplate.titleBar.fontScale or 1, elementTemplate.titleBar.font, "center", "center", true, false, deck_postGUI, false)
        if isRenderCloseButtonHover then    
            imports.dxDrawText(elementReference.gui["__UI_CACHE__"]["Close Button"].text.text, elementReference.gui["__UI_CACHE__"]["Close Button"].text.offsets.startX, elementReference.gui["__UI_CACHE__"]["Close Button"].text.offsets.startY, elementReference.gui["__UI_CACHE__"]["Close Button"].text.offsets.endX, elementReference.gui["__UI_CACHE__"]["Close Button"].text.offsets.endY, imports.tocolor(elementTemplate.titleBar.closeButton.hoverFontColor[1], elementTemplate.titleBar.closeButton.hoverFontColor[2], elementTemplate.titleBar.closeButton.hoverFontColor[3], elementTemplate.titleBar.closeButton.hoverFontColor[4]*elementReference.gui.titleBar.closeButton.animAlphaPercent), elementTemplate.titleBar.fontScale or 1, elementTemplate.titleBar.font, "center", "center", true, false, deck_postGUI, false)
        end
        imports.dxDrawRectangle(elementReference.gui["__UI_CACHE__"]["Close Button"].offsets.startX, elementReference.gui["__UI_CACHE__"]["Close Button"].offsets.startY, elementReference.gui["__UI_CACHE__"]["Deck"].divider.size, elementReference.gui["__UI_CACHE__"]["Close Button"].offsets.height, elementReference.gui["__UI_CACHE__"]["Deck"].divider.color, deck_postGUI)
        forceRenderElementRoot(elementReference.elementRoot or element, element, isElementRootToBeForceRendered)
        imports.renderElementChildren(element)
        imports.dxSetBlendMode("blend")
        if not elementParent then
            imports.dxSetRenderTarget()
        else
            imports.dxSetRenderTarget(createdElements[elementParent].gui.renderTarget)
        end
        local deck_renderTarget = elementReference.gui.renderTarget
        if deck_renderTarget and imports.isElement(deck_renderTarget) then
            imports.dxDrawImage(elementReference.gui["__UI_CACHE__"]["Deck"].view.offsets.startX, elementReference.gui["__UI_CACHE__"]["Deck"].view.offsets.startY, elementReference.gui["__UI_CACHE__"]["Deck"].view.offsets.width, elementReference.gui["__UI_CACHE__"]["Deck"].view.offsets.height, deck_renderTarget, 0, 0, 0, -1, deck_postGUI)
        end
    else
        local __mouseReference = {x = mouseReference.x, y = mouseReference.y}
        imports.renderElementChildren(element, true, mouseReference)
        local isElementHovered = CLIENT_HOVERED_ELEMENT.element == element
        local isCloseButtonHovered = false
        if isElementHovered then
            local isTitleBarClicked = false
            if imports.isKeyClicked("mouse1") then
                isTitleBarClicked = imports.isMouseOnPosition(elementReference.gui["__UI_INPUT_FETCH_CACHE__"]["Title Bar"].startX, elementReference.gui["__UI_INPUT_FETCH_CACHE__"]["Title Bar"].startY, elementReference.gui["__UI_INPUT_FETCH_CACHE__"]["Title Bar"].width, elementReference.gui["__UI_INPUT_FETCH_CACHE__"]["Title Bar"].height)
            end
            if isTitleBarClicked then
                if not elementReference.isDisabled and elementReference.isDraggable then
                    imports.attachUIElement(element)
                end
            else
                isCloseButtonHovered = imports.isMouseOnPosition(__mouseReference.x + elementReference.gui["__UI_INPUT_FETCH_CACHE__"]["Close Button"].startX, __mouseReference.y + elementReference.gui["__UI_INPUT_FETCH_CACHE__"]["Close Button"].startY, elementReference.gui["__UI_INPUT_FETCH_CACHE__"]["Close Button"].width, elementReference.gui["__UI_INPUT_FETCH_CACHE__"]["Close Button"].height)
            end
        end
        if isCloseButtonHovered then
            if imports.isKeyClicked("mouse1") then
                imports.setUIVisible(element, false)
            end
            if elementReference.gui.titleBar.closeButton.hoverStatus ~= "forward" then
                elementReference.gui.titleBar.closeButton.hoverStatus = "forward"
                elementReference.gui.titleBar.closeButton.hoverAnimTickCounter = CLIENT_CURRENT_TICK
            end
        else
            if elementReference.gui.titleBar.closeButton.hoverStatus ~= "backward" then
                elementReference.gui.titleBar.closeButton.hoverStatus = "backward"
                elementReference.gui.titleBar.closeButton.hoverAnimTickCounter = CLIENT_CURRENT_TICK
            end
        end
    end
    return true

end