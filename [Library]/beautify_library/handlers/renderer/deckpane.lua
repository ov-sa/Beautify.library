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
    manageElementForceRender = manageElementForceRender,
    renderElementChildren = renderElementChildren,
    renderScrollbar = renderScrollbar,
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

function renderDeckPane(element, isActiveMode, isFetchingInput, mouseReference)

    local elementReference = createdElements[element]
    if not isFetchingInput then
        local elementParent = imports.getUIParent(element)
        if not elementParent then imports.dxSetRenderTarget() end
        local isElementToBeRendered, isElementToBeForceRendered = true, false
        local isElementInterpolationToBeRefreshed = CLIENT_MTA_RESTORED
        local isElementToBeReloaded = (not CLIENT_MTA_MINIMIZED) and (elementReference.gui["__UI_CACHE__"].reloadElement or (CLIENT_RESOURCE_TEMPLATE_RELOAD[(elementReference.sourceResource)] and CLIENT_RESOURCE_TEMPLATE_RELOAD[(elementReference.sourceResource)][elementType]))
        local isElementToBeUpdated = isElementToBeReloaded or elementReference.gui["__UI_CACHE__"].updateElement or CLIENT_MTA_RESTORED
        local deckpane_postGUI = elementReference.gui.postGUI
        local elementTemplate = imports.__getUITemplate(elementType, elementReference.sourceResource)

        if not isElementToBeRendered then return false end
        if (isActiveMode or isElementToBeReloaded) and isElementToBeUpdated then
            if not elementReference.gui["__UI_CACHE__"]["Deckpane"] then
                elementReference.gui["__UI_CACHE__"]["Deckpane"] = {
                    offsets = {},
                    view = {
                        offsets = {}
                    }
                }
            end
            local deckpane_startX, deckpane_startY = elementReference.gui.x, elementReference.gui.y
            local deckpane_width, deckpane_height = elementReference.gui.width, elementReference.gui.height
            local deckpane_view_width, deckpane_view_height = elementReference.gui.contentSection.width, elementReference.gui.contentSection.height
            elementReference.gui["__UI_CACHE__"]["Deckpane"].offsets.startX = deckpane_startX
            elementReference.gui["__UI_CACHE__"]["Deckpane"].offsets.startY = deckpane_startY
            elementReference.gui["__UI_CACHE__"]["Deckpane"].offsets.width = deckpane_width
            elementReference.gui["__UI_CACHE__"]["Deckpane"].offsets.height = deckpane_height
            elementReference.gui["__UI_CACHE__"]["Deckpane"].view.offsets.startX = elementReference.gui["__UI_CACHE__"]["Deckpane"].offsets.startX
            elementReference.gui["__UI_CACHE__"]["Deckpane"].view.offsets.startY = elementReference.gui["__UI_CACHE__"]["Deckpane"].offsets.startY
            elementReference.gui["__UI_CACHE__"]["Deckpane"].view.offsets.width = deckpane_view_width
            elementReference.gui["__UI_CACHE__"]["Deckpane"].view.offsets.height = deckpane_view_height
            if not CLIENT_MTA_MINIMIZED then
                elementReference.gui["__UI_CACHE__"].reloadElement = nil
            end
            elementReference.gui["__UI_CACHE__"].updateElement = nil
        end

        if isActiveMode then
            elementReference.gui["__UI_INPUT_FETCH_CACHE__"]["Scroll Bars"] = {}
        end
        if elementReference.gui.renderTarget and imports.isElement(elementReference.gui.renderTarget) then
            if isActiveMode then
                local elementChildren = elementReference.renderIndexReference[(elementReference.renderIndex)].children
                imports.manageElementForceRender(element, isElementToBeForceRendered)
                imports.renderElementChildren(element, isActiveMode)
                imports.dxSetBlendMode("blend")
                if #elementChildren > 0 then
                    local lastDeckReference = createdElements[(elementChildren[(#elementChildren)].element)]
                    if lastDeckReference.gui["__UI_CACHE__"] and lastDeckReference.gui["__UI_CACHE__"]["Deck"] then
                        local deckpane_data_height = lastDeckReference.gui["__UI_CACHE__"]["Deck"].offsets.startY + lastDeckReference.gui["__UI_CACHE__"]["Deck"].offsets.currentHeight
                        local deckpane_exceeded_height = deckpane_data_height - elementReference.gui["__UI_CACHE__"]["Deckpane"].view.offsets.height
                        if deckpane_exceeded_height > 0 then
                            elementReference.gui["__UI_INPUT_FETCH_CACHE__"]["Scroll Bars"]["Vertical"] = {
                                {
                                    isDisabled = elementReference.isDisabled,
                                    elementReference = elementReference,
                                    startX = elementReference.gui["__UI_CACHE__"]["Deckpane"].view.offsets.width,
                                    startY = 0,
                                    height = elementReference.gui["__UI_CACHE__"]["Deckpane"].view.offsets.height,
                                    overflownSize = deckpane_exceeded_height,
                                    multiplier = 1,
                                    postGUI = false
                                },
                                elementReference.gui.scrollBar_Vertical
                            }
                            local _, isComponentRootToBeForceRendered = imports.renderScrollbar(element, false, false, false, elementReference.gui["__UI_INPUT_FETCH_CACHE__"]["Scroll Bars"]["Vertical"][1], elementReference.gui["__UI_INPUT_FETCH_CACHE__"]["Scroll Bars"]["Vertical"][2])
                            isElementToBeForceRendered = isElementToBeForceRendered or isComponentRootToBeForceRendered
                        end
                    end
                end
                if not elementParent then
                    imports.dxSetRenderTarget()
                else
                    imports.dxSetRenderTarget(createdElements[elementParent].gui.renderTarget)
                end
            end
            imports.dxDrawImage(elementReference.gui["__UI_CACHE__"]["Deckpane"].view.offsets.startX, elementReference.gui["__UI_CACHE__"]["Deckpane"].view.offsets.startY, elementReference.gui["__UI_CACHE__"]["Deckpane"].view.offsets.width, elementReference.gui["__UI_CACHE__"]["Deckpane"].view.offsets.height, elementReference.gui.renderTarget, 0, 0, 0, -1, deckpane_postGUI)
        end
    else
        local __mouseReference = {x = mouseReference.x, y = mouseReference.y}
        imports.renderElementChildren(element, isActiveMode, true, mouseReference)
        local isElementHovered = CLIENT_HOVERED_ELEMENT.element == element
    end
    return true

end