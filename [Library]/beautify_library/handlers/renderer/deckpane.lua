----------------------------------------------------------------
--[[ Resource: Beautify Library
     Script: handlers: renderer: deckpane.lua
     Server: -
     Author: OvileAmriam
     Developer: -
     DOC: 01/02/2021 (OvileAmriam)
     Desc: Deck Pane Pane's Renderer ]]--
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

local elementType = "beautify_deckpane"


--------------------------------
--[[ Function: Renders Deck Pane ]]--
--------------------------------

function renderDeckPane(element, isFetchingInput, mouseReference)

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
            if not elementReference.gui["__UI_CACHE__"]["Deck Pane"] then
                elementReference.gui["__UI_CACHE__"]["Deck Pane"] = {
                    offsets = {},
                    divider = {},
                    view = {
                        offsets = {}
                    }
                }
                elementReference.gui["__UI_INPUT_FETCH_CACHE__"]["Deck Pane"] = {}
            end
            local deck_startX, deck_startY = elementReference.gui.x, elementReference.gui.y
            local deck_width, deck_height = elementReference.gui.width, elementReference.gui.height
            local deck_view_width, deck_view_height = elementReference.gui.contentSection.width, elementReference.gui.contentSection.height
            local deck_titleBar_size = availableElements[elementType].minimumSize*0.5
            local deck_toggle_arrow_icon_size = imports.math.min(deck_titleBar_size, availableElements[elementType].titleBar.toggleButton.arrowIconSize)
            local deck_toggle_arrow_icon_padding = (deck_titleBar_size - deck_toggle_arrow_icon_size)*0.5
            elementReference.gui["__UI_CACHE__"]["Deck Pane"].offsets.startX = deck_startX
            elementReference.gui["__UI_CACHE__"]["Deck Pane"].offsets.startY = deck_startY
            elementReference.gui["__UI_CACHE__"]["Deck Pane"].offsets.width = deck_width
            elementReference.gui["__UI_CACHE__"]["Deck Pane"].offsets.height = deck_height
            elementReference.gui["__UI_CACHE__"]["Deck Pane"].view.offsets.startX = elementReference.gui["__UI_CACHE__"]["Deck Pane"].offsets.startX + elementReference.gui.contentSection.startX
            elementReference.gui["__UI_CACHE__"]["Deck Pane"].view.offsets.startY = elementReference.gui["__UI_CACHE__"]["Deck Pane"].offsets.startY + elementReference.gui.contentSection.startY
            elementReference.gui["__UI_CACHE__"]["Deck Pane"].view.offsets.width = deck_view_width
            elementReference.gui["__UI_CACHE__"]["Deck Pane"].view.offsets.height = deck_view_height

            if not CLIENT_MTA_MINIMIZED then
                elementReference.gui["__UI_CACHE__"].reloadElement = nil
            end
            elementReference.gui["__UI_CACHE__"].updateElement = nil
        end

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
            imports.dxDrawImage(elementReference.gui["__UI_CACHE__"]["Deck Pane"].view.offsets.startX, elementReference.gui["__UI_CACHE__"]["Deck Pane"].view.offsets.startY, elementReference.gui["__UI_CACHE__"]["Deck Pane"].view.offsets.width, elementReference.gui["__UI_CACHE__"]["Deck Pane"].view.offsets.height, deck_renderTarget, 0, 0, 0, -1, deck_postGUI)
        end
    else
        local __mouseReference = {x = mouseReference.x, y = mouseReference.y}
        imports.renderElementChildren(element, true, mouseReference)
        local isElementHovered = CLIENT_HOVERED_ELEMENT.element == element
    end
    return true

end