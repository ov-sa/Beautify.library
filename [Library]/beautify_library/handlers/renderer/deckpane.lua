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
    isElement = isElement,
    getUIParent = getUIParent,
    __getUITemplate = __getUITemplate,
    forceRenderElementRoot = forceRenderElementRoot,
    renderElementChildren = renderElementChildren,
    isMouseOnPosition = isMouseOnPosition,
    dxSetRenderTarget = dxSetRenderTarget,
    dxSetBlendMode = dxSetBlendMode,
    dxDrawImage = dxDrawImage
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
        local deckpane_postGUI = elementReference.gui.postGUI

        if isElementToBeUpdated then
            if not elementReference.gui["__UI_CACHE__"]["Deck Pane"] then
                elementReference.gui["__UI_CACHE__"]["Deck Pane"] = {
                    offsets = {},
                    view = {
                        offsets = {}
                    }
                }
            end
            local deckpane_startX, deckpane_startY = elementReference.gui.x, elementReference.gui.y
            local deckpane_width, deckpane_height = elementReference.gui.width, elementReference.gui.height
            local deckpane_view_width, deckpane_view_height = elementReference.gui.contentSection.width, elementReference.gui.contentSection.height
            elementReference.gui["__UI_CACHE__"]["Deck Pane"].offsets.startX = deckpane_startX
            elementReference.gui["__UI_CACHE__"]["Deck Pane"].offsets.startY = deckpane_startY
            elementReference.gui["__UI_CACHE__"]["Deck Pane"].offsets.width = deckpane_width
            elementReference.gui["__UI_CACHE__"]["Deck Pane"].offsets.height = deckpane_height
            elementReference.gui["__UI_CACHE__"]["Deck Pane"].view.offsets.startX = elementReference.gui["__UI_CACHE__"]["Deck Pane"].offsets.startX
            elementReference.gui["__UI_CACHE__"]["Deck Pane"].view.offsets.startY = elementReference.gui["__UI_CACHE__"]["Deck Pane"].offsets.startY
            elementReference.gui["__UI_CACHE__"]["Deck Pane"].view.offsets.width = deckpane_view_width
            elementReference.gui["__UI_CACHE__"]["Deck Pane"].view.offsets.height = deckpane_view_height

            if not CLIENT_MTA_MINIMIZED then
                elementReference.gui["__UI_CACHE__"].reloadElement = nil
            end
            elementReference.gui["__UI_CACHE__"].updateElement = nil
        end

        imports.forceRenderElementRoot(elementReference.elementRoot or element, element, isElementRootToBeForceRendered)
        imports.renderElementChildren(element)
        imports.dxSetBlendMode("blend")
        if not elementParent then
            imports.dxSetRenderTarget()
        else
            imports.dxSetRenderTarget(createdElements[elementParent].gui.renderTarget)
        end
        local deckpane_renderTarget = elementReference.gui.renderTarget
        if deckpane_renderTarget and imports.isElement(deckpane_renderTarget) then
            imports.dxDrawImage(elementReference.gui["__UI_CACHE__"]["Deck Pane"].view.offsets.startX, elementReference.gui["__UI_CACHE__"]["Deck Pane"].view.offsets.startY, elementReference.gui["__UI_CACHE__"]["Deck Pane"].view.offsets.width, elementReference.gui["__UI_CACHE__"]["Deck Pane"].view.offsets.height, deckpane_renderTarget, 0, 0, 0, -1, deckpane_postGUI)
        end
    else
        local __mouseReference = {x = mouseReference.x, y = mouseReference.y}
        imports.renderElementChildren(element, true, mouseReference)
        local isElementHovered = CLIENT_HOVERED_ELEMENT.element == element
    end
    return true

end