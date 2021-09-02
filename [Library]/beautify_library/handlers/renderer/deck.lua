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
    forceRenderElementRoot = forceRenderElementRoot,
    renderElementChildren = renderElementChildren,
    destroyElement = destroyElement,
    unpackColor = unpackColor,
    isMouseOnPosition = isMouseOnPosition,
    getInterpolationProgress = getInterpolationProgress,
    interpolateBetween = interpolateBetween,
    dxCreateRenderTarget = dxCreateRenderTarget,
    dxSetRenderTarget = dxSetRenderTarget,
    dxSetBlendMode = dxSetBlendMode,
    dxCreateTexture = dxCreateTexture,
    dxDrawImage = dxDrawImage,
    dxDrawImageSection = dxDrawImageSection,
    dxDrawRectangle = dxDrawRectangle,
    dxDrawText = dxDrawText,
    dxGetTexturePixels = dxGetTexturePixels,
    math = {
        min = math.min
    }
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

        --if isElementToBeUpdated then
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
                elementReference.gui["__UI_CACHE__"]["Toggle Button"] = {
                    offsets = {},
                    icon = {
                        offsets = {}
                    }
                }
                elementReference.gui["__UI_INPUT_FETCH_CACHE__"]["Toggle Button"] = {}
            end
            local deck_startX, deck_startY = 0, 0
            local deck_width, deck_height = elementReference.gui.width, elementReference.gui.height
            local deck_view_width, deck_view_height = elementReference.gui.contentSection.width, elementReference.gui.contentSection.height
            local deck_titleBar_height = availableElements[elementType].titleBar.height
            local deck_toggle_arrow_icon_size = imports.math.min(deck_titleBar_height, availableElements[elementType].titleBar.toggleButton.arrowIconSize)
            local deck_toggle_arrow_icon_padding = (deck_titleBar_height - deck_toggle_arrow_icon_size)*0.5

            ------
            if elementReference.renderIndex > 1 then
                local parentChildrenIndex = createdElements[elementParent].renderIndexReference[(createdElements[elementParent].renderIndex)].children
                if parentChildrenIndex then
                    local parentPreviousChildReference = createdElements[(parentChildrenIndex[(elementReference.renderIndex - 1)].element)]
                    deck_startY = parentPreviousChildReference.gui["__UI_CACHE__"]["Deck"].startY
                end
                --TODO: ...
            end
            elementReference.gui["__UI_CACHE__"]["Deck"].startY = deck_startY + (elementReference.gui["__UI_CACHE__"]["Deck"].offsets.currentHeight or 0)
            elementReference.gui.x = deck_startX
            elementReference.gui.y = deck_startY
            -----------
            
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
            elementReference.gui["__UI_CACHE__"]["Title Bar"].offsets.height = deck_titleBar_height
            elementReference.gui["__UI_CACHE__"]["Deck"].divider.size = elementTemplate.titleBar.divider.size
            if isElementToBeReloaded then
                elementReference.gui["__UI_CACHE__"]["Deck"].divider.color = imports.tocolor(imports.unpackColor(elementTemplate.titleBar.divider.color))
                elementReference.gui["__UI_CACHE__"]["Title Bar"].text.fontColor = imports.tocolor(imports.unpackColor(elementTemplate.titleBar.fontColor))
                elementReference.gui["__UI_CACHE__"]["Toggle Button"].icon.color = imports.tocolor(imports.unpackColor(elementTemplate.titleBar.toggleButton.color))
            end
            elementReference.gui["__UI_CACHE__"]["Title Bar"].text.text = elementReference.gui.title
            elementReference.gui["__UI_CACHE__"]["Title Bar"].text.offsets.startX = elementReference.gui["__UI_CACHE__"]["Title Bar"].offsets.startX + deck_titleBar_paddingX
            elementReference.gui["__UI_CACHE__"]["Title Bar"].text.offsets.startY = elementReference.gui["__UI_CACHE__"]["Title Bar"].offsets.startY + (elementTemplate.titleBar.fontPaddingY or 0)
            elementReference.gui["__UI_CACHE__"]["Title Bar"].text.offsets.endX = elementReference.gui["__UI_CACHE__"]["Title Bar"].offsets.startX + elementReference.gui["__UI_CACHE__"]["Title Bar"].offsets.width - elementReference.gui["__UI_CACHE__"]["Title Bar"].offsets.height - deck_titleBar_paddingX
            elementReference.gui["__UI_CACHE__"]["Title Bar"].text.offsets.endY = elementReference.gui["__UI_CACHE__"]["Title Bar"].offsets.startY + elementReference.gui["__UI_CACHE__"]["Title Bar"].offsets.height
            elementReference.gui["__UI_CACHE__"]["Toggle Button"].offsets.startX = elementReference.gui["__UI_CACHE__"]["Title Bar"].offsets.startX + elementReference.gui["__UI_CACHE__"]["Title Bar"].offsets.width - elementReference.gui["__UI_CACHE__"]["Title Bar"].offsets.height
            elementReference.gui["__UI_CACHE__"]["Toggle Button"].offsets.startY = elementReference.gui["__UI_CACHE__"]["Title Bar"].offsets.startY
            elementReference.gui["__UI_CACHE__"]["Toggle Button"].offsets.width = elementReference.gui["__UI_CACHE__"]["Title Bar"].offsets.height
            elementReference.gui["__UI_CACHE__"]["Toggle Button"].offsets.height = elementReference.gui["__UI_CACHE__"]["Title Bar"].offsets.height
            elementReference.gui["__UI_CACHE__"]["Toggle Button"].icon.offsets.startX = elementReference.gui["__UI_CACHE__"]["Toggle Button"].offsets.startX + deck_toggle_arrow_icon_padding
            elementReference.gui["__UI_CACHE__"]["Toggle Button"].icon.offsets.startY = elementReference.gui["__UI_CACHE__"]["Toggle Button"].offsets.startY + deck_toggle_arrow_icon_padding
            elementReference.gui["__UI_CACHE__"]["Toggle Button"].icon.offsets.width = deck_toggle_arrow_icon_size
            elementReference.gui["__UI_CACHE__"]["Toggle Button"].icon.offsets.height = deck_toggle_arrow_icon_size
            elementReference.gui["__UI_INPUT_FETCH_CACHE__"]["Toggle Button"].startX = elementReference.gui["__UI_CACHE__"]["Toggle Button"].offsets.startX
            elementReference.gui["__UI_INPUT_FETCH_CACHE__"]["Toggle Button"].startY = elementReference.gui["__UI_CACHE__"]["Toggle Button"].offsets.startY
            elementReference.gui["__UI_INPUT_FETCH_CACHE__"]["Toggle Button"].width = elementReference.gui["__UI_CACHE__"]["Toggle Button"].offsets.width
            elementReference.gui["__UI_INPUT_FETCH_CACHE__"]["Toggle Button"].height = elementReference.gui["__UI_CACHE__"]["Toggle Button"].offsets.height

            if isElementToBeReloaded or not elementReference.gui["__UI_CACHE__"]["Deck"].renderTexture then
                if not elementReference.gui["__UI_CACHE__"]["Deck"].renderTarget then
                    elementReference.gui["__UI_CACHE__"]["Deck"].renderTarget = imports.dxCreateRenderTarget(deck_width, deck_height + 1, true)
                end
                if elementReference.gui["__UI_CACHE__"]["Deck"].renderTexture and imports.isElement(elementReference.gui["__UI_CACHE__"]["Deck"].renderTexture) then
                    imports.destroyElement(elementReference.gui["__UI_CACHE__"]["Deck"].renderTexture)
                    elementReference.gui["__UI_CACHE__"]["Deck"].renderTexture = nil
                end
                imports.dxSetRenderTarget(elementReference.gui["__UI_CACHE__"]["Deck"].renderTarget, true)
                imports.dxSetBlendMode("modulate_add")
                local deck_color, deck_titleBar_color = imports.tocolor(imports.unpackColor(elementTemplate.color)), imports.tocolor(imports.unpackColor(elementTemplate.titleBar.color))
                imports.dxDrawRectangle(0, 0, deck_width, deck_titleBar_height, deck_titleBar_color, false)
                imports.dxDrawRectangle(0, deck_titleBar_height, deck_width, deck_height - deck_titleBar_height, deck_color, false)
                imports.dxDrawRectangle(0, deck_titleBar_height, deck_width, elementReference.gui["__UI_CACHE__"]["Deck"].divider.size, elementReference.gui["__UI_CACHE__"]["Deck"].divider.color, false)
                imports.dxSetBlendMode("blend")
                if not elementParent then
                    imports.dxSetRenderTarget()
                else
                    imports.dxSetRenderTarget(createdElements[elementParent].gui.renderTarget)
                end
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
        --end

        if not elementReference.gui.titleBar.toggleButton.animRotationPercent then
            elementReference.gui.titleBar.toggleButton.animRotationPercent = 0
            elementReference.gui.titleBar.toggleButton.animRollPercent = 0
            elementReference.gui.titleBar.toggleButton.animStatus = elementReference.gui.maximized
            elementReference.gui.titleBar.toggleButton.animTickCounter = CLIENT_CURRENT_TICK
        end
        if elementReference.gui.titleBar.toggleButton.animStatus ~= elementReference.gui.maximized then
            elementReference.gui.titleBar.toggleButton.animStatus = elementReference.gui.maximized
            elementReference.gui.titleBar.toggleButton.animTickCounter = CLIENT_CURRENT_TICK
        end
        elementReference.gui.titleBar.toggleButton.interpolationProgress = imports.getInterpolationProgress(elementReference.gui.titleBar.toggleButton.animTickCounter, availableElements[elementType].titleBar.toggleButton.rollAnimDuration)
        local isToggleButtonInterpolationRendering = elementReference.gui.titleBar.toggleButton.interpolationProgress < 1
        if isElementInterpolationToBeRefreshed or isToggleButtonInterpolationRendering then
            isElementRootToBeForceRendered = isToggleButtonInterpolationRendering
            elementReference.gui.titleBar.toggleButton.rollInterpolationProgress = imports.getInterpolationProgress(elementReference.gui.titleBar.toggleButton.animTickCounter, availableElements[elementType].titleBar.toggleButton.rollAnimDuration*0.5)
            if elementReference.gui.titleBar.toggleButton.animStatus == true then
                elementReference.gui.titleBar.toggleButton.animRotationPercent = imports.interpolateBetween(elementReference.gui.titleBar.toggleButton.animRotationPercent, 0, 0, 0.5, 0, 0, elementReference.gui.titleBar.toggleButton.interpolationProgress, "InQuad")
                elementReference.gui.titleBar.toggleButton.animRollPercent = imports.interpolateBetween(elementReference.gui.titleBar.toggleButton.animRollPercent, 0, 0, 1, 0, 0, elementReference.gui.titleBar.toggleButton.rollInterpolationProgress, "InOutQuad")
            else
                elementReference.gui.titleBar.toggleButton.animRotationPercent = imports.interpolateBetween(elementReference.gui.titleBar.toggleButton.animRotationPercent, 0, 0, 0, 0, 0, elementReference.gui.titleBar.toggleButton.interpolationProgress, "InQuad")
                elementReference.gui.titleBar.toggleButton.animRollPercent = imports.interpolateBetween(elementReference.gui.titleBar.toggleButton.animRollPercent, 0, 0, 0, 0, 0, elementReference.gui.titleBar.toggleButton.rollInterpolationProgress, "InOutQuad")
            end
            elementReference.gui["__UI_CACHE__"]["Deck"].offsets.currentHeight = elementReference.gui["__UI_CACHE__"]["Title Bar"].offsets.height + ((elementReference.gui["__UI_CACHE__"]["Deck"].offsets.height - elementReference.gui["__UI_CACHE__"]["Title Bar"].offsets.height)*elementReference.gui.titleBar.toggleButton.animRollPercent)
            elementReference.gui["__UI_CACHE__"]["Deck"].view.offsets.currentHeight = elementReference.gui["__UI_CACHE__"]["Deck"].view.offsets.height*elementReference.gui.titleBar.toggleButton.animRollPercent
            elementReference.gui["__UI_CACHE__"]["Deck"].view.color = imports.tocolor(255, 255, 255, 255*elementReference.gui.titleBar.toggleButton.animRollPercent)
        end
        if elementReference.gui["__UI_CACHE__"]["Deck"].renderTexture then
            imports.dxDrawImageSection(elementReference.gui["__UI_CACHE__"]["Deck"].offsets.startX, elementReference.gui["__UI_CACHE__"]["Deck"].offsets.startY, elementReference.gui["__UI_CACHE__"]["Deck"].offsets.width, elementReference.gui["__UI_CACHE__"]["Deck"].offsets.currentHeight, 0, 0, elementReference.gui["__UI_CACHE__"]["Deck"].offsets.width, elementReference.gui["__UI_CACHE__"]["Deck"].offsets.currentHeight, elementReference.gui["__UI_CACHE__"]["Deck"].renderTexture, 0, 0, 0, -1, deck_postGUI)
        end
        imports.dxDrawText(elementReference.gui["__UI_CACHE__"]["Title Bar"].text.text, elementReference.gui["__UI_CACHE__"]["Title Bar"].text.offsets.startX, elementReference.gui["__UI_CACHE__"]["Title Bar"].text.offsets.startY, elementReference.gui["__UI_CACHE__"]["Title Bar"].text.offsets.endX, elementReference.gui["__UI_CACHE__"]["Title Bar"].text.offsets.endY, elementReference.gui["__UI_CACHE__"]["Title Bar"].text.fontColor, elementTemplate.titleBar.fontScale or 1, elementTemplate.titleBar.font, "left", "center", true, false, deck_postGUI, false)
        imports.dxDrawImage(elementReference.gui["__UI_CACHE__"]["Toggle Button"].icon.offsets.startX, elementReference.gui["__UI_CACHE__"]["Toggle Button"].icon.offsets.startY, elementReference.gui["__UI_CACHE__"]["Toggle Button"].icon.offsets.width, elementReference.gui["__UI_CACHE__"]["Toggle Button"].icon.offsets.height, createdAssets["images"]["collar/bottom.png"], 360*elementReference.gui.titleBar.toggleButton.animRotationPercent, 0, 0, elementReference.gui["__UI_CACHE__"]["Toggle Button"].icon.color, deck_postGUI)
        imports.forceRenderElementRoot(elementReference.elementRoot or element, element, isElementRootToBeForceRendered)
        imports.renderElementChildren(element)
        imports.dxSetBlendMode("blend")
        if not elementParent then
            imports.dxSetRenderTarget()
        else
            imports.dxSetRenderTarget(createdElements[elementParent].gui.renderTarget)
        end
        local deck_renderTarget = elementReference.gui.renderTarget
        if deck_renderTarget and imports.isElement(deck_renderTarget) then
            imports.dxDrawImageSection(elementReference.gui["__UI_CACHE__"]["Deck"].view.offsets.startX, elementReference.gui["__UI_CACHE__"]["Deck"].view.offsets.startY, elementReference.gui["__UI_CACHE__"]["Deck"].view.offsets.width, elementReference.gui["__UI_CACHE__"]["Deck"].view.offsets.currentHeight, 0, 0, elementReference.gui["__UI_CACHE__"]["Deck"].view.offsets.width, elementReference.gui["__UI_CACHE__"]["Deck"].view.offsets.currentHeight, deck_renderTarget, 0, 0, 0, elementReference.gui["__UI_CACHE__"]["Deck"].view.color, deck_postGUI)
        end
    else
        local __mouseReference = {x = mouseReference.x, y = mouseReference.y}
        imports.renderElementChildren(element, true, mouseReference)
        local isElementHovered = CLIENT_HOVERED_ELEMENT.element == element
        if isElementHovered then
            local isToggleButtonHovered = imports.isMouseOnPosition(__mouseReference.x + elementReference.gui["__UI_INPUT_FETCH_CACHE__"]["Toggle Button"].startX, __mouseReference.y + elementReference.gui["__UI_INPUT_FETCH_CACHE__"]["Toggle Button"].startY, elementReference.gui["__UI_INPUT_FETCH_CACHE__"]["Toggle Button"].width, elementReference.gui["__UI_INPUT_FETCH_CACHE__"]["Toggle Button"].height)
            if isToggleButtonHovered then
                if imports.isKeyClicked("mouse1") then
                    setDeckMaximized(element, not elementReference.gui.maximized)
                end
            end
        end
    end
    return true

end